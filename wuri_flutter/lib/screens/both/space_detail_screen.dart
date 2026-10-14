import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/auth_providers.dart';
import 'package:wuri_flutter/providers/space_providers.dart';
import 'package:wuri_flutter/theme/app_theme.dart';
import 'package:wuri_flutter/utils/format.dart';
import 'package:wuri_flutter/utils/snackbar.dart';
import 'package:wuri_flutter/utils/space_type_icon.dart';
import 'package:wuri_flutter/utils/space_type_label.dart';
import 'package:wuri_flutter/widgets/empty_state.dart';
import 'package:wuri_flutter/widgets/favorite_button.dart';
import 'package:wuri_flutter/widgets/space_image.dart';

class SpaceDetailScreen extends ConsumerWidget {
  const SpaceDetailScreen({super.key, required this.id});

  final int id;

  /// Décide où envoyer l'utilisateur quand il veut réserver.
  Future<void> _onBook(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final target = '/space/$id/book';
    final encoded = Uri.encodeComponent(target);

    // 1. Pas connecté : inscription ou connexion, puis retour ici.
    if (!ref.read(signedInProvider)) {
      context.push('/sign-in?redirect=$encoded');
      return;
    }

    // 2. Connecté, mais sans profil : choix du rôle, puis retour ici.
    final profile = await ref.read(profileProvider.future);
    if (!context.mounted) return;
    if (profile == null) {
      context.push('/choose-role?redirect=$encoded');
      return;
    }

    // 3. Seuls les clients réservent (le serveur le vérifie aussi).
    if (profile.role != UserRole.client) {
      showAppSnackBar(context, l10n.onlyClientsCanBook);
      return;
    }

    // 4. Tout est prêt : réservation.
    context.push(target);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final spaceAsync = ref.watch(spaceByIdProvider(id));
    final space = spaceAsync.asData?.value;
    final profile = ref.watch(profileProvider);
    final isClient = profile.asData?.value?.role == UserRole.client;

    return Scaffold(
      body: spaceAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => EmptyState(
          icon: Icons.cloud_off_rounded,
          title: l10n.errorLoading,
          actionLabel: l10n.retry,
          onAction: () => ref.invalidate(spaceByIdProvider(id)),
        ),
        data: (data) => data == null
            ? EmptyState(
                icon: Icons.search_off_rounded,
                title: l10n.spaceNotFound,
                actionLabel: l10n.navSearch,
                onAction: () => context.go('/explore'),
              )
            : _Content(space: data),
      ),
      // Seuls les clients voient l'action de réservation.
      bottomNavigationBar: space == null || !isClient
          ? null
          : Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 16,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          l10n.perNight(formatPrice(space.pricePerNight)),
                          maxLines: 2,
                          style: const TextStyle(
                            color: AppColors.terracotta,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 5,
                        child: FilledButton(
                          onPressed: () => _onBook(context, ref),
                          child: Text(l10n.bookThisSpace),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.space});

  final Space space;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            SpaceImage(
              space: space,
              height: 300,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(28),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Material(
                    color: Colors.white,
                    elevation: 3,
                    shadowColor: AppColors.shadow,
                    shape: const CircleBorder(),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      color: AppColors.indigo,
                      onPressed: () => context.canPop()
                          ? context.pop()
                          : context.go('/explore'),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: FavoriteButton(spaceId: space.id!),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                space.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.place_outlined,
                    size: 18,
                    color: AppColors.muted,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    space.city,
                    style: const TextStyle(color: AppColors.muted),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoChip(
                    icon: spaceTypeIcon(space.type),
                    label: spaceTypeLabel(l10n, space.type),
                  ),
                  _InfoChip(
                    icon: Icons.people_outline_rounded,
                    label: l10n.maxGuests(space.maxGuests),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                l10n.descriptionTitle,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                space.description,
                style: TextStyle(
                  height: 1.55,
                  color: AppColors.indigo.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: softShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.indigo),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
