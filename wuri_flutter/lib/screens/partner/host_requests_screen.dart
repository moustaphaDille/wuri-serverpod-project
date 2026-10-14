
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

  bool _isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 900;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final requests = ref.watch(hostRequestsProvider);
    final wide = _isWide(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: Text(l10n.hostRequestsTitle),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: requests.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.indigo.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.cloud_off_outlined,
                    size: 36,
                    color: AppColors.indigo,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.errorLoading,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () => ref.invalidate(hostRequestsProvider),
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
        data: (list) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(hostRequestsProvider);
            await ref.read(hostRequestsProvider.future);
          },
          child: list.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(24),
                  children: [
                    SizedBox(height: wide ? 100 : 80),
                    Icon(
                      Icons.inbox_outlined,
                      size: 64,
                      color: AppColors.muted.withValues(alpha: 0.6),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        l10n.noRequests,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.muted,
                        ),
                      ),
                    ),
                  ],
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth >= 1200
                        ? 3
                        : constraints.maxWidth >= 700
                            ? 2
                            : 1;

                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: wide ? 32 : 16,
                        vertical: 24,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1280),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (wide) ...[
                                Text(
                                  l10n.hostRequestsTitle,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF172554),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${list.length} ${list.length == 1 ? 'demande' : 'demandes'}',
                                  style: const TextStyle(
                                    color: AppColors.muted,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],
                              if (columns == 1)
                                ...List.generate(
                                  list.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 14),
                                    child: _RequestCard(
                                      request: list[index],
                                    ),
                                  ),
                                )
                              else
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: list.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: columns,
                                    crossAxisSpacing: 18,
                                    mainAxisSpacing: 18,
                                    mainAxisExtent: 310,
                                  ),
                                  itemBuilder: (context, index) =>
                                      _RequestCard(request: list[index]),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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
    final l10n = AppLocalizations.of(context)!;

    try {
      await client.hostBooking.respondToBooking(
        bookingId: request.booking.id!,
        accept: accept,
      );

      ref.invalidate(hostRequestsProvider);

      if (context.mounted) {
        showAppSnackBar(
          context,
          accept ? l10n.requestAccepted : l10n.requestDeclined,
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final b = request.booking;
    final nights = nightsBetween(b.checkIn, b.checkOut);

    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: AppColors.border.withValues(alpha: 0.7),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.indigo.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.home_work_outlined,
                    color: AppColors.indigo,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      request.spaceName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.3,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF172554),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(
                  Icons.person_outline_rounded,
                  size: 19,
                  color: AppColors.muted,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${request.guestFirstName} ${request.guestLastName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                StatusChip(status: b.status),
              ],
            ),
            const SizedBox(height: 14),
            Divider(
              height: 1,
              color: AppColors.border.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 14),
            _RequestInfoRow(
              icon: Icons.calendar_month_outlined,
              label: '${formatDate(context, b.checkIn)} → '
                  '${formatDate(context, b.checkOut)}',
            ),
            const SizedBox(height: 10),
            _RequestInfoRow(
              icon: Icons.nights_stay_outlined,
              label: l10n.nightsCount(nights),
            ),
            const SizedBox(height: 10),
            _RequestInfoRow(
              icon: Icons.group_outlined,
              label: l10n.guestsCount(b.guests),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.totalPrice(formatPrice(b.totalPrice)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.terracotta,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            if (b.status == BookingStatus.pending) ...[
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _respond(
                        context,
                        ref,
                        accept: false,
                      ),
                      icon: const Icon(Icons.close_rounded, size: 18),
                      label: Text(l10n.decline),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.terracotta,
                        side: const BorderSide(
                          color: AppColors.terracotta,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => _respond(
                        context,
                        ref,
                        accept: true,
                      ),
                      icon: const Icon(Icons.check_rounded, size: 18),
                      label: Text(l10n.accept),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
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

class _RequestInfoRow extends StatelessWidget {
  const _RequestInfoRow({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.muted,
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF475569),
            ),
          ),
        ),
      ],
    );
  }
}
