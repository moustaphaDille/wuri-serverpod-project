import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/theme/app_theme.dart';
import 'package:wuri_flutter/utils/snackbar.dart';
import 'package:wuri_flutter/utils/space_type_label.dart';

/// Les demandes de partenaires en attente de vérification.
final adminApplicationsProvider =
    FutureProvider.autoDispose<List<AdminApplication>>((ref) {
  return client.admin.listApplications(status: ApplicationStatus.pending);
});

class AdminApplicationsScreen extends ConsumerWidget {
  const AdminApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final applications = ref.watch(adminApplicationsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n!.partnerRequestsTitle)),
      body: applications.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.errorLoading),
              TextButton(
                onPressed: () => ref.invalidate(adminApplicationsProvider),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
        data: (list) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(adminApplicationsProvider);
            await ref.read(adminApplicationsProvider.future);
          },
          child: list.isEmpty
              ? ListView(
                  children: [
                    const SizedBox(height: 120),
                    Center(child: Text(l10n.noPartnerRequests)),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      _ApplicationCard(item: list[index]),
                ),
        ),
      ),
    );
  }
}

class _ApplicationCard extends ConsumerWidget {
  const _ApplicationCard({required this.item});

  final AdminApplication item;

  Future<String?> _askReason(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n!.rejectDialogTitle),
        content: TextField(
          controller: controller,
          maxLines: 2,
          decoration: InputDecoration(hintText: l10n.rejectReasonHint),
        ),
        actions: [
          // Annuler renvoie null : on ne refuse pas.
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(controller.text),
            child: Text(l10n.reject),
          ),
        ],
      ),
    );
  }

  Future<void> _review(
    BuildContext context,
    WidgetRef ref, {
    required bool approve,
  }) async {
    final l10n = AppLocalizations.of(context);

    String? reason;
    if (!approve) {
      reason = await _askReason(context);
      if (reason == null) return; // annulé
      if (!context.mounted) return;
    }

    try {
      await client.admin.reviewApplication(
        applicationId: item.application.id!,
        approve: approve,
        reason: reason,
      );
      ref.invalidate(adminApplicationsProvider);
      if (context.mounted) {
        showAppSnackBar(
          context,
          approve ? l10n!.applicationApproved : l10n!.applicationRejected,
        );
      }
    } on AppException catch (e) {
      if (context.mounted) showAppSnackBar(context, e.message);
    } catch (_) {
      if (context.mounted) showAppSnackBar(context, l10n!.genericError);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final a = item.application;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    a.businessName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Chip(
                  label: Text(spaceTypeLabel(l10n!, a.businessType)),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            Text(
              '${a.city} · ${a.address}',
              style: const TextStyle(color: AppColors.muted),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.ownerLabel('${item.ownerFirstName} ${item.ownerLastName}'),
            ),
            Text(item.ownerPhone),
            const SizedBox(height: 4),
            Text('${l10n.registrationNumber} : ${a.registrationNumber}'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _review(context, ref, approve: false),
                    child: Text(l10n.reject),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => _review(context, ref, approve: true),
                    child: Text(l10n.approve),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}