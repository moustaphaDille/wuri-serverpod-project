import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/auth_providers.dart';
import 'package:wuri_flutter/providers/space_providers.dart';
import 'package:wuri_flutter/providers/locale_provider.dart';
import 'package:wuri_flutter/theme/app_theme.dart';
import 'package:wuri_flutter/utils/space_type_icon.dart';
import 'package:wuri_flutter/utils/space_type_label.dart';
import 'package:wuri_flutter/widgets/category_chip.dart';
import 'package:wuri_flutter/widgets/empty_state.dart';
import 'package:wuri_flutter/widgets/skeleton.dart';
import 'package:wuri_flutter/widgets/space_card.dart';
import 'package:wuri_flutter/widgets/spaces_map.dart';
import 'package:wuri_flutter/utils/snackbar.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final _searchController = TextEditingController();
  bool _showMap = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final signedIn = ref.watch(signedInProvider);
    final profile = ref.watch(profileProvider);
    final canBook = !signedIn || profile.asData?.value?.role == UserRole.client;
    final filter = ref.watch(spaceFilterProvider);
    final spaces = ref.watch(spacesProvider);
    final notifier = ref.read(spaceFilterProvider.notifier);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final sidePadding = screenWidth >= 1240
        ? (screenWidth - 1200) / 2
        : screenWidth >= 800
        ? 32.0
        : 20.0;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 14, sidePadding, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.appName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                _LanguageSwitch(
                  languageCode: ref.watch(localeProvider).languageCode,
                  onChanged: (languageCode) => ref
                      .read(localeProvider.notifier)
                      .setLanguage(languageCode),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 4, sidePadding, 0),
            child: Text(
              l10n.tagline,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                height: 1.15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 16, sidePadding, 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: softShadow,
              ),
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: notifier.setCity,
                decoration: InputDecoration(
                  hintText: l10n.searchHint,
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: filter.city.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () {
                            _searchController.clear();
                            notifier.setCity('');
                          },
                        ),
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(sidePadding, 2, 12, 6),
              children: [
                CategoryChip(
                  label: l10n.typeAll,
                  icon: Icons.apps_rounded,
                  selected: filter.type == null,
                  onTap: () => notifier.setType(null),
                ),
                for (final type in SpaceType.values)
                  CategoryChip(
                    label: spaceTypeLabel(l10n, type),
                    icon: spaceTypeIcon(type),
                    selected: filter.type == type,
                    onTap: () => notifier.setType(type),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 12, sidePadding, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _ViewToggle(
                  showMap: _showMap,
                  listLabel: l10n.viewList,
                  mapLabel: l10n.viewMap,
                  onChanged: (value) => setState(() => _showMap = value),
                ),
              ],
            ),
          ),
          Expanded(
            child: spaces.when(
              loading: () => const SpaceListSkeleton(),
              error: (error, stack) => EmptyState(
                icon: Icons.cloud_off_rounded,
                title: l10n.errorLoading,
                actionLabel: l10n.retry,
                onAction: () => ref.invalidate(spacesProvider),
              ),
              data: (list) {
                // La carte s'affiche toujours, même sans espace.
                if (_showMap) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                      sidePadding,
                      0,
                      sidePadding,
                      20,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          SpacesMap(
                            // Nouvelle carte quand les résultats changent,
                            // pour la recentrer.
                            key: ValueKey(list.map((s) => s.id).join(',')),
                            spaces: list,
                            onOpen: (space) =>
                                context.push('/space/${space.id}'),
                          ),
                          if (list.isEmpty)
                            Positioned(
                              top: 12,
                              left: 12,
                              right: 12,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    l10n.noSpacesFound,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(spacesProvider);
                    await ref.read(spacesProvider.future);
                  },
                  child: list.isEmpty
                      ? ListView(
                          children: [
                            const SizedBox(height: 60),
                            EmptyState(
                              icon: Icons.search_off_rounded,
                              title: l10n.noSpacesFound,
                            ),
                          ],
                        )
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            final width = constraints.maxWidth;
                            final crossAxisCount = width >= 1200
                                ? 4
                                : width >= 800
                                ? 3
                                : width >= 520
                                ? 2
                                : 1;

                            if (crossAxisCount == 1) {
                              return ListView.separated(
                                padding: EdgeInsets.fromLTRB(
                                  sidePadding,
                                  0,
                                  sidePadding,
                                  24,
                                ),
                                itemCount: list.length,
                                separatorBuilder: (_, _) =>
                                    const SizedBox(height: 24),
                                itemBuilder: (context, index) {
                                  final space = list[index];
                                  return SpaceCard(
                                    space: space,
                                    onTap: () =>
                                        context.push('/space/${space.id}'),
                                    onBook: canBook
                                        ? () => _onBook(context, space.id!)
                                        : null,
                                  );
                                },
                              );
                            }

                            return GridView.builder(
                              padding: EdgeInsets.fromLTRB(
                                sidePadding,
                                0,
                                sidePadding,
                                24,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 24,
                                    mainAxisSpacing: 28,
                                    // Espace vertical suffisant pour la photo, le nom, la ville et le prix.
                                    mainAxisExtent: 330,
                                  ),
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                final space = list[index];
                                return SpaceCard(
                                  space: space,
                                  onTap: () =>
                                      context.push('/space/${space.id}'),
                                  onBook: canBook
                                      ? () => _onBook(context, space.id!)
                                      : null,
                                );
                              },
                            );
                          },
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onBook(BuildContext context, int spaceId) async {
    final l10n = AppLocalizations.of(context)!;
    final target = '/space/$spaceId/book';
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
}

class _LanguageSwitch extends StatelessWidget {
  const _LanguageSwitch({
    required this.languageCode,
    required this.onChanged,
  });

  final String languageCode;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final isFrench = languageCode == 'fr';
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: softShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _language(
            label: 'FR',
            selected: isFrench,
            onTap: () => onChanged('fr'),
          ),
          _language(
            label: 'EN',
            selected: !isFrench,
            onTap: () => onChanged('en'),
          ),
        ],
      ),
    );
  }

  Widget _language({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: selected ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: selected ? AppColors.indigo : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: selected ? AppColors.sand : AppColors.indigo,
          ),
        ),
      ),
    );
  }
}

/// Bascule Liste / Carte.
class _ViewToggle extends StatelessWidget {
  const _ViewToggle({
    required this.showMap,
    required this.listLabel,
    required this.mapLabel,
    required this.onChanged,
  });

  final bool showMap;
  final String listLabel;
  final String mapLabel;
  final ValueChanged<bool> onChanged;

  Widget _segment({
    required bool value,
    required IconData icon,
    required String label,
  }) {
    final selected = showMap == value;
    final color = selected ? AppColors.sand : AppColors.indigo;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.indigo : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        boxShadow: softShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _segment(
            value: false,
            icon: Icons.view_agenda_outlined,
            label: listLabel,
          ),
          _segment(
            value: true,
            icon: Icons.map_outlined,
            label: mapLabel,
          ),
        ],
      ),
    );
  }
}
