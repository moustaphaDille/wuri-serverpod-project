import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/theme/app_theme.dart';

/// Écran affiché à chaque ouverture de l'app.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) context.go('/explore');
    });
  }

  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.indigo,
      body: Stack(
        children: [
          // Deux grands cercles discrets pour donner de la profondeur.
          Positioned(
            top: -90,
            right: -70,
            child: _circle(260, Colors.white.withValues(alpha: 0.06)),
          ),
          Positioned(
            bottom: -120,
            left: -90,
            child: _circle(320, AppColors.terracotta.withValues(alpha: 0.18)),
          ),
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              builder: (context, value, child) => Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 14 * (1 - value)),
                  child: child,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.appName,
                    style: const TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      color: AppColors.sand,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.terracotta,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    l10n.tagline,
                    style: const TextStyle(
                      color: AppColors.border,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}