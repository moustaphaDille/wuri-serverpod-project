import 'package:flutter/material.dart';

import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/screens/both/auth/reset_password_screen.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: client.modules.serverpod_auth_core.userProfileInfo.get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return ResetPasswordScreen(
          initialEmail: snapshot.data?.email,
          accountPasswordChange: true,
        );
      },
    );
  }
}
