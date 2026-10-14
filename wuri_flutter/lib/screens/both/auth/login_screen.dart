import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/auth_providers.dart';
import 'package:wuri_flutter/screens/both/auth/after_sign_in.dart';
import 'package:wuri_flutter/theme/app_theme.dart';
import 'package:wuri_flutter/utils/snackbar.dart';
import 'package:wuri_flutter/widgets/auth_scaffold.dart';
import 'package:wuri_flutter/widgets/labeled_field.dart';
import 'package:wuri_flutter/widgets/loading_button.dart';

/// Connexion d'un compte qui existe dÃ©jÃ  : email + mot de passe.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key, this.redirect});

  final String? redirect;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final EmailAuthController _auth;

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _busy = false;
  bool _hidePassword = true;

  @override
  void initState() {
    super.initState();
    _auth = EmailAuthController(
      client: client,
      startScreen: EmailFlowScreen.login,
      onAuthenticated: () {
        // La navigation est gÃ©rÃ©e par l'Ã©couteur de signedInProvider.
      },
      onError: (error) {
        if (!mounted) return;
        final l10n = AppLocalizations.of(context)!;
        showAppSnackBar(context, _auth.errorMessage ?? l10n.loginFailed);
      },
    );
  }

  @override
  void dispose() {
    _auth.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _busy = true);
    try {
      _auth.emailController.text = _email.text.trim();
      _auth.passwordController.text = _password.text;
      await _auth.login();
      // En cas de succÃ¨s, l'Ã©couteur ci-dessous fait avancer l'utilisateur.
    } catch (_) {
      if (mounted) showAppSnackBar(context, l10n.loginFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _goRegister() {
    final suffix = widget.redirect == null
        ? ''
        : '?redirect=${Uri.encodeComponent(widget.redirect!)}';
    context.pushReplacement('/auth/register$suffix');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    ref.listen<bool>(signedInProvider, (previous, next) {
      if (next) goAfterSignIn(context, ref, widget.redirect);
    });

    String? required(String? v) =>
        (v == null || v.trim().isEmpty) ? l10n.fieldRequired : null;

    return AuthScaffold(
      title: l10n.loginHeadline,
      subtitle: l10n.loginSubtitle,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabeledField(
              label: l10n.emailLabel,
              controller: _email,
              hint: l10n.emailHint,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              validator: required,
            ),
            const SizedBox(height: 16),
            LabeledField(
              label: l10n.passwordLabel,
              controller: _password,
              obscureText: _hidePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _hidePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.muted,
                ),
                onPressed: () => setState(() => _hidePassword = !_hidePassword),
              ),
              validator: required,
            ),
            const SizedBox(height: 28),
            LoadingButton(
              label: l10n.logIn,
              loading: _busy,
              onPressed: _login,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _busy
                    ? null
                    : () => context.push('/auth/reset-password'),
                child: Text(l10n.forgotPassword),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    l10n.noAccount,
                    style: const TextStyle(color: AppColors.muted),
                  ),
                  TextButton(
                    onPressed: _busy ? null : _goRegister,
                    child: Text(l10n.createAccount),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}