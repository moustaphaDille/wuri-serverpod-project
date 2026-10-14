import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/booking_providers.dart';
import 'package:wuri_flutter/providers/space_providers.dart';
import 'package:wuri_flutter/theme/app_theme.dart';
import 'package:wuri_flutter/utils/booking_math.dart';
import 'package:wuri_flutter/utils/format.dart';
import 'package:wuri_flutter/utils/snackbar.dart';

/// Page de paiement STATIQUE : seul "Payer sur place" est actif.
/// La demande est créée sur le serveur quand on confirme.
class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({
    super.key,
    required this.id,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
  });

  final int id;
  final DateTime checkIn;
  final DateTime checkOut;
  final int guests;

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  bool _saving = false;

  Future<void> _confirm() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _saving = true);
    try {
      await client.booking.createBooking(
        placeId: widget.id,
        checkIn: widget.checkIn,
        checkOut: widget.checkOut,
        guests: widget.guests,
      );
      ref.invalidate(myBookingsProvider);

      if (!mounted) return;
      showAppSnackBar(context, l10n!.requestSent);
      context.go('/bookings');
    } on AppException catch (e) {
      // Par exemple : dates déjà prises, ou "vous ne pouvez pas réserver
      // votre propre espace". Le message vient du serveur.
      if (mounted) showAppSnackBar(context, e.message);
    } catch (_) {
      if (mounted) showAppSnackBar(context, l10n!.genericError);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final spaceAsync = ref.watch(spaceByIdProvider(widget.id));
    final nights = nightsBetween(widget.checkIn, widget.checkOut);

    return Scaffold(
      appBar: AppBar(title: Text(l10n!.paymentTitle)),
      body: spaceAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(l10n.errorLoading)),
        data: (space) {
          if (space == null) return Center(child: Text(l10n.spaceNotFound));
          final total = space.pricePerNight * nights;

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          space.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${formatDate(context, widget.checkIn)} → '
                          '${formatDate(context, widget.checkOut)}',
                        ),
                        Text(
                          '${l10n.nightsCount(nights)} · '
                          '${l10n.guestsCount(widget.guests)}',
                          style: const TextStyle(color: AppColors.muted),
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.totalLabel,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _Option(
                  icon: Icons.storefront_outlined,
                  title: l10n.payAtProperty,
                  subtitle: l10n.availableNow,
                  selected: true,
                ),
                const SizedBox(height: 8),
                _Option(
                  icon: Icons.phone_android,
                  title: l10n.mobileMoney,
                  badge: l10n.comingSoon,
                ),
                const SizedBox(height: 8),
                _Option(
                  icon: Icons.credit_card,
                  title: l10n.card,
                  badge: l10n.comingSoon,
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.noMoneyTaken,
                  style: const TextStyle(color: AppColors.muted, fontSize: 13),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _saving ? null : _confirm,
                  child: _saving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(l10n.confirmRequest),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    required this.icon,
    required this.title,
    this.subtitle,
    this.badge,
    this.selected = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? badge;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final disabled = badge != null;

    return Opacity(
      opacity: disabled ? 0.55 : 1,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.indigo : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.indigo),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            if (badge != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.indigoTint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.indigo,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}