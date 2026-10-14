import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wuri_client/wuri_client.dart';
import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/booking_providers.dart';
import 'package:wuri_flutter/theme/app_theme.dart';
import 'package:wuri_flutter/utils/booking_math.dart';
import 'package:wuri_flutter/utils/format.dart';
import 'package:wuri_flutter/utils/snackbar.dart';
import 'package:wuri_flutter/widgets/status_chip.dart';

/// Onglet "Réservations" du client.
class BookingsScreen extends ConsumerWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final bookings = ref.watch(myBookingsProvider);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = screenWidth >= 800 ? 32.0 : 16.0;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  screenWidth >= 800 ? 24 : 12,
                  horizontalPadding,
                  8,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    l10n!.myBookingsTitle,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: bookings.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l10n.errorLoading),
                    TextButton(
                      onPressed: () => ref.invalidate(myBookingsProvider),
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
              data: (list) => RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(myBookingsProvider);
                  await ref.read(myBookingsProvider.future);
                },
                child: list.isEmpty
                    ? ListView(
                        children: [
                          const SizedBox(height: 120),
                          Center(child: Text(l10n.noBookings)),
                        ],
                      )
                    : ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          0,
                          horizontalPadding,
                          16,
                        ),
                        itemCount: list.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) => Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 960),
                            child: _BookingCard(item: list[index]),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends ConsumerWidget {
  const _BookingCard({required this.item});

  final MyBooking item;

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n!.cancelConfirmTitle),
        content: Text(l10n.cancelConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.keepBooking),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.cancelBooking),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await client.booking.cancelBooking(item.booking.id!);
      ref.invalidate(myBookingsProvider);
      if (context.mounted) showAppSnackBar(context, l10n!.bookingCancelled);
    } on AppException catch (e) {
      if (context.mounted) showAppSnackBar(context, e.message);
    } catch (_) {
      if (context.mounted) showAppSnackBar(context, l10n!.genericError);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final b = item.booking;
    final space = item.space;
    final nights = nightsBetween(b.checkIn, b.checkOut);
    final cancellable =
        b.status == BookingStatus.pending || b.status == BookingStatus.accepted;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/space/${space.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      space.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  StatusChip(status: b.status),
                ],
              ),
              const SizedBox(height: 2),
              Text(space.city, style: const TextStyle(color: AppColors.muted)),
              const SizedBox(height: 10),
              Text(
                '${formatDate(context, b.checkIn)} → '
                '${formatDate(context, b.checkOut)}',
              ),
              Text(
                '${l10n!.nightsCount(nights)} · ${l10n.guestsCount(b.guests)}',
                style: const TextStyle(color: AppColors.muted),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.totalPrice(formatPrice(b.totalPrice)),
                style: const TextStyle(
                  color: AppColors.terracotta,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (cancellable)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _cancel(context, ref),
                    child: Text(l10n.cancelBooking),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
