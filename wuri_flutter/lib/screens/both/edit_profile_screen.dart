import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/auth_providers.dart';
import 'package:wuri_flutter/providers/locale_provider.dart';
import 'package:wuri_flutter/utils/snackbar.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key, required this.profile});
  final AppUser profile;

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late final TextEditingController _first;
  late final TextEditingController _last;
  late final TextEditingController _phone;
  late String _language;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _first = TextEditingController(text: widget.profile.firstName);
    _last = TextEditingController(text: widget.profile.lastName);
    _phone = TextEditingController(text: widget.profile.phone);
    _language = widget.profile.language;
  }

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    if (_first.text.trim().isEmpty ||
        _last.text.trim().isEmpty ||
        !RegExp(r'^\+?[0-9]{8,15}$').hasMatch(_phone.text.replaceAll(' ', ''))) {
      showAppSnackBar(context, l10n.invalidPhone);
      return;
    }
    setState(() => _saving = true);
    try {
      await client.profile.updateMyProfile(
        _first.text,
        _last.text,
        _phone.text,
        _language,
      );
      ref.invalidate(profileProvider);
      if (_language != ref.read(localeProvider).languageCode) {
        await ref.read(localeProvider.notifier).setLanguage(_language);
      }
      if (mounted) Navigator.pop(context);
    } on AppException catch (e) {
      if (mounted) showAppSnackBar(context, e.message);
    } catch (_) {
      if (mounted) showAppSnackBar(context, l10n.genericError);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.editProfile)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(controller: _first, decoration: InputDecoration(labelText: l10n.firstName)),
          const SizedBox(height: 14),
          TextFormField(controller: _last, decoration: InputDecoration(labelText: l10n.lastName)),
          const SizedBox(height: 14),
          TextFormField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(labelText: l10n.phone),
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            initialValue: _language,
            decoration: InputDecoration(labelText: l10n.languageLabel),
            items: const [
              DropdownMenuItem(value: 'fr', child: Text('Français')),
              DropdownMenuItem(value: 'en', child: Text('English')),
            ],
            onChanged: (value) => setState(() => _language = value!),
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(l10n.saveChanges),
          ),
        ],
      ),
    );
  }
}
