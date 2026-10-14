import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/auth_providers.dart';
import 'package:wuri_flutter/widgets/responsive_frame.dart';

/// Coquille de l'app. Les onglets dépendent du rôle :
/// - visiteur : Recherche, Profil
/// - administrateur : Recherche, Utilisateurs, Demandes partenaires, Profil
/// - client : Recherche, Favoris, Réservations, Notifications, Profil
/// - partenaire en attente : Recherche, Mes espaces, Profil
/// - partenaire vérifié : Recherche, Mes espaces, Demandes, Profil
/// Les branches existent toujours dans le routeur ; seule la barre change.
class ShellScaffold extends ConsumerWidget {
  const ShellScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  // Numéros de branche : 0 recherche, 1 favoris, 2 réservations,
  // 3 notifications, 4 profil, 5 mes espaces, 6 demandes partenaire,
  // 7 utilisateurs admin, 8 demandes partenaires admin.
  List<int> _branches(
    bool signedIn,
    AppUser? profile,
    PartnerApplication? application,
  ) {
    if (!signedIn || profile == null) return const [0, 4];

    return switch (profile.role) {
      UserRole.client => const [0, 1, 2, 3, 4],
      UserRole.partner => application?.status == ApplicationStatus.approved
          ? const [0, 5, 6, 4]
          : const [0, 5, 4],
      UserRole.admin => const [0, 7, 8, 4],
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final signedIn = ref.watch(signedInProvider);
    final profile = ref.watch(profileProvider).asData?.value;
    final application = ref.watch(applicationProvider).asData?.value;

    final branches = _branches(signedIn, profile, application);
    final current = navigationShell.currentIndex;

    // Si l'onglet courant n'existe plus (déconnexion, changement de rôle),
    // on revient à la recherche.
    if (!branches.contains(current)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigationShell.goBranch(0);
      });
    }

    NavigationDestination destination(int branch) {
      return switch (branch) {
        0 => NavigationDestination(
            icon: const Icon(Icons.search), label: l10n!.navSearch),
        1 => NavigationDestination(
            icon: const Icon(Icons.favorite_border), label: l10n!.navFavorites),
        2 => NavigationDestination(
            icon: const Icon(Icons.calendar_today_outlined),
            label: l10n!.navBookings),
        3 => NavigationDestination(
            icon: const Icon(Icons.notifications_none),
            label: l10n!.navNotifications),
        5 => NavigationDestination(
            icon: const Icon(Icons.apartment_outlined),
            label: l10n!.navMySpaces),
        6 => NavigationDestination(
            icon: const Icon(Icons.inbox_outlined), label: l10n!.navRequests),
        7 => NavigationDestination(
            icon: const Icon(Icons.manage_accounts_outlined),
            label: l10n!.usersTitle),
        8 => NavigationDestination(
            icon: const Icon(Icons.fact_check_outlined),
            label: l10n!.partnerRequestsTitle),
        _ => NavigationDestination(
            icon: const Icon(Icons.person_outline), label: l10n!.navProfile),
      };
    }

    final selected = branches.indexOf(current);

    
    final isDesktop = MediaQuery.sizeOf(context).width >= 800;

    return Scaffold(
      body: isDesktop
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: selected < 0 ? 0 : selected,
                  onDestinationSelected: (index) {
                    final branch = branches[index];
                    navigationShell.goBranch(
                      branch,
                      initialLocation: branch == current,
                    );
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    for (final b in branches)
                      NavigationRailDestination(
                        icon: destination(b).icon,
                        label: Text(destination(b).label),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: ResponsiveFrame.maxWidth,
                      ),
                      child: navigationShell,
                    ),
                  ),
                ),
              ],
            )
          : navigationShell,
      bottomNavigationBar: isDesktop
          ? null
          : NavigationBar(
              selectedIndex: selected < 0 ? 0 : selected,
              onDestinationSelected: (index) {
                final branch = branches[index];
                navigationShell.goBranch(
                  branch,
                  initialLocation: branch == current,
                );
              },
              destinations: [
                for (final b in branches) destination(b),
              ],
            ),
    );

  }
}