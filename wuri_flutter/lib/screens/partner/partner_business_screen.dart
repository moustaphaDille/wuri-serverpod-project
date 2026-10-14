import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/auth_providers.dart';
import 'package:wuri_flutter/utils/niger_cities.dart';
import 'package:wuri_flutter/utils/snackbar.dart';
import 'package:wuri_flutter/utils/space_type_label.dart';

/// Le partenaire décrit son établissement (envoyé pour vérification).
class PartnerBusinessScreen extends ConsumerStatefulWidget {
  const PartnerBusinessScreen({super.key});

  @override
  ConsumerState<PartnerBusinessScreen> createState() =>
      _PartnerBusinessScreenState();
}

class _PartnerBusinessScreenState extends ConsumerState<PartnerBusinessScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _registration = TextEditingController();

  SpaceType _type = SpaceType.hotel;
  NigerCity _city = nigerCities.first;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _registration.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    try {
      await client.partner.submitApplication(
        businessName: _name.text,
        businessType: _type,
        city: _city.name,
        address: _address.text,
        registrationNumber: _registration.text,
      );
      ref.invalidate(applicationProvider);

      if (!mounted) return;
      showAppSnackBar(context, l10n!.applicationSent);
      context.go('/profile');
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

    String? required(String? v) =>
        (v == null || v.trim().isEmpty) ? l10n!.fieldRequired : null;

    String? registrationRule(String? v) {
      final value = (v ?? '').trim();
      return (value.length < 3 || value.length > 50)
          ? l10n!.fieldRequired
          : null;
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n!.businessTitle)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.businessBody),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _name,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(labelText: l10n.businessName),
                  validator: required,
                ),
                const SizedBox(height: 16),
                Text(l10n.spaceTypeLabel),
                const SizedBox(height: 8),
                SegmentedButton<SpaceType>(
                  showSelectedIcon: false,
                  segments: [
                    for (final t in SpaceType.values)
                      ButtonSegment(
                        value: t,
                        label: Text(
                          spaceTypeLabel(l10n, t),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  selected: {_type},
                  onSelectionChanged: (s) => setState(() => _type = s.first),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<NigerCity>(
                  initialValue: _city,
                  decoration: InputDecoration(labelText: l10n.cityLabel),
                  items: [
                    for (final c in nigerCities)
                      DropdownMenuItem(value: c, child: Text(c.name)),
                  ],
                  onChanged: (c) {
                    if (c != null) setState(() => _city = c);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _address,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(labelText: l10n.addressLabel),
                  validator: required,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _registration,
                  textCapitalization: TextCapitalization.characters,
                  decoration:
                      InputDecoration(labelText: l10n.registrationNumber),
                  validator: registrationRule,
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
                      : Text(l10n.sendForVerification),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}