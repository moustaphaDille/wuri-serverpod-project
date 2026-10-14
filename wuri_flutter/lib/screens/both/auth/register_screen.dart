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

/// CrÃ©ation de compte en deux Ã©tapes :
/// 1. email + mot de passe + confirmation, puis envoi du code
/// 2. saisie du code, puis crÃ©ation du compte
/// La suite (choix du rÃ´le, profil) est dÃ©clenchÃ©e dÃ¨s que le compte est connectÃ©.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key, this.redirect});

  final String? redirect;

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late final EmailAuthController _auth;

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _code = TextEditingController();

  bool _codeStep = false;
  bool _busy = false;
  bool _hidePassword = true;
  String _savedEmail = '';
  String _savedPassword = '';

  @override
  void initState() {
    super.initState();
    _auth = EmailAuthController(
      client: client,
      startScreen: EmailFlowScreen.startRegistration,
      onAuthenticated: () {
        // La navigation est gÃ©rÃ©e par l'Ã©couteur de signedInProvider.
      },
      onError: (error) {
        if (!mounted) return;
        showAppSnackBar(context, _auth.errorMessage ?? '$error');
      },
    );
  }

  @override
  void dispose() {
    _auth.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    _code.dispose();
    super.dispose();
  }

  /// Ã‰tape 1 : envoie le code de vÃ©rification Ã  l'email.
  Future<void> _sendCode() async {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;

    _savedEmail = _email.text.trim();
    _savedPassword = _password.text;

    setState(() => _busy = true);
    try {
      _auth.emailController.text = _savedEmail;
      await _auth.startRegistration();

      if (!mounted) return;
      // Si l'envoi a rÃ©ussi, le contrÃ´leur est passÃ© Ã  l'Ã©cran de vÃ©rification.
      if (_auth.currentScreen == EmailFlowScreen.verifyRegistration) {
        setState(() => _codeStep = true);
      }
    } catch (_) {
      if (mounted) showAppSnackBar(context, l10n.genericError);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Ã‰tape 2 : vÃ©rifie le code, puis crÃ©e le compte avec le mot de passe choisi.
  Future<void> _verifyAndCreate() async {
    final l10n = AppLocalizations.of(context)!;
    final code = _code.text.trim();
    if (code.isEmpty) {
      showAppSnackBar(context, l10n.fieldRequired);
      return;
    }

    setState(() => _busy = true);
    try {
      _auth.verificationCodeController.text = code;
      await _auth.verifyRegistrationCode();

      if (!mounted) return;
      if (_auth.currentScreen == EmailFlowScreen.completeRegistration) {
        // Le contrÃ´leur vide ses champs en changeant d'Ã©cran :
        // on lui redonne le mot de passe choisi Ã  l'Ã©tape 1.
        _auth.passwordController.text = _savedPassword;
        await _auth.finishRegistration();
        // Le compte est crÃ©Ã© et connectÃ© : l'Ã©couteur ci-dessous prend le relais.
      }
    } catch (_) {
      if (mounted) showAppSnackBar(context, l10n.genericError);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _resend() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await _auth.resendVerificationCode();
      if (mounted) showAppSnackBar(context, l10n.codeResent);
    } catch (_) {
      if (mounted) showAppSnackBar(context, l10n.genericError);
    }
  }

  void _changeEmail() {
    _auth.navigateTo(EmailFlowScreen.startRegistration);
    setState(() {
      _codeStep = false;
      _code.clear();
    });
  }

  void _goLogin() {
    final suffix = widget.redirect == null
        ? ''
        : '?redirect=${Uri.encodeComponent(widget.redirect!)}';
    context.pushReplacement('/auth/login$suffix');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // DÃ¨s que le compte est connectÃ©, on enchaÃ®ne (choix du rÃ´le, etc.).
    ref.listen<bool>(signedInProvider, (previous, next) {
      if (next) goAfterSignIn(context, ref, widget.redirect);
    });

    return AuthScaffold(
      step: _codeStep ? 2 : 1,
      title: _codeStep ? l10n.verifyTitle : l10n.registerTitle,
      subtitle: _codeStep ? l10n.verifyBody(_savedEmail) : l10n.registerSubtitle,
      // Ã€ l'Ã©tape du code, retour = revenir Ã  la saisie de l'email.
      onBack: _codeStep ? _changeEmail : null,
      child: _codeStep ? _codeForm(l10n) : _emailForm(l10n),
    );
  }

  Widget _emailForm(AppLocalizations l10n) {
    String? emailRule(String? v) {
      final value = (v ?? '').trim();
      return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)
          ? null
          : l10n.invalidEmail;
    }

    String? passwordRule(String? v) =>
        (v ?? '').length < 8 ? l10n.passwordTooShort : null;

    String? confirmRule(String? v) =>
        v == _password.text ? null : l10n.passwordsDontMatch;

    final toggle = IconButton(
      icon: Icon(
        _hidePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: AppColors.muted,
      ),
      onPressed: () => setState(() => _hidePassword = !_hidePassword),
    );

    return Form(
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
            validator: emailRule,
          ),
          const SizedBox(height: 16),
          LabeledField(
            label: l10n.passwordLabel,
            controller: _password,
            helper: l10n.passwordHelper,
            obscureText: _hidePassword,
            suffixIcon: toggle,
            validator: passwordRule,
          ),
          const SizedBox(height: 16),
          LabeledField(
            label: l10n.confirmPasswordLabel,
            controller: _confirm,
            obscureText: _hidePassword,
            validator: confirmRule,
          ),
          const SizedBox(height: 28),
          LoadingButton(
            label: l10n.sendCode,
            loading: _busy,
            onPressed: _sendCode,
          ),
          const SizedBox(height: 16),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  l10n.haveAccount,
                  style: const TextStyle(color: AppColors.muted),
                ),
                TextButton(
                  onPressed: _busy ? null : _goLogin,
                  child: Text(l10n.logIn),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _codeForm(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledField(
          label: l10n.codeLabel,
          controller: _code,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: 8,
          ),
        ),
        const SizedBox(height: 28),
        LoadingButton(
          label: l10n.verifyAndCreate,
          loading: _busy,
          onPressed: _verifyAndCreate,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: _busy ? null : _resend,
              child: Text(l10n.resendCode),
            ),
            TextButton(
              onPressed: _busy ? null : _changeEmail,
              child: Text(l10n.changeEmail),
            ),
          ],
        ),
      ],
    );
  }
}