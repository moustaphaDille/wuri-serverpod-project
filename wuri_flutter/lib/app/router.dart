import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/screens/partner/add_space_screen.dart';
import 'package:wuri_flutter/screens/admin/admin_users_screen.dart';
import 'package:wuri_flutter/screens/admin/admin_applications_screen.dart';
import 'package:wuri_flutter/screens/both/auth/login_screen.dart';
import 'package:wuri_flutter/screens/both/auth/register_screen.dart';
import 'package:wuri_flutter/screens/both/auth/reset_password_screen.dart';
import 'package:wuri_flutter/screens/customer/booking_screen.dart';
import 'package:wuri_flutter/screens/customer/bookings_screen.dart';
import 'package:wuri_flutter/screens/both/choose_role_screen.dart';
import 'package:wuri_flutter/screens/both/complete_profile_screen.dart';
import 'package:wuri_flutter/screens/both/explore_screen.dart';
import 'package:wuri_flutter/screens/customer/favorites_screen.dart';
import 'package:wuri_flutter/screens/partner/host_requests_screen.dart';
import 'package:wuri_flutter/screens/partner/my_spaces_tab.dart';
import 'package:wuri_flutter/screens/customer/notifications_screen.dart';
import 'package:wuri_flutter/screens/partner/partner_business_screen.dart';
import 'package:wuri_flutter/screens/customer/payment_screen.dart';
import 'package:wuri_flutter/screens/both/profile_screen.dart';

import 'package:wuri_flutter/screens/both/profile_routes.dart';
import 'package:wuri_flutter/screens/both/settings_screen.dart';
import 'package:wuri_flutter/screens/both/auth/change_password_screen.dart';
import 'package:wuri_flutter/screens/both/shell_scaffold.dart';
import 'package:wuri_flutter/screens/both/space_detail_screen.dart';
import 'package:wuri_flutter/screens/both/splash_screen.dart';
import 'package:wuri_flutter/utils/booking_math.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/auth/register',
        builder: (context, state) =>
            RegisterScreen(redirect: state.uri.queryParameters['redirect']),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) =>
            LoginScreen(redirect: state.uri.queryParameters['redirect']),
      ),
      GoRoute(
        path: '/auth/reset-password',
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      // Ancienne adresse : envoie vers la crÃ©ation de compte, en gardant
      // la page oÃ¹ revenir (utilisÃ©e par la fiche d'un espace).
      GoRoute(
        path: '/sign-in',
        redirect: (context, state) {
          final redirect = state.uri.queryParameters['redirect'];
          return redirect == null
              ? '/auth/register'
              : '/auth/register?redirect=${Uri.encodeComponent(redirect)}';
        },
      ),
      GoRoute(
        path: '/choose-role',
        builder: (context, state) =>
            ChooseRoleScreen(redirect: state.uri.queryParameters['redirect']),
      ),
      GoRoute(
        path: '/complete-profile',
        builder: (context, state) {
          final q = state.uri.queryParameters;
          // Seuls client et partenaire sont possibles ici.
          final role = q['role'] == 'partner'
              ? UserRole.partner
              : UserRole.client;
          return CompleteProfileScreen(role: role, redirect: q['redirect']);
        },
      ),
      GoRoute(
        path: '/partner/business',
        builder: (context, state) => const PartnerBusinessScreen(),
      ),
      GoRoute(
        path: '/host/spaces/new',
        builder: (context, state) => const AddSpaceScreen(),
      ),
      GoRoute(
        path: '/host/requests',
        builder: (context, state) => const HostRequestsScreen(),
      ),
      GoRoute(
        path: '/space/:id',
        builder: (context, state) =>
            SpaceDetailScreen(id: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/space/:id/book',
        builder: (context, state) =>
            BookingScreen(id: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/space/:id/pay',
        builder: (context, state) {
          final q = state.uri.queryParameters;
          return PaymentScreen(
            id: int.parse(state.pathParameters['id']!),
            checkIn: utcDate(DateTime.parse(q['in']!)),
            checkOut: utcDate(DateTime.parse(q['out']!)),
            guests: int.parse(q['guests']!),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ShellScaffold(navigationShell: navigationShell),
        branches: [
          // 0 : recherche
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),
          // 1 : favoris (clients)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                builder: (context, state) => const FavoritesScreen(),
              ),
            ],
          ),
          // 2 : rÃ©servations (clients)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/bookings',
                builder: (context, state) => const BookingsScreen(),
              ),
            ],
          ),
          // 3 : notifications (clients)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/notifications',
                builder: (context, state) => const NotificationsScreen(),
              ),
            ],
          ),
          // 4 : profil
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
              GoRoute(
                path: '/profile/information',
                builder: (context, state) => const ProfileInfoRouteScreen(),
              ),
              GoRoute(
                path: '/profile/edit',
                builder: (context, state) => const EditProfileRouteScreen(),
              ),
              GoRoute(
                path: '/profile/password',
                builder: (context, state) => const ChangePasswordScreen(),
              ),
              GoRoute(
                path: '/profile/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
          // 5 : mes espaces (partenaires)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/partner/spaces',
                builder: (context, state) => const MySpacesTab(),
              ),
            ],
          ),
          // 6 : demandes de rÃ©servation (partenaires vÃ©rifiÃ©s)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/partner/requests',
                builder: (context, state) => const HostRequestsScreen(),
              ),
            ],
          ),
          // 7 : utilisateurs (administrateurs)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/admin/users',
                builder: (context, state) => const AdminUsersScreen(),
              ),
            ],
          ),
          // 8 : demandes de partenaires (administrateurs)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/admin/applications',
                builder: (context, state) =>
                    const AdminApplicationsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
