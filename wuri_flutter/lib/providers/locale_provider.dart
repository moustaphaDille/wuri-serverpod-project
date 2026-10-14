import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'favorites_providers.dart';

class LocaleNotifier extends Notifier<Locale> {
  static const _key = 'app_locale';

  @override
  Locale build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedLanguage = prefs.getString(_key);
    if (savedLanguage != null) return Locale(savedLanguage);

    final systemLanguage =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    return systemLanguage == 'fr' ? const Locale('fr') : const Locale('en');
  }

  Future<void> setLanguage(String languageCode) async {
    final locale = Locale(languageCode);
    state = locale;
    await ref.read(sharedPreferencesProvider).setString(_key, languageCode);
  }
}

final localeProvider =
    NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);
