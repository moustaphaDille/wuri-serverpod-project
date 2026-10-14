import 'package:flutter/material.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/theme/app_theme.dart';

/// Pastille de statut d'une réservation.
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final (label, background, foreground) = switch (status) {
      BookingStatus.pending => (
          l10n!.statusPending,
          const Color(0xFFF6DDD6),
          const Color(0xFF7A2E1E),
        ),
      BookingStatus.accepted => (
          l10n!.statusAccepted,
          AppColors.indigoTint,
          AppColors.indigo,
        ),
      BookingStatus.declined => (
          l10n!.statusDeclined,
          const Color(0xFFEEEAE2),
          AppColors.muted,
        ),
      BookingStatus.cancelled => (
          l10n!.statusCancelled,
          const Color(0xFFEEEAE2),
          AppColors.muted,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foreground,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}