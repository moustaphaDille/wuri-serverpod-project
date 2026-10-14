import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/auth_providers.dart';
import 'package:wuri_flutter/providers/favorites_providers.dart';
import 'package:wuri_flutter/theme/app_theme.dart';

/// Le cœur des favoris. Visible seulement pour un client connecté
/// (seuls les clients ont l'onglet Favoris).
class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({super.key, required this.spaceId});

  final int spaceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final signedIn = ref.watch(signedInProvider);
    final profile = ref.watch(profileProvider).asData?.value;
    if (!signedIn || profile?.role != UserRole.client) {
      return const SizedBox.shrink();
    }

    final isFavorite = ref.watch(favoritesProvider).contains(spaceId);

    return Material(
      color: Colors.white,
      elevation: 3,
      shadowColor: AppColors.shadow,
      shape: const CircleBorder(),
      child: IconButton(
        visualDensity: VisualDensity.compact,
        tooltip: isFavorite ? l10n.removeFavorite : l10n.addFavorite,
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? AppColors.terracotta : AppColors.indigo,
        ),
        onPressed: () => ref.read(favoritesProvider.notifier).toggle(spaceId),
      ),
    );
  }
}