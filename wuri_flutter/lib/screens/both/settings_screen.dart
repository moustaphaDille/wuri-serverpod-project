import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/locale_provider.dart';
import 'package:wuri_flutter/theme/app_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final language = ref.watch(localeProvider).languageCode;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.language,
                    color: AppColors.terracotta,
                  ),
                  title: Text(l10n.languageLabel),
                  subtitle: Text(language == 'fr' ? 'Français' : 'English'),
                ),
                ListTile(
                  leading: Icon(
                    language == 'fr'
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                  ),
                  title: const Text('Français'),
                  onTap: () =>
                      ref.read(localeProvider.notifier).setLanguage('fr'),
                ),
                ListTile(
                  leading: Icon(
                    language == 'en'
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                  ),
                  title: const Text('English'),
                  onTap: () =>
                      ref.read(localeProvider.notifier).setLanguage('en'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
