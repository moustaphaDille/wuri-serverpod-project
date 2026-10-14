
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
  const SpaceDetailScreen({
    super.key,
    required this.id,
  });

  final int id;

  Future<void> _onBook(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final target = '/space/$id/book';
    final encoded = Uri.encodeComponent(target);

    if (!ref.read(signedInProvider)) {
      context.push('/sign-in?redirect=$encoded');
      return;
    }

    final profile = await ref.read(profileProvider.future);
    if (!context.mounted) return;

    if (profile == null) {
      context.push('/choose-role?redirect=$encoded');
      return;
    }

    if (profile.role != UserRole.client) {
      showAppSnackBar(context, l10n.onlyClientsCanBook);
      return;
    }

    context.push(target);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final spaceAsync = ref.watch(spaceByIdProvider(id));
    final profile = ref.watch(profileProvider);
    final space = spaceAsync.asData?.value;
    final signedIn = ref.watch(signedInProvider);
    final isClient =
        profile.asData?.value?.role == UserRole.client;
    final canBook = !signedIn || isClient;

    final isWide = MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      body: spaceAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => EmptyState(
          icon: Icons.cloud_off_rounded,
          title: l10n.errorLoading,
          actionLabel: l10n.retry,
          onAction: () => ref.invalidate(spaceByIdProvider(id)),
        ),
        data: (data) {
          if (data == null) {
            return EmptyState(
              icon: Icons.search_off_rounded,
              title: l10n.spaceNotFound,
              actionLabel: l10n.navSearch,
              onAction: () => context.go('/explore'),
            );
          }

          return _Content(
            space: data,
            isWide: isWide,
            canBook: canBook,
            onBook: () => _onBook(context, ref),
          );
        },
      ),
      // Sur mobile, la réservation reste accessible en bas.
      // Sur ordinateur, elle apparaît dans le panneau latéral.
      bottomNavigationBar:
          space == null || !canBook || isWide
              ? null
              : _MobileBookingBar(
                  space: space,
                  onBook: () => _onBook(context, ref),
                ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.space,
    required this.isWide,
    required this.canBook,
    required this.onBook,
  });

  final Space space;
  final bool isWide;
  final bool canBook;
  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              isWide ? 28 : 0,
              isWide ? 24 : 0,
              isWide ? 28 : 0,
              isWide ? 40 : 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _HeroImage(
                  space: space,
                  isWide: isWide,
                ),
                SizedBox(height: isWide ? 28 : 20),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 7,
                        child: _SpaceInformation(
                          space: space,
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            if (canBook)
                              _DesktopBookingCard(
                                space: space,
                                onBook: onBook,
                              ),
                            const SizedBox(height: 20),
                            _SpaceHighlights(space: space),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        _SpaceInformation(space: space),
                        const SizedBox(height: 24),
                        _SpaceHighlights(space: space),
                      ],
                    ),
                  ),
                if (isWide && !canBook) ...[
                  const SizedBox(height: 24),
                  _SpaceInformationFooter(space: space),
                ],
                if (!isWide && canBook)
                  const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({
    required this.space,
    required this.isWide,
  });

  final Space space;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isWide ? 420 : 280,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SpaceImage(
            space: space,
            height: isWide ? 420 : 280,
            borderRadius: BorderRadius.circular(
              isWide ? 24 : 0,
            ).copyWith(
              bottomLeft: const Radius.circular(24),
              bottomRight: const Radius.circular(24),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _CircleAction(
                  icon: Icons.arrow_back_rounded,
                  tooltip: 'Retour',
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/explore');
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FavoriteButton(spaceId: space.id!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 3,
      shadowColor: AppColors.shadow,
      shape: const CircleBorder(),
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: AppColors.indigo,
        ),
      ),
    );
  }
}

class _SpaceInformation extends StatelessWidget {
  const _SpaceInformation({
    required this.space,
  });

  final Space space;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          space.name,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.place_outlined,
              size: 20,
              color: AppColors.muted,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                space.city,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.muted,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
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
        const SizedBox(height: 28),
        Text(
          l10n.descriptionTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          space.description,
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.7,
            color: AppColors.indigo.withValues(alpha: 0.85),
          ),
        ),
      ],
    );
  }
}

class _SpaceHighlights extends StatelessWidget {
  const _SpaceHighlights({
    required this.space,
  });

  final Space space;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.sandDeep.withValues(alpha: 0.7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informations',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 18),
          _HighlightRow(
            icon: spaceTypeIcon(space.type),
            title: spaceTypeLabel(l10n, space.type),
          ),
          const SizedBox(height: 16),
          _HighlightRow(
            icon: Icons.people_outline_rounded,
            title: l10n.maxGuests(space.maxGuests),
          ),
          const SizedBox(height: 16),
          _HighlightRow(
            icon: Icons.location_city_outlined,
            title: space.city,
          ),
        ],
      ),
    );
  }
}

class _HighlightRow extends StatelessWidget {
  const _HighlightRow({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 21,
          color: AppColors.terracotta,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

class _DesktopBookingCard extends StatelessWidget {
  const _DesktopBookingCard({
    required this.space,
    required this.onBook,
  });

  final Space space;
  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.perNight(
                formatPrice(space.pricePerNight),
              ),
              style: theme.textTheme.headlineSmall?.copyWith(
                color: AppColors.terracotta,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.maxGuests(space.maxGuests),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.muted,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: onBook,
                child: Text(l10n.bookThisSpace),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpaceInformationFooter extends StatelessWidget {
  const _SpaceInformationFooter({
    required this.space,
  });

  final Space space;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Align(
      alignment: Alignment.centerLeft,
      child: _InfoChip(
        icon: spaceTypeIcon(space.type),
        label: spaceTypeLabel(l10n, space.type),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.sandDeep.withValues(alpha: 0.7),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.indigo,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              softWrap: true,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileBookingBar extends StatelessWidget {
  const _MobileBookingBar({
    required this.space,
    required this.onBook,
  });

  final Space space;
  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
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
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 340) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.perNight(
                        formatPrice(space.pricePerNight),
                      ),
                      style: const TextStyle(
                        color: AppColors.terracotta,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FilledButton(
                      onPressed: onBook,
                      child: Text(l10n.bookThisSpace),
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.perNight(
                        formatPrice(space.pricePerNight),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.terracotta,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: FilledButton(
                      onPressed: onBook,
                      child: Text(
                        l10n.bookThisSpace,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
