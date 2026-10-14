import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/providers/auth_providers.dart';

/// Où envoyer l'utilisateur juste après sa connexion ou son inscription.
/// Utilisé par l'écran de création de compte ET par l'écran de connexion,
/// pour que le comportement soit identique dans les deux cas.
Future<void> goAfterSignIn(
  BuildContext context,
  WidgetRef ref,
  String? redirect,
) async {
  final profile = await ref.read(profileProvider.future);
  if (!context.mounted) return;

  // Compte sans profil : on reprend au choix du rôle.
  if (profile == null) {
    final suffix =
        redirect == null ? '' : '?redirect=${Uri.encodeComponent(redirect)}';
    context.pushReplacement('/choose-role$suffix');
    return;
  }

  // Partenaire qui n'a pas encore décrit son établissement.
  if (profile.role == UserRole.partner) {
    final application = await ref.read(applicationProvider.future);
    if (!context.mounted) return;
    if (application == null) {
      context.pushReplacement('/partner/business');
      return;
    }
  }

  // Seuls les clients retournent à une réservation en cours.
  if (redirect == null || profile.role != UserRole.client) {
    context.go('/profile');
  } else {
    context.pushReplacement(redirect);
  }
}