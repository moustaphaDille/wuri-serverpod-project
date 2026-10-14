import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:wuri_client/wuri_client.dart';
import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/auth_providers.dart';
import 'package:wuri_flutter/theme/app_theme.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final signedIn = ref.watch(signedInProvider);

    if (!signedIn) return const _GuestView();

    final profile = ref.watch(profileProvider);
    return SafeArea(
      child: profile.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.errorLoading),
              TextButton(
                onPressed: () => ref.invalidate(profileProvider),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
        data: (p) =>
            p == null ? const _MissingProfileView() : _ProfileView(profile: p),
      ),
    );
  }
}

/// Visiteur non connecté : deux boutons, deux écrans différents.
class _GuestView extends StatelessWidget {
  const _GuestView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.indigoTint,
                child: Icon(
                  Icons.person_outline,
                  size: 32,
                  color: AppColors.indigo,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.profileGuestTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.profileGuestBody,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.muted),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => context.push('/auth/register'),
                child: Text(l10n.createAccount),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => context.push('/auth/login'),
                child: Text(l10n.logIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Connecté, mais le profil n'a pas encore été créé.
class _MissingProfileView extends StatelessWidget {
  const _MissingProfileView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.profileMissing, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.push('/choose-role'),
              child: Text(l10n.completeProfileTitle),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => client.auth.signOutDevice(),
              child: Text(l10n.signOut),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({required this.profile});

  final AppUser profile;

  String _roleLabel(AppLocalizations l10n) => switch (profile.role) {
    UserRole.client => l10n.roleClient,
    UserRole.partner => l10n.rolePartner,
    UserRole.admin => l10n.roleAdmin,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final initial = profile.firstName.isEmpty
        ? '?'
        : profile.firstName[0].toUpperCase();
    final screenWidth = MediaQuery.sizeOf(context).width;
    final horizontalPadding = screenWidth >= 800 ? 32.0 : 16.0;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 960),
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            screenWidth >= 800 ? 28 : 16,
            horizontalPadding,
            24,
          ),
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.indigo,
                  child: Text(
                    initial,
                    style: const TextStyle(fontSize: 22, color: AppColors.sand),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${profile.firstName} ${profile.lastName}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        profile.phone,
                        style: const TextStyle(color: AppColors.muted),
                      ),
                      Text(
                        _roleLabel(l10n),
                        style: const TextStyle(
                          color: AppColors.terracotta,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: Text(l10n.profileInformation),
                    subtitle: Text(l10n.viewAllInformation),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/profile/information'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.edit_outlined),
                    title: Text(l10n.editProfile),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/profile/edit'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.lock_outline),
                    title: Text(l10n.changePassword),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/profile/password'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: Text(l10n.settings),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/profile/settings'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (profile.role == UserRole.partner) const _PartnerSection(),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () => client.auth.signOutDevice(),
              child: Text(l10n.signOut),
            ),
          ],
        ),
      ),
    );
  }
}

/// Le statut de vérification d'un partenaire.
class _PartnerSection extends ConsumerWidget {
  const _PartnerSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final application = ref.watch(applicationProvider);

    return application.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Text(l10n.errorLoading),
      data: (a) {
        // Pas encore de demande : il doit décrire son établissement.
        if (a == null) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.verificationTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.verificationNeeded,
                    style: const TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () => context.push('/partner/business'),
                    child: Text(l10n.businessTitle),
                  ),
                ],
              ),
            ),
          );
        }

        final (label, background, foreground, message) = switch (a.status) {
          ApplicationStatus.pending => (
            l10n.statusPending,
            const Color(0xFFF6DDD6),
            const Color(0xFF7A2E1E),
            l10n.verificationPending,
          ),
          ApplicationStatus.approved => (
            l10n.statusAccepted,
            AppColors.indigoTint,
            AppColors.indigo,
            l10n.verificationApproved,
          ),
          ApplicationStatus.rejected => (
            l10n.statusDeclined,
            const Color(0xFFEEEAE2),
            AppColors.muted,
            l10n.verificationRejected,
          ),
        };

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
                        l10n.verificationTitle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
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
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  a.businessName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  '${a.city} · ${a.address}',
                  style: const TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 8),
                Text(message),
                if (a.status == ApplicationStatus.rejected &&
                    a.rejectionReason != null) ...[
                  const SizedBox(height: 6),
                  Text(l10n.rejectionReason(a.rejectionReason!)),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
