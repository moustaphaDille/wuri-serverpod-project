import 'package:flutter/material.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/theme/app_theme.dart';

/// Écran provisoire : sera remplacé par le vrai contenu dans les blocs suivants.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              l10n!.comingSoon,
              style: const TextStyle(color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}