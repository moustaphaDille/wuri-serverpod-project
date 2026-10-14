import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';


import '../generated/protocol.dart';

/// Renvoie le profil de l'utilisateur connecté (erreur s'il n'existe pas).
Future<AppUser> requireProfile(Session session) async {
  final authUserId = session.authenticated!.authUserId;

  final profile = await AppUser.db.findFirstRow(
    session,
    where: (t) => t.authUserId.equals(authUserId),
  );

  if (profile == null) {
    throw AppException(message: 'Create your profile first.');
  }
  return profile;
}

/// Comme [requireProfile], mais exige un compte client.
Future<AppUser> requireClient(Session session) async {
  final profile = await requireProfile(session);
  if (profile.role != UserRole.client) {
    throw AppException(message: 'Only client accounts can book a space.');
  }
  return profile;
}

/// Comme [requireProfile], mais exige un compte administrateur.
Future<AppUser> requireAdmin(Session session) async {
  final profile = await requireProfile(session);
  if (profile.role != UserRole.admin) {
    throw AppException(message: 'Admin access required.');
  }
  return profile;
}

/// Exige un partenaire DONT LA DEMANDE EST APPROUVÉE.
/// Garde le même nom qu'avant : les endpoints d'espaces et de demandes
/// de réservation qui l'utilisent n'ont donc pas à changer.
Future<AppUser> requireHostProfile(Session session) async {
  final profile = await requireProfile(session);
  if (profile.role != UserRole.partner) {
    throw AppException(message: 'Partner account required.');
  }

  final application = await PartnerApplication.db.findFirstRow(
    session,
    where: (t) => t.appUserId.equals(profile.id!),
  );
  if (application == null || application.status != ApplicationStatus.approved) {
    throw AppException(message: 'Your partner account is not verified yet.');
  }
  return profile;
}