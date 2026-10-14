import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/auth_providers.dart';
import 'package:wuri_flutter/utils/snackbar.dart';

/// Page de connexion ou d'inscription (le widget de Serverpod gère le compte).
/// [redirect] est la page où revenir une fois connecté (par exemple la réservation).
class SignInPage extends ConsumerWidget {
  const SignInPage({super.key, this.redirect});

  final String? redirect;

  Future<void> _afterSignIn(BuildContext context, WidgetRef ref) async {
    final profile = await ref.read(profileProvider.future);
    if (!context.mounted) return;

    // Compte créé, mais pas encore de profil : on commence par le choix du rôle.
    if (profile == null) {
      final suffix = redirect == null
          ? ''
          : '?redirect=${Uri.encodeComponent(redirect!)}';
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

    if (redirect == null) {
      context.go('/profile');
    } else {
      context.pushReplacement(redirect!);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    // Dès que l'utilisateur devient connecté, on le fait avancer.
    ref.listen<bool>(signedInProvider, (previous, next) {
      if (next) _afterSignIn(context, ref);
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n!.signInTitle)),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 700;
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 32 : 16,
                  vertical: isWide ? 40 : 20,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.all(isWide ? 32 : 20),
                      child: SignInWidget(
                        client: client,
                        onAuthenticated: () {
                          // La navigation est gérée par l'écouteur ci-dessus.
                        },
                        onError: (error) =>
                            showAppSnackBar(context, '$error'),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}