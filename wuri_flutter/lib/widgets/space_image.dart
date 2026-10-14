import 'package:flutter/material.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/theme/app_theme.dart';
import 'package:wuri_flutter/utils/space_type_icon.dart';

/// La première photo d'un espace. Sans photo (ou si elle ne charge pas),
/// un fond chaleureux avec l'icône du type d'espace.
class SpaceImage extends StatelessWidget {
  const SpaceImage({
    super.key,
    required this.space,
    required this.height,
    this.borderRadius = BorderRadius.zero,
  });

  final Space space;
  final double height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final placeholder = DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.sandDeep, AppColors.terracottaTint],
        ),
      ),
      child: Center(
        child: Icon(
          spaceTypeIcon(space.type),
          size: 44,
          color: AppColors.terracotta.withValues(alpha: 0.55),
        ),
      ),
    );

    final url = space.photoUrls.isEmpty ? null : space.photoUrls.first;

    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            placeholder,
            if (url != null)
              Image.network(
                url,
                fit: BoxFit.cover,
                // La photo apparaît en fondu quand elle est chargée.
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    child: child,
                  );
                },
                errorBuilder: (context, error, stackTrace) => placeholder,
              ),
          ],
        ),
      ),
    );
  }
}