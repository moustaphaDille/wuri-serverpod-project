import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../profile/host_guard.dart';

/// Demande de vérification d'un partenaire. Réservé aux utilisateurs connectés.
class PartnerEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// La demande du partenaire connecté (null s'il n'en a pas encore envoyé).
  Future<PartnerApplication?> getMyApplication(Session session) async {
    final profile = await requireProfile(session);

    return PartnerApplication.db.findFirstRow(
      session,
      where: (t) => t.appUserId.equals(profile.id!),
    );
  }

  /// Envoie la demande de vérification (une seule fois).
  Future<PartnerApplication> submitApplication(
    Session session, {
    required String businessName,
    required SpaceType businessType,
    required String city,
    required String address,
    required String registrationNumber,
  }) async {
    final profile = await requireProfile(session);

    if (profile.role != UserRole.partner) {
      throw AppException(message: 'Only partner accounts can apply.');
    }

    final existing = await PartnerApplication.db.findFirstRow(
      session,
      where: (t) => t.appUserId.equals(profile.id!),
    );
    if (existing != null) {
      throw AppException(message: 'Your application was already submitted.');
    }

    final name = businessName.trim();
    final cleanCity = city.trim();
    final cleanAddress = address.trim();
    final registration = registrationNumber.trim();

    if (name.isEmpty || cleanCity.isEmpty || cleanAddress.isEmpty) {
      throw AppException(
        message: 'Business name, city and address are required.',
      );
    }
    if (registration.length < 3 || registration.length > 50) {
      throw AppException(message: 'Invalid registration number.');
    }

    final application = PartnerApplication(
      appUserId: profile.id!,
      businessName: name,
      businessType: businessType,
      city: cleanCity,
      address: cleanAddress,
      registrationNumber: registration,
      status: ApplicationStatus.pending,
      createdAt: DateTime.now().toUtc(),
    );

    return PartnerApplication.db.insertRow(session, application);
  }
}