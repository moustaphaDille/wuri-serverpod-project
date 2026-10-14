import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wuri_flutter/providers/auth_providers.dart';
import 'package:wuri_flutter/screens/both/edit_profile_screen.dart';
import 'package:wuri_flutter/screens/both/profile_info_screen.dart';

class ProfileInfoRouteScreen extends ConsumerWidget {
  const ProfileInfoRouteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    return profile.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => const Scaffold(body: Center(child: Text('Unable to load profile'))),
      data: (value) => value == null
          ? const Scaffold(body: Center(child: Text('Profile not found')))
          : ProfileInfoScreen(profile: value),
    );
  }
}

class EditProfileRouteScreen extends ConsumerWidget {
  const EditProfileRouteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    return profile.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => const Scaffold(body: Center(child: Text('Unable to load profile'))),
      data: (value) => value == null
          ? const Scaffold(body: Center(child: Text('Profile not found')))
          : EditProfileScreen(profile: value),
    );
  }
}
