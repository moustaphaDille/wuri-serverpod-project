import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import '../profile/host_guard.dart';

/// Outils de l'administrateur. Réservé aux utilisateurs connectés.
class AdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Devient administrateur en donnant le code secret du serveur.
  /// Le code est lu dans config/passwords.yaml (clé `adminSecret`).
  Future<AppUser> claimAdmin(Session session, String secret) async {
    final expected = session.passwords['adminSecret'];
    if (expected == null || expected.isEmpty) {
      throw AppException(message: 'Admin access is not configured.');
    }
    if (secret != expected) {
      throw AppException(message: 'Invalid admin code.');
    }

    final profile = await requireProfile(session);
    if (profile.role == UserRole.admin) return profile;

    return AppUser.db.updateRow(
      session,
      profile.copyWith(role: UserRole.admin),
    );
  }

  /// Les demandes des partenaires, les plus récentes d'abord.
  /// Sans filtre : toutes. Avec [status] : seulement ce statut.
  Future<List<AdminApplication>> listApplications(
    Session session, {
    ApplicationStatus? status,
  }) async {
    await requireAdmin(session);

    final applications = status == null
        ? await PartnerApplication.db.find(
            session,
            orderBy: (t) => t.createdAt.desc(),
          )
        : await PartnerApplication.db.find(
            session,
            where: (t) => t.status.equals(status),
            orderBy: (t) => t.createdAt.desc(),
          );
    if (applications.isEmpty) return [];

    final owners = await AppUser.db.find(
      session,
      where: (t) => t.id.inSet(applications.map((a) => a.appUserId).toSet()),
    );
    final ownerById = {for (final o in owners) o.id!: o};

    return [
      for (final a in applications)
        if (ownerById[a.appUserId] != null)
          AdminApplication(
            application: a,
            ownerFirstName: ownerById[a.appUserId]!.firstName,
            ownerLastName: ownerById[a.appUserId]!.lastName,
            ownerPhone: ownerById[a.appUserId]!.phone,
          ),
    ];
  }

  /// Approuve ou refuse une demande en attente.
  Future<PartnerApplication> reviewApplication(
    Session session, {
    required int applicationId,
    required bool approve,
    String? reason,
  }) async {
    await requireAdmin(session);

    final application = await PartnerApplication.db.findById(
      session,
      applicationId,
    );
    if (application == null) {
      throw AppException(message: 'Application not found.');
    }
    if (application.status != ApplicationStatus.pending) {
      throw AppException(message: 'This application was already reviewed.');
    }

    final cleanReason = reason?.trim();

    return PartnerApplication.db.updateRow(
      session,
      application.copyWith(
        status: approve
            ? ApplicationStatus.approved
            : ApplicationStatus.rejected,
        rejectionReason: approve || cleanReason == null || cleanReason.isEmpty
            ? null
            : cleanReason,
        reviewedAt: DateTime.now().toUtc(),
      ),
    );
  }

  /// Tous les profils, avec l'état d'activation de leur compte auth.
  Future<List<AppUser>> listUsers(Session session) async {
    await requireAdmin(session);

    final users = await AppUser.db.find(
      session,
      include: AppUser.include(authUser: AuthUser.include()),
      orderBy: (t) => t.createdAt.desc(),
    );
    session.log('[admin-users] profiles returned=${users.length}');
    return users;
  }

  /// Active ou désactive un compte client. Les partenaires sont gérés par
  /// leur demande de vérification et ne peuvent pas être bloqués ici.
  Future<AppUser> setClientBlocked(
    Session session, {
    required int userId,
    required bool blocked,
  }) async {
    await requireAdmin(session);

    final user = await AppUser.db.findById(
      session,
      userId,
      include: AppUser.include(authUser: AuthUser.include()),
    );
    if (user == null) {
      throw AppException(message: 'User not found.');
    }
    if (user.role != UserRole.client) {
      throw AppException(message: 'Only client accounts can be changed.');
    }

    await AuthServices.instance.authUsers.update(
      session,
      authUserId: user.authUserId,
      blocked: blocked,
    );

    final updated = await AppUser.db.findById(
      session,
      userId,
      include: AppUser.include(authUser: AuthUser.include()),
    );
    if (updated == null) {
      throw AppException(message: 'User not found after update.');
    }
    return updated;
  }
}
