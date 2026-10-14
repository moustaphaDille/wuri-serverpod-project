import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/theme/app_theme.dart';

/// Mise en page commune des écrans de connexion et d'inscription :
/// un en-tête indigo (titre, sous-titre, progression) et une feuille sable
/// arrondie qui contient le formulaire.

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.step,
    this.totalSteps = 3,
    this.onBack,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final int? step;
  final int totalSteps;
  final VoidCallback? onBack;

  static const _overlap = 28.0;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 800;
    final headerHeight = topPadding + (step == null ? 190.0 : 220.0);

    return Scaffold(
      backgroundColor: AppColors.sand,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: headerHeight,
            child: _Header(
              topPadding: topPadding,
              title: title,
              subtitle: subtitle,
              step: step,
              totalSteps: totalSteps,
              onBack: onBack,
            ),
          ),
          Positioned.fill(
            top: headerHeight - _overlap,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.sand,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(_overlap),
                ),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 480 : double.infinity,
                  ),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 24 : 0,
                    ),
                    decoration: isDesktop
                        ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: softShadow,
                          )
                        : null,
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.fromLTRB(
                        20,
                        28,
                        20,
                        isDesktop ? 36 : 32,
                      ),
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _Header extends StatelessWidget {
  const _Header({
    required this.topPadding,
    required this.title,
    required this.subtitle,
    required this.step,
    required this.totalSteps,
    required this.onBack,
  });

  final double topPadding;
  final String title;
  final String subtitle;
  final int? step;
  final int totalSteps;
  final VoidCallback? onBack;

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
    final currentStep = step;

    return ClipRect(
      child: ColoredBox(
        color: AppColors.indigo,
        child: Stack(
          children: [
            Positioned(
              top: -60,
              right: -50,
              child: _circle(190, Colors.white.withValues(alpha: 0.06)),
            ),
            Positioned(
              bottom: -100,
              left: -70,
              child: _circle(230, AppColors.terracotta.withValues(alpha: 0.20)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, topPadding + 8, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Material(
                        color: Colors.white.withValues(alpha: 0.16),
                        shape: const CircleBorder(),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_rounded),
                          color: AppColors.sand,
                          onPressed: onBack ??
                              () => context.canPop()
                                  ? context.pop()
                                  : context.go('/profile'),
                        ),
                      ),
                      const Spacer(),
                      if (currentStep != null)
                        Text(
                          l10n.stepLabel(currentStep, totalSteps),
                          style: const TextStyle(
                            color: AppColors.border,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    ],
                  ),
                  if (currentStep != null) ...[
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        for (var i = 1; i <= totalSteps; i++) ...[
                          Expanded(
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: i <= currentStep
                                    ? AppColors.terracotta
                                    : Colors.white.withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          if (i < totalSteps) const SizedBox(width: 4),
                        ],
                      ],
                    ),
                  ],
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.sand,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.border,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}