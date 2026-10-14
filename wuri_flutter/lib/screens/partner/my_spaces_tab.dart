import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/auth_providers.dart';
import 'package:wuri_flutter/screens/partner/host_spaces_screen.dart';
import 'package:wuri_flutter/theme/app_theme.dart';

/// Onglet "Mes espaces" d'un partenaire : la vraie liste si son compte est
/// vÃ©rifiÃ©, sinon un Ã©cran verrouillÃ©.
class MySpacesTab extends ConsumerWidget {
  const MySpacesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final application = ref.watch(applicationProvider);

    return application.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text(l10n!.errorLoading)),
      ),
      data: (a) {
        if (a?.status == ApplicationStatus.approved) {
          return const HostSpacesScreen();
        }

        return Scaffold(
          appBar: AppBar(title: Text(l10n!.hostSpacesTitle)),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.lock_outline,
                    size: 40,
                    color: AppColors.muted,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.spacesLockedTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.spacesLockedBody,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.muted),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}