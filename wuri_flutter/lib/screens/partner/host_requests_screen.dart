import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/booking_providers.dart';
import 'package:wuri_flutter/theme/app_theme.dart';
import 'package:wuri_flutter/utils/booking_math.dart';
import 'package:wuri_flutter/utils/format.dart';
import 'package:wuri_flutter/utils/snackbar.dart';
import 'package:wuri_flutter/widgets/status_chip.dart';

/// Les demandes reçues par l'hôte : accepter ou refuser.
class HostRequestsScreen extends ConsumerWidget {
  const HostRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final requests = ref.watch(hostRequestsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n!.hostRequestsTitle)),
      body: requests.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.errorLoading),
              TextButton(
                onPressed: () => ref.invalidate(hostRequestsProvider),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
        data: (list) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(hostRequestsProvider);
            await ref.read(hostRequestsProvider.future);
          },
          child: list.isEmpty
              ? ListView(
                  children: [
                    const SizedBox(height: 120),
                    Center(child: Text(l10n.noRequests)),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      _RequestCard(request: list[index]),
                ),
        ),
      ),
    );
  }
}

class _RequestCard extends ConsumerWidget {
  const _RequestCard({required this.request});

  final HostBookingRequest request;

  Future<void> _respond(
    BuildContext context,
    WidgetRef ref, {
    required bool accept,
  }) async {
    final l10n = AppLocalizations.of(context);
    try {
      await client.hostBooking.respondToBooking(
        bookingId: request.booking.id!,
        accept: accept,
      );
      ref.invalidate(hostRequestsProvider);
      if (context.mounted) {
        showAppSnackBar(
          context,
          accept ? l10n!.requestAccepted : l10n!.requestDeclined,
        );
      }
    } on AppException catch (e) {
      // Par exemple : "Another accepted booking already uses these dates."
      if (context.mounted) showAppSnackBar(context, e.message);
    } catch (_) {
      if (context.mounted) showAppSnackBar(context, l10n!.genericError);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final b = request.booking;
    final nights = nightsBetween(b.checkIn, b.checkOut);

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
                    request.spaceName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                StatusChip(status: b.status),
              ],
            ),
            const SizedBox(height: 6),
            Text('${request.guestFirstName} ${request.guestLastName}'),
            const SizedBox(height: 6),
            Text(
              '${formatDate(context, b.checkIn)} → '
              '${formatDate(context, b.checkOut)}',
            ),
            Text(
              '${l10n!.nightsCount(nights)} · ${l10n.guestsCount(b.guests)}',
              style: const TextStyle(color: AppColors.muted),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.totalPrice(formatPrice(b.totalPrice)),
              style: const TextStyle(
                color: AppColors.terracotta,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (b.status == BookingStatus.pending) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _respond(context, ref, accept: false),
                      child: Text(l10n.decline),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => _respond(context, ref, accept: true),
                      child: Text(l10n.accept),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}