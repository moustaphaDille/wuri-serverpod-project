import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/auth_providers.dart';
import 'package:wuri_flutter/utils/snackbar.dart';

/// Collecte prénom, nom et téléphone, selon le rôle choisi.
class CompleteProfileScreen extends ConsumerStatefulWidget {
  const CompleteProfileScreen({
    super.key,
    required this.role,
    this.redirect,
  });

  final UserRole role;
  final String? redirect;

  @override
  ConsumerState<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends ConsumerState<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phone = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (!_formKey.currentState!.validate()) return;

    final language =
        Localizations.localeOf(context).languageCode == 'fr' ? 'fr' : 'en';

    setState(() => _saving = true);
    try {
      await client.profile.createMyProfile(
        _firstName.text,
        _lastName.text,
        _phone.text,
        language,
        widget.role,
      );
      ref.invalidate(profileProvider);
      await ref.read(profileProvider.future);

      if (!mounted) return;

      // Un partenaire décrit ensuite son établissement.
      if (widget.role == UserRole.partner) {
        context.go('/partner/business');
      } else if (widget.redirect == null) {
        context.go('/profile');
      } else {
        context.pushReplacement(widget.redirect!);
      }
    } on AppException catch (e) {
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

    String? required(String? value) =>
        (value == null || value.trim().isEmpty) ? l10n!.fieldRequired : null;

    String? phoneRule(String? value) {
      final clean = (value ?? '').replaceAll(' ', '');
      return RegExp(r'^\+?[0-9]{8,15}$').hasMatch(clean)
          ? null
          : l10n!.invalidPhone;
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n!.completeProfileTitle)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.role == UserRole.partner
                      ? l10n.partnerOwnerBody
                      : l10n.completeProfileBody,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _firstName,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(labelText: l10n.firstName),
                  validator: required,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _lastName,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(labelText: l10n.lastName),
                  validator: required,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: l10n.phone,
                    hintText: l10n.phoneHint,
                  ),
                  validator: phoneRule,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _saving ? null : _submit,
                  child: _saving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(l10n.continueLabel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}