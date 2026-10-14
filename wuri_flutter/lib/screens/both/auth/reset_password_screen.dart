import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/screens/both/auth/after_sign_in.dart';
import 'package:wuri_flutter/utils/snackbar.dart';
import 'package:wuri_flutter/widgets/auth_scaffold.dart';
import 'package:wuri_flutter/widgets/labeled_field.dart';
import 'package:wuri_flutter/widgets/loading_button.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({
    super.key,
    this.initialEmail,
    this.accountPasswordChange = false,
  });

  final String? initialEmail;
  final bool accountPasswordChange;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  late final EmailAuthController _auth;
  final _email = TextEditingController();
  final _code = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _busy = false;
  int _step = 1;

  @override
  void initState() {
    super.initState();
    if (widget.initialEmail != null) {
      _email.text = widget.initialEmail!;
    }
    _auth = EmailAuthController(
      client: client,
      startScreen: EmailFlowScreen.requestPasswordReset,
      onAuthenticated: () {
        if (mounted) goAfterSignIn(context, ref, null);
      },
      onError: (_) {},
    );
  }

  @override
  void dispose() {
    _auth.dispose();
    _email.dispose();
    _code.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _busy = true);
    try {
      await action();
    } catch (_) {
      if (mounted) {
        final message =
            _auth.errorMessage ?? AppLocalizations.of(context)!.genericError;
        showAppSnackBar(context, message);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _sendCode() async {
    final l10n = AppLocalizations.of(context)!;
    if (_email.text.trim().isEmpty) {
      showAppSnackBar(context, l10n.fieldRequired);
      return;
    }
    await _run(() async {
      _auth.emailController.text = _email.text.trim();
      await _auth.startPasswordReset();
      if (mounted) setState(() => _step = 2);
    });
  }

  Future<void> _verifyCode() async {
    if (_code.text.trim().isEmpty) {
      showAppSnackBar(context, AppLocalizations.of(context)!.fieldRequired);
      return;
    }
    await _run(() async {
      _auth.verificationCodeController.text = _code.text.trim();
      await _auth.verifyPasswordResetCode();
      if (mounted) setState(() => _step = 3);
    });
  }

  Future<void> _finish() async {
    final l10n = AppLocalizations.of(context)!;
    if (_password.text.length < 8) {
      showAppSnackBar(context, l10n.passwordTooShort);
      return;
    }
    if (_password.text != _confirm.text) {
      showAppSnackBar(context, l10n.passwordsDontMatch);
      return;
    }
    await _run(() async {
      _auth.passwordController.text = _password.text;
      await _auth.finishPasswordReset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AuthScaffold(
      step: _step,
      title: switch (_step) {
        1 =>
          widget.accountPasswordChange
              ? l10n.changePasswordTitle
              : l10n.resetPasswordTitle,
        2 => l10n.verifyResetTitle,
        _ => l10n.newPasswordTitle,
      },
      subtitle: switch (_step) {
        1 => l10n.resetPasswordSubtitle,
        2 => l10n.verifyBody(_email.text.trim()),
        _ => l10n.newPasswordSubtitle,
      },
      onBack: _step == 1 ? null : () => setState(() => _step--),
      child: switch (_step) {
        1 => _emailForm(l10n),
        2 => _codeForm(l10n),
        _ => _passwordForm(l10n),
      },
    );
  }

  Widget _emailForm(AppLocalizations l10n) => Column(
    children: [
      LabeledField(
        label: l10n.emailLabel,
        controller: _email,
        hint: l10n.emailHint,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
      ),
      const SizedBox(height: 28),
      LoadingButton(
        label: l10n.sendResetCode,
        loading: _busy,
        onPressed: _sendCode,
      ),
    ],
  );

  Widget _codeForm(AppLocalizations l10n) => Column(
    children: [
      LabeledField(
        label: l10n.codeLabel,
        controller: _code,
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 28),
      LoadingButton(
        label: l10n.verifyCode,
        loading: _busy,
        onPressed: _verifyCode,
      ),
      TextButton(
        onPressed: _busy ? null : () => _run(_auth.resendVerificationCode),
        child: Text(l10n.resendCode),
      ),
    ],
  );

  Widget _passwordForm(AppLocalizations l10n) => Column(
    children: [
      LabeledField(
        label: l10n.passwordLabel,
        controller: _password,
        obscureText: true,
        helper: l10n.passwordHelper,
      ),
      const SizedBox(height: 16),
      LabeledField(
        label: l10n.confirmPasswordLabel,
        controller: _confirm,
        obscureText: true,
      ),
      const SizedBox(height: 28),
      LoadingButton(
        label: l10n.resetPassword,
        loading: _busy,
        onPressed: _finish,
      ),
    ],
  );
}
