
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
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cloud_off_outlined,
                  size: 44,
                  color: AppColors.muted,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.errorLoading,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () => ref.invalidate(profileProvider),
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
        data: (profile) => profile == null
            ? const _MissingProfileView()
            : _ProfileView(profile: profile),
      ),
    );
  }
}

/// Visiteur non connecté.
class _GuestView extends StatelessWidget {
  const _GuestView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final wide = MediaQuery.sizeOf(context).width >= 700;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(wide ? 36 : 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.border.withValues(alpha: 0.7),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: const BoxDecoration(
                    color: AppColors.indigoTint,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    size: 38,
                    color: AppColors.indigo,
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  l10n.profileGuestTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172554),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.profileGuestBody,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: () => context.push('/auth/register'),
                    child: Text(l10n.createAccount),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () => context.push('/auth/login'),
                    child: Text(l10n.logIn),
                  ),
                ),
              ],
            ),
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.account_circle_outlined,
                  size: 64,
                  color: AppColors.indigo,
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.profileMissing,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: () => context.push('/choose-role'),
                    child: Text(l10n.completeProfileTitle),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => client.auth.signOutDevice(),
                    child: Text(l10n.signOut),
                  ),
                ),
              ],
            ),
          ),
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
    final width = MediaQuery.sizeOf(context).width;
    final wide = width >= 900;
    final initial = profile.firstName.isEmpty
        ? '?'
        : profile.firstName[0].toUpperCase();

    return ColoredBox(
      color: const Color(0xFFF6F7FB),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: wide ? 36 : 16,
              vertical: wide ? 32 : 20,
            ),
            children: [
              if (wide) ...[
                Text(
                  l10n.profileInformation,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172554),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Gérez votre compte et vos préférences.',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 24),
              ],

              _ProfileHeader(
                initial: initial,
                fullName: '${profile.firstName} ${profile.lastName}'.trim(),
                phone: profile.phone,
                role: _roleLabel(l10n),
                wide: wide,
              ),

              const SizedBox(height: 24),

              if (wide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildAccountMenu(context, l10n),
                    ),
                    if (profile.role == UserRole.partner) ...[
                      const SizedBox(width: 24),
                      const Expanded(
                        flex: 5,
                        child: _PartnerSection(),
                      ),
                    ],
                  ],
                )
              else ...[
                _buildAccountMenu(context, l10n),
                if (profile.role == UserRole.partner) ...[
                  const SizedBox(height: 20),
                  const _PartnerSection(),
                ],
              ],

              const SizedBox(height: 24),

              SizedBox(
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () => client.auth.signOutDevice(),
                  icon: const Icon(Icons.logout_rounded),
                  label: Text(l10n.signOut),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.terracotta,
                    side: const BorderSide(
                      color: AppColors.terracotta,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountMenu(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.7),
        ),
      ),
      child: Column(
        children: [
          _ProfileMenuTile(
            icon: Icons.person_outline_rounded,
            title: l10n.profileInformation,
            subtitle: l10n.viewAllInformation,
            onTap: () => context.push('/profile/information'),
          ),
          const _MenuDivider(),
          _ProfileMenuTile(
            icon: Icons.edit_outlined,
            title: l10n.editProfile,
            onTap: () => context.push('/profile/edit'),
          ),
          const _MenuDivider(),
          _ProfileMenuTile(
            icon: Icons.lock_outline_rounded,
            title: l10n.changePassword,
            onTap: () => context.push('/profile/password'),
          ),
          const _MenuDivider(),
          _ProfileMenuTile(
            icon: Icons.settings_outlined,
            title: l10n.settings,
            onTap: () => context.push('/profile/settings'),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.initial,
    required this.fullName,
    required this.phone,
    required this.role,
    required this.wide,
  });

  final String initial;
  final String fullName;
  final String phone;
  final String role;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(wide ? 28 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.7),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: wide ? 36 : 30,
            backgroundColor: AppColors.indigo,
            child: Text(
              initial,
              style: TextStyle(
                fontSize: wide ? 27 : 23,
                fontWeight: FontWeight.w700,
                color: AppColors.sand,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: wide ? 21 : 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF172554),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  phone,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 9),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.indigoTint,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    role,
                    style: const TextStyle(
                      color: AppColors.indigo,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  const _ProfileMenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 6,
      ),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.indigo.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: AppColors.indigo,
          size: 22,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.muted,
      ),
      onTap: onTap,
    );
  }
}

class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 18,
      endIndent: 18,
      color: AppColors.border.withValues(alpha: 0.7),
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
          padding: EdgeInsets.all(24),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(l10n.errorLoading),
      ),
      data: (application) {
        if (application == null) {
          return _PartnerStatusCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.apartment_rounded,
                  size: 30,
                  color: AppColors.indigo,
                ),
                const SizedBox(height: 14),
                Text(
                  l10n.verificationTitle,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172554),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.verificationNeeded,
                  style: const TextStyle(
                    height: 1.5,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: () => context.push('/partner/business'),
                    child: Text(l10n.businessTitle),
                  ),
                ),
              ],
            ),
          );
        }

        final (label, background, foreground, message) =
            switch (application.status) {
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

        return _PartnerStatusCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      'Vérification de l’établissement',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF172554),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: foreground,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                application.businessName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 7),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: AppColors.muted,
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      '${application.city} · ${application.address}',
                      style: const TextStyle(
                        height: 1.5,
                        color: AppColors.muted,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(height: 1.5),
              ),
              if (application.status == ApplicationStatus.rejected &&
                  application.rejectionReason != null) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEAE2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    l10n.rejectionReason(application.rejectionReason!),
                    style: const TextStyle(height: 1.5),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _PartnerStatusCard extends StatelessWidget {
  const _PartnerStatusCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.7),
        ),
      ),
      child: child,
    );
  }
}
