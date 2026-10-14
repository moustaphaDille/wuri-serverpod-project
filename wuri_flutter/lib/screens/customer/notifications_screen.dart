import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/booking_providers.dart';
import 'package:wuri_flutter/theme/app_theme.dart';

/// Notifications "dans l'app" du client : construites à partir du statut de
/// ses réservations. Pas de table dédiée, pas de notification push.
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final bookings = ref.watch(myBookingsProvider);

    final handled = (bookings.asData?.value ?? [])
        .where((m) => m.booking.status != BookingStatus.pending)
        .toList();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              l10n!.notificationsTitle,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: bookings.isLoading
                ? const Center(child: CircularProgressIndicator())
                : handled.isEmpty
                    ? Center(child: Text(l10n.noNotifications))
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: handled.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final m = handled[index];
                          return Card(
                            child: ListTile(
                              leading: Icon(
                                switch (m.booking.status) {
                                  BookingStatus.accepted =>
                                    Icons.check_circle_outline,
                                  BookingStatus.declined => Icons.highlight_off,
                                  _ => Icons.event_busy_outlined,
                                },
                                color: AppColors.indigo,
                              ),
                              title: Text(
                                switch (m.booking.status) {
                                  BookingStatus.accepted =>
                                    l10n.notifAccepted(m.space.name),
                                  BookingStatus.declined =>
                                    l10n.notifDeclined(m.space.name),
                                  _ => l10n.notifCancelled(m.space.name),
                                },
                              ),
                              onTap: () => context.go('/bookings'),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}