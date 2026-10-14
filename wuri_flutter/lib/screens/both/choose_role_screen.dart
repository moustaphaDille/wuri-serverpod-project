import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/theme/app_theme.dart';

/// Premier écran après la vérification de l'email : client ou partenaire.
class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key, this.redirect});

  final String? redirect;

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  UserRole _role = UserRole.client;

  void _continue() {
    final params = ['role=${_role.name}'];
    if (widget.redirect != null) {
      params.add('redirect=${Uri.encodeComponent(widget.redirect!)}');
    }
    context.pushReplacement('/complete-profile?${params.join('&')}');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n!.chooseRoleTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(l10n.chooseRoleBody),
            const SizedBox(height: 20),
            _RoleCard(
              icon: Icons.search,
              title: l10n.roleClientTitle,
              body: l10n.roleClientBody,
              selected: _role == UserRole.client,
              onTap: () => setState(() => _role = UserRole.client),
            ),
            const SizedBox(height: 12),
            _RoleCard(
              icon: Icons.apartment_outlined,
              title: l10n.rolePartnerTitle,
              body: l10n.rolePartnerBody,
              selected: _role == UserRole.partner,
              onTap: () => setState(() => _role = UserRole.partner),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: _continue,
            child: Text(l10n.continueLabel),
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String body;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.indigo : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28, color: AppColors.indigo),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(body, style: const TextStyle(color: AppColors.muted)),
                ],
              ),
            ),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? AppColors.indigo : AppColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}