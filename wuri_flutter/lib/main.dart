import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'client.dart';
import 'package:wuri_flutter/app/router.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/favorites_providers.dart';
import 'package:wuri_flutter/providers/locale_provider.dart';
import 'package:wuri_flutter/theme/app_theme.dart';
import 'package:wuri_flutter/widgets/responsive_frame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const WuriApp(),
    ),
  );
}

class WuriApp extends ConsumerWidget {
  const WuriApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Wuri',
      theme: buildAppTheme(),
      themeMode: ThemeMode.light,
      routerConfig: router,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ResponsiveFrame(child: child ?? const SizedBox.shrink());
      },
    );
  }
}