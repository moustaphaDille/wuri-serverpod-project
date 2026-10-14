
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

  bool get _isWide => MediaQuery.sizeOf(context).width >= 900;

  void _continue() {
    final params = ['role=${_role.name}'];

    if (widget.redirect != null) {
      params.add('redirect=${Uri.encodeComponent(widget.redirect!)}');
    }

    context.pushReplacement('/complete-profile?${params.join('&')}');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: Text(l10n.chooseRoleTitle),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: _isWide ? 32 : 20,
              vertical: _isWide ? 40 : 24,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1040),
              child: Container(
                padding: EdgeInsets.all(_isWide ? 40 : 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(_isWide ? 24 : 0),
                  border: _isWide
                      ? Border.all(color: AppColors.border.withValues(alpha: 0.6))
                      : null,
                  boxShadow: _isWide
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 28,
                            offset: const Offset(0, 10),
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIntro(l10n),
                    const SizedBox(height: 28),
                    if (_isWide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: _RoleCard(
                              icon: Icons.search_rounded,
                              title: l10n.roleClientTitle,
                              body: l10n.roleClientBody,
                              selected: _role == UserRole.client,
                              accentColor: AppColors.indigo,
                              onTap: () => setState(
                                () => _role = UserRole.client,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _RoleCard(
                              icon: Icons.apartment_rounded,
                              title: l10n.rolePartnerTitle,
                              body: l10n.rolePartnerBody,
                              selected: _role == UserRole.partner,
                              accentColor: const Color(0xFFB86B42),
                              onTap: () => setState(
                                () => _role = UserRole.partner,
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          _RoleCard(
                            icon: Icons.search_rounded,
                            title: l10n.roleClientTitle,
                            body: l10n.roleClientBody,
                            selected: _role == UserRole.client,
                            accentColor: AppColors.indigo,
                            onTap: () => setState(
                              () => _role = UserRole.client,
                            ),
                          ),
                          const SizedBox(height: 14),
                          _RoleCard(
                            icon: Icons.apartment_rounded,
                            title: l10n.rolePartnerTitle,
                            body: l10n.rolePartnerBody,
                            selected: _role == UserRole.partner,
                            accentColor: const Color(0xFFB86B42),
                            onTap: () => setState(
                              () => _role = UserRole.partner,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: _isWide ? 420 : double.infinity,
                        height: 52,
                        child: FilledButton(
                          onPressed: _continue,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.indigo,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                l10n.continueLabel,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.arrow_forward_rounded, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntro(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: AppColors.indigo.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.waving_hand_rounded,
            color: AppColors.indigo,
            size: 28,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          l10n.chooseRoleTitle,
          style: TextStyle(
            fontSize: _isWide ? 30 : 26,
            height: 1.2,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF172554),
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Text(
            l10n.chooseRoleBody,
            style: const TextStyle(
              fontSize: 15,
              height: 1.65,
              color: Color(0xFF64748B),
            ),
          ),
        ),
      ],
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.selected,
    required this.accentColor,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String body;
  final bool selected;
  final Color accentColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: selected
                ? accentColor.withValues(alpha: 0.045)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? accentColor : AppColors.border,
              width: selected ? 1.8 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      icon,
                      color: accentColor,
                      size: 28,
                    ),
                  ),
                  const Spacer(),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected ? accentColor : Colors.transparent,
                      border: Border.all(
                        color: selected ? accentColor : AppColors.muted,
                        width: selected ? 1.5 : 1.4,
                      ),
                    ),
                    child: selected
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 16,
                          )
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF172554),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Color(0xFF64748B),
                ),
              ),
              if (selected) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: accentColor,
                      size: 17,
                    ),
                    const SizedBox(width: 7),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: accentColor,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
