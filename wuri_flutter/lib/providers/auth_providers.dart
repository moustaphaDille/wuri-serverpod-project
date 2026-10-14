import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/client.dart';

/// Vrai si un utilisateur est connecté. Se met à jour tout seul à chaque
/// connexion ou déconnexion, grâce à l'écouteur du client Serverpod.
class SignedInNotifier extends Notifier<bool> {
  @override
  bool build() {
    final listenable = client.auth.authInfoListenable;

    void onChange() => state = client.auth.isAuthenticated;

    listenable.addListener(onChange);
    ref.onDispose(() => listenable.removeListener(onChange));

    return client.auth.isAuthenticated;
  }
}

final signedInProvider =
    NotifierProvider<SignedInNotifier, bool>(SignedInNotifier.new);

/// Le profil (nom, prénom, téléphone, rôle) de l'utilisateur connecté.
/// Vaut null s'il n'est pas connecté, ou s'il n'a pas encore de profil.
final profileProvider = FutureProvider<AppUser?>((ref) async {
  final signedIn = ref.watch(signedInProvider);
  if (!signedIn) return null;
  return client.profile.getMyProfile();
});

/// La demande de vérification du partenaire connecté.
/// Vaut null pour un non-partenaire, ou si la demande n'est pas encore envoyée.
final applicationProvider = FutureProvider<PartnerApplication?>((ref) async {
  final profile = await ref.watch(profileProvider.future);
  if (profile == null || profile.role != UserRole.partner) return null;
  return client.partner.getMyApplication();
});