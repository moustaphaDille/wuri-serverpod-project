
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/theme/app_theme.dart';
import 'package:wuri_flutter/utils/snackbar.dart';

final adminUsersProvider =
    FutureProvider.autoDispose<List<AppUser>>((ref) {
  return client.admin.listUsers();
});

class AdminUsersScreen extends ConsumerWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.usersTitle)),
      body: ref.watch(adminUsersProvider).when(
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 40),
                    const SizedBox(height: 12),
                    Text(
                      l10n.errorLoading,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () =>
                          ref.invalidate(adminUsersProvider),
                      icon: const Icon(Icons.refresh),
                      label: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
            ),
            data: (users) => RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(adminUsersProvider);
                await ref.read(adminUsersProvider.future);
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final contentWidth =
                      width > 1200 ? 1160.0 : width;
                  final columns = width >= 1100
                      ? 3
                      : width >= 650
                          ? 2
                          : 1;

                  const spacing = 16.0;
                  final availableWidth =
                      contentWidth - 32;
                  final cardWidth = columns == 1
                      ? availableWidth
                      : (availableWidth -
                              spacing * (columns - 1)) /
                          columns;

                  return ListView(
                    physics:
                        const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    children: [
                      Center(
                        child: SizedBox(
                          width: contentWidth,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.usersTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${users.length} ${l10n.usersTitle.toLowerCase()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.muted,
                                    ),
                              ),
                              const SizedBox(height: 20),
                              if (users.isEmpty)
                                SizedBox(
                                  height: 240,
                                  child: Center(
                                    child: Column(
                                      mainAxisSize:
                                          MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.people_outline,
                                          size: 48,
                                          color: AppColors.muted,
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          l10n.noUsers,
                                          textAlign:
                                              TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                Wrap(
                                  spacing: spacing,
                                  runSpacing: spacing,
                                  children: users
                                      .map(
                                        (user) => SizedBox(
                                          width: cardWidth,
                                          child: _UserCard(
                                            user: user,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                            ],
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

class _UserCard extends ConsumerWidget {
  const _UserCard({required this.user});

  final AppUser user;

  Future<void> _toggle(
    BuildContext context,
    WidgetRef ref,
    bool blocked,
  ) async {
    final l10n = AppLocalizations.of(context)!;

    try {
      await client.admin.setClientBlocked(
        userId: user.id!,
        blocked: blocked,
      );

      ref.invalidate(adminUsersProvider);

      if (context.mounted) {
        showAppSnackBar(
          context,
          blocked
              ? l10n.userDeactivated
              : l10n.userActivated,
        );
      }
    } on AppException catch (e) {
      if (context.mounted) {
        showAppSnackBar(context, e.message);
      }
    } catch (_) {
      if (context.mounted) {
        showAppSnackBar(context, l10n.genericError);
      }
    }
  }

  String _roleLabel(AppLocalizations l10n) =>
      switch (user.role) {
        UserRole.client => l10n.roleClient,
        UserRole.partner => l10n.rolePartner,
        UserRole.admin => l10n.roleAdmin,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final blocked = user.authUser?.blocked ?? false;
    final isClient = user.role == UserRole.client;
    final theme = Theme.of(context);

    final statusText = isClient
        ? (blocked
            ? l10n.accountInactive
            : l10n.accountActive)
        : l10n.partnerAccountManagedByVerification;

    final statusColor = isClient && blocked
        ? AppColors.muted
        : AppColors.indigo;

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Text(
                    user.firstName.isNotEmpty
                        ? user.firstName[0].toUpperCase()
                        : '?',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      '${user.firstName} ${user.lastName}',
                      softWrap: true,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Chip(
                label: Text(_roleLabel(l10n)),
                visualDensity: VisualDensity.compact,
              ),
            ),
            const Divider(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.phone_outlined, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: SelectableText(
                    user.phone,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isClient
                      ? (blocked
                          ? Icons.block
                          : Icons.check_circle_outline)
                      : Icons.verified_user_outlined,
                  size: 20,
                  color: statusColor,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    statusText,
                    softWrap: true,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            if (isClient) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () =>
                      _toggle(context, ref, !blocked),
                  icon: Icon(
                    blocked
                        ? Icons.check_circle_outline
                        : Icons.block_outlined,
                  ),
                  label: Text(
                    blocked
                        ? l10n.activateAccount
                        : l10n.deactivateAccount,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
