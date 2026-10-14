import 'package:flutter/material.dart';

import 'package:wuri_flutter/theme/app_theme.dart';

/// Keeps every route usable in resizable web windows without stretching
/// content indefinitely on very wide screens.
class ResponsiveFrame extends StatelessWidget {
  const ResponsiveFrame({super.key, required this.child});

  final Widget child;

  static const maxWidth = 1440.0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.sand,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxWidth),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: child,
          ),
        ),
      ),
    );
  }
}
