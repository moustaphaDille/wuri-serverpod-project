import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../profile/host_guard.dart';
import 'booking_rules.dart';

/// Réservations vues par le client. Réservé aux utilisateurs connectés.
class BookingEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const int maxNights = 30;

  /// Crée une demande de réservation (statut "pending").
  /// Seuls les comptes clients peuvent réserver.
  Future<Booking> createBooking(
    Session session, {
    required int placeId,
    required DateTime checkIn,
    required DateTime checkOut,
    required int guests,
  }) async {
    final guest = await requireClient(session);

    final space = await Space.db.findById(session, placeId);
    if (space == null || !space.isActive) {
      throw AppException(message: 'This space is not available.');
    }
    if (space.ownerId == guest.id) {
      throw AppException(message: 'You cannot book your own space.');
    }

    final today = dateOnly(DateTime.now());
    final nights = nightsBetween(checkIn, checkOut);

    if (dateOnly(checkIn).isBefore(today)) {
      throw AppException(message: 'Check-in cannot be in the past.');
    }
    if (nights < 1) {
      throw AppException(message: 'Check-out must be after check-in.');
    }
    if (nights > maxNights) {
      throw AppException(message: 'Maximum stay is $maxNights nights.');
    }
    if (guests < 1 || guests > space.maxGuests) {
      throw AppException(
        message: 'This space accepts 1 to ${space.maxGuests} guests.',
      );
    }

    final taken = await hasAcceptedOverlap(
      session,
      placeId: placeId,
      checkIn: checkIn,
      checkOut: checkOut,
    );
    if (taken) {
      throw AppException(message: 'These dates are no longer available.');
    }

    final booking = Booking(
      placeId: placeId,
      guestId: guest.id!,
      checkIn: dateOnly(checkIn),
      checkOut: dateOnly(checkOut),
      guests: guests,
      totalPrice: computeTotal(space.pricePerNight, nights),
      currency: space.currency,
      status: BookingStatus.pending,
      paymentMethod: PaymentMethod.payAtProperty,
      createdAt: DateTime.now().toUtc(),
    );

    return Booking.db.insertRow(session, booking);
  }

  /// Les réservations du client connecté, avec l'espace concerné.
  Future<List<MyBooking>> listMyBookings(Session session) async {
    final guest = await requireProfile(session);

    final bookings = await Booking.db.find(
      session,
      where: (t) => t.guestId.equals(guest.id!),
      orderBy: (t) => t.createdAt.desc(),
    );
    if (bookings.isEmpty) return [];

    final spaceIds = bookings.map((b) => b.placeId).toSet();
    final spaces = await Space.db.find(
      session,
      where: (t) => t.id.inSet(spaceIds),
    );
    final spaceById = {for (final s in spaces) s.id!: s};

    return [
      for (final b in bookings)
        if (spaceById[b.placeId] != null)
          MyBooking(booking: b, space: spaceById[b.placeId]!),
    ];
  }

  /// Annule une réservation (en attente ou acceptée) du client connecté.
  Future<Booking> cancelBooking(Session session, int bookingId) async {
    final guest = await requireProfile(session);

    final booking = await Booking.db.findById(session, bookingId);
    if (booking == null || booking.guestId != guest.id) {
      throw AppException(message: 'Booking not found.');
    }
    if (booking.status != BookingStatus.pending &&
        booking.status != BookingStatus.accepted) {
      throw AppException(message: 'This booking cannot be cancelled.');
    }

    return Booking.db.updateRow(
      session,
      booking.copyWith(status: BookingStatus.cancelled),
    );
  }
}

/// Vrai si une réservation ACCEPTÉE chevauche déjà ces dates pour cet espace.
/// [excludeBookingId] sert à ignorer la réservation qu'on est en train d'accepter.
Future<bool> hasAcceptedOverlap(
  Session session, {
  required int placeId,
  required DateTime checkIn,
  required DateTime checkOut,
  int? excludeBookingId,
}) async {
  final accepted = await Booking.db.find(
    session,
    where: (t) =>
        t.placeId.equals(placeId) & t.status.equals(BookingStatus.accepted),
  );

  return accepted.any(
    (b) =>
        b.id != excludeBookingId &&
        datesOverlap(checkIn, checkOut, b.checkIn, b.checkOut),
  );
}