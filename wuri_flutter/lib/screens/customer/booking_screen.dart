import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/space_providers.dart';
import 'package:wuri_flutter/theme/app_theme.dart';
import 'package:wuri_flutter/utils/booking_math.dart';
import 'package:wuri_flutter/utils/format.dart';

/// Choix des dates et du nombre de personnes.
class BookingScreen extends ConsumerStatefulWidget {
  const BookingScreen({super.key, required this.id});

  final int id;

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  DateTimeRange? _range;
  int _guests = 1;

  Future<void> _pickDates() async {
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final picked = await showDateRangePicker(
      context: context,
      firstDate: today,
      lastDate: today.add(const Duration(days: 365)),
      initialDateRange: _range,
      helpText: l10n!.selectDates,
    );
    if (picked != null) setState(() => _range = picked);
  }

  void _continue() {
    final range = _range!;
    final format = DateFormat('yyyy-MM-dd');
    final checkIn = format.format(range.start);
    final checkOut = format.format(range.end);
    context.push(
      '/space/${widget.id}/pay?in=$checkIn&out=$checkOut&guests=$_guests',
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final spaceAsync = ref.watch(spaceByIdProvider(widget.id));

    return Scaffold(
      appBar: AppBar(title: Text(l10n!.bookingTitle)),
      body: spaceAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(l10n.errorLoading)),
        data: (space) =>
            space == null ? Center(child: Text(l10n.spaceNotFound)) : _form(space),
      ),
    );
  }

  Widget _form(Space space) {
    final l10n = AppLocalizations.of(context);
    final range = _range;
    final nights = range == null ? 0 : nightsBetween(range.start, range.end);
    final total = space.pricePerNight * nights;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            space.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            '${space.city} · ${l10n!.perNight(formatPrice(space.pricePerNight))}',
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _DateTile(
                  label: l10n.checkIn,
                  value: range == null ? '—' : formatDate(context, range.start),
                  onTap: _pickDates,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DateTile(
                  label: l10n.checkOut,
                  value: range == null ? '—' : formatDate(context, range.end),
                  onTap: _pickDates,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Text(l10n.guestsLabel),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed:
                        _guests > 1 ? () => setState(() => _guests--) : null,
                  ),
                  Text(
                    '$_guests',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _guests < space.maxGuests
                        ? () => setState(() => _guests++)
                        : null,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (range != null && nights > 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${l10n.nightsCount(nights)} × ${formatPrice(space.pricePerNight)}',
                ),
                Text(l10n.totalPrice(formatPrice(total))),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.totalLabel,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  l10n.totalPrice(formatPrice(total)),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.terracotta,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ] else
            Text(
              l10n.datesRequired,
              style: const TextStyle(color: AppColors.muted),
            ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: (range != null && nights > 0) ? _continue : null,
            child: Text(l10n.continueToPayment),
          ),
        ],
      ),
    );
  }
}

class _DateTile extends StatelessWidget {
  const _DateTile({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: AppColors.muted, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}