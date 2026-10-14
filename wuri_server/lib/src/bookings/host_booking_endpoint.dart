import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../profile/host_guard.dart';
import 'booking_endpoint.dart' show hasAcceptedOverlap;

/// Demandes reçues par un hôte. Réservé aux utilisateurs connectés.
class HostBookingEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Les demandes de réservation pour les espaces de l'hôte connecté.
  Future<List<HostBookingRequest>> listRequests(Session session) async {
    final host = await requireHostProfile(session);

    final spaces = await Space.db.find(
      session,
      where: (t) => t.ownerId.equals(host.id!),
    );
    if (spaces.isEmpty) return [];

    final spaceById = {for (final s in spaces) s.id!: s};
    final bookings = await Booking.db.find(
      session,
      where: (t) => t.placeId.inSet(spaceById.keys.toSet()),
      orderBy: (t) => t.createdAt.desc(),
    );
    if (bookings.isEmpty) return [];

    final guests = await AppUser.db.find(
      session,
      where: (t) => t.id.inSet(bookings.map((b) => b.guestId).toSet()),
    );
    final guestById = {for (final g in guests) g.id!: g};

    return [
      for (final b in bookings)
        if (guestById[b.guestId] != null)
          HostBookingRequest(
            booking: b,
            spaceName: spaceById[b.placeId]!.name,
            guestFirstName: guestById[b.guestId]!.firstName,
            guestLastName: guestById[b.guestId]!.lastName,
          ),
    ];
  }

  /// Accepte ou refuse une demande en attente.
  Future<Booking> respondToBooking(
    Session session, {
    required int bookingId,
    required bool accept,
  }) async {
    final host = await requireHostProfile(session);

    final booking = await Booking.db.findById(session, bookingId);
    if (booking == null) {
      throw AppException(message: 'Booking not found.');
    }

    final space = await Space.db.findById(session, booking.placeId);
    if (space == null || space.ownerId != host.id) {
      // Même message : on ne révèle pas l'existence d'une réservation d'autrui.
      throw AppException(message: 'Booking not found.');
    }
    if (booking.status != BookingStatus.pending) {
      throw AppException(message: 'This request was already handled.');
    }

    if (accept) {
      final taken = await hasAcceptedOverlap(
        session,
        placeId: booking.placeId,
        checkIn: booking.checkIn,
        checkOut: booking.checkOut,
        excludeBookingId: booking.id,
      );
      if (taken) {
        throw AppException(
          message: 'Another accepted booking already uses these dates.',
        );
      }
    }

    return Booking.db.updateRow(
      session,
      booking.copyWith(
        status: accept ? BookingStatus.accepted : BookingStatus.declined,
      ),
    );
  }
}