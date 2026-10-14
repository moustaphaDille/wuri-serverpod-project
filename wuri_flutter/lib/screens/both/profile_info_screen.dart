import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/theme/app_theme.dart';

class ProfileInfoScreen extends ConsumerWidget {
  const ProfileInfoScreen({super.key, required this.profile});

  final AppUser profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final role = switch (profile.role) {
      UserRole.client => l10n.roleClient,
      UserRole.partner => l10n.rolePartner,
      UserRole.admin => l10n.roleAdmin,
    };
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileInformation)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: AppColors.indigo,
            child: Text(
              profile.firstName.isEmpty ? '?' : profile.firstName[0].toUpperCase(),
              style: const TextStyle(fontSize: 30, color: AppColors.sand),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${profile.firstName} ${profile.lastName}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 24),
          FutureBuilder(
            future: client.modules.serverpod_auth_core.userProfileInfo.get(),
            builder: (context, snapshot) => Column(
              children: [
                _InfoTile(
                  icon: Icons.email_outlined,
                  label: l10n.emailLabel,
                  value: snapshot.data?.email ?? l10n.loadingLabel,
                ),
                _InfoTile(
                  icon: Icons.phone_outlined,
                  label: l10n.phone,
                  value: profile.phone,
                ),
                _InfoTile(
                  icon: Icons.badge_outlined,
                  label: l10n.accountType,
                  value: role,
                ),
                _InfoTile(
                  icon: Icons.language,
                  label: l10n.languageLabel,
                  value: profile.language.toUpperCase(),
                ),
                _InfoTile(
                  icon: Icons.calendar_today_outlined,
                  label: l10n.memberSince,
                  value: '${profile.createdAt.day.toString().padLeft(2, '0')}/'
                      '${profile.createdAt.month.toString().padLeft(2, '0')}/'
                      '${profile.createdAt.year}',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => context.push('/profile/edit'),
            icon: const Icon(Icons.edit_outlined),
            label: Text(l10n.editProfile),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: Icon(icon, color: AppColors.terracotta),
          title: Text(label, style: const TextStyle(color: AppColors.muted)),
          subtitle: Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      );
}
