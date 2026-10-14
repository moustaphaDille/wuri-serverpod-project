import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// Gère le profil (nom, prénom, téléphone, rôle) de l'utilisateur connecté.
class ProfileEndpoint extends Endpoint {
  // Toutes les méthodes de cette classe exigent un utilisateur connecté.
  @override
  bool get requireLogin => true;

  /// Vrai si l'email du compte connecté est celui de l'administrateur défini
  /// dans config/passwords.yaml (clé `adminEmail`). L'email vient de la table
  /// des comptes email, où Serverpod l'a vérifié par un code.
  Future<bool> _hasAdminEmail(Session session) async {
    final configured = session.passwords['adminEmail']?.trim().toLowerCase();
    if (configured == null || configured.isEmpty) {
      session.log('[admin-check] adminEmail is NOT set in passwords.yaml');
      return false;
    }

    final profiles = await AuthServices.instance.userProfiles.admin
        .listUserProfiles(
          session,
          email: configured,
          limit: 1,
        );
    final isAdmin = profiles.any(
      (profile) =>
          profile.authUserId == session.authenticated!.authUserId,
    );

    session.log('[admin-check] configured email matched=$isAdmin');

    return isAdmin;
  }

  /// Renvoie le profil de l'utilisateur connecté, ou null s'il n'existe pas encore.
  Future<AppUser?> getMyProfile(Session session) async {
    final authUserId = session.authenticated!.authUserId;

    final profile = await AppUser.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (profile == null) return null;

    // Le compte de l'administrateur est promu automatiquement.
    if (profile.role != UserRole.admin && await _hasAdminEmail(session)) {
      return AppUser.db.updateRow(
        session,
        profile.copyWith(role: UserRole.admin),
      );
    }
    return profile;
  }

  /// Crée le profil de l'utilisateur connecté (une seule fois).
  /// Le rôle choisi ne peut être que client ou partenaire. Seul l'email
  /// configuré donne le rôle administrateur.
  Future<AppUser> createMyProfile(
    Session session,
    String firstName,
    String lastName,
    String phone,
    String language,
    UserRole role,
  ) async {
    final authUserId = session.authenticated!.authUserId;

    final first = firstName.trim();
    final last = lastName.trim();
    final cleanPhone = phone.replaceAll(' ', '');

    if (first.isEmpty || last.isEmpty) {
      throw AppException(message: 'First name and last name are required.');
    }
    if (!RegExp(r'^\+?[0-9]{8,15}$').hasMatch(cleanPhone)) {
      throw AppException(message: 'Invalid phone number.');
    }
    if (language != 'en' && language != 'fr') {
      throw AppException(message: 'Unsupported language.');
    }
    if (role != UserRole.client && role != UserRole.partner) {
      throw AppException(message: 'Invalid account type.');
    }

    final existing = await AppUser.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (existing != null) {
      throw AppException(message: 'Profile already exists.');
    }

    final profile = AppUser(
      authUserId: authUserId,
      firstName: first,
      lastName: last,
      phone: cleanPhone,
      role: await _hasAdminEmail(session) ? UserRole.admin : role,
      language: language,
      createdAt: DateTime.now().toUtc(),
    );

    return AppUser.db.insertRow(session, profile);
  }

  Future<AppUser> updateMyProfile(
    Session session,
    String firstName,
    String lastName,
    String phone,
    String language,
  ) async {
    final authUserId = session.authenticated!.authUserId;
    final profile = await AppUser.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (profile == null) {
      throw AppException(message: 'Profile not found.');
    }

    final first = firstName.trim();
    final last = lastName.trim();
    final cleanPhone = phone.replaceAll(' ', '');
    if (first.isEmpty || last.isEmpty) {
      throw AppException(message: 'First name and last name are required.');
    }
    if (!RegExp(r'^\+?[0-9]{8,15}$').hasMatch(cleanPhone)) {
      throw AppException(message: 'Invalid phone number.');
    }
    if (language != 'en' && language != 'fr') {
      throw AppException(message: 'Unsupported language.');
    }

    return AppUser.db.updateRow(
      session,
      profile.copyWith(
        firstName: first,
        lastName: last,
        phone: cleanPhone,
        language: language,
      ),
    );
  }
}