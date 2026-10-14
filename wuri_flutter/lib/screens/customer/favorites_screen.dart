import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/favorites_providers.dart';
import 'package:wuri_flutter/providers/space_providers.dart';
import 'package:wuri_flutter/theme/app_theme.dart';
import 'package:wuri_flutter/widgets/space_card.dart';

/// Onglet "Favoris" : les espaces gardés sur cet appareil.
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    // Les plus récents d'abord.
    final ids = ref.watch(favoritesProvider).toList().reversed.toList();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              l10n!.favoritesTitle,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ids.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 40,
                          color: AppColors.muted,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.noFavorites,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.noFavoritesBody,
                          style: const TextStyle(color: AppColors.muted),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: ids.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) =>
                        _FavoriteItem(id: ids[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteItem extends ConsumerWidget {
  const _FavoriteItem({required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spaceAsync = ref.watch(spaceByIdProvider(id));

    return spaceAsync.when(
      loading: () => const SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      ),
      // Un espace supprimé ou désactivé n'est simplement pas affiché.
      error: (error, stack) => const SizedBox.shrink(),
      data: (space) => space == null
          ? const SizedBox.shrink()
          : SpaceCard(
              space: space,
              onTap: () => context.push('/space/${space.id}'),
            ),
    );
  }
}