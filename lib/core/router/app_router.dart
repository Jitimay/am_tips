import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/customer/pages/customer_payment_page.dart';
import '../../features/customer/pages/customer_profile_page.dart';
import '../../features/customer/pages/customer_success_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/qr_code/presentation/pages/qr_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/tips/presentation/pages/tip_detail_page.dart';
import '../../features/tips/presentation/pages/tips_page.dart';
import '../../features/wallet/presentation/pages/wallet_page.dart';
import '../../features/withdrawals/presentation/pages/withdrawal_page.dart';
import '../../app/app_shell.dart';

/// Route name constants — use these throughout the app.
class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const onboarding = '/onboarding';

  static const home = '/home';
  static const tips = '/tips';
  static const qr = '/qr';
  static const wallet = '/wallet';
  static const profile = '/profile';

  static const withdraw = '/wallet/withdraw';
  static const editProfile = '/profile/edit';
  static const notifications = '/notifications';
  static const settings = '/settings';

  static const customerProfile = '/t/:waiterId';
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      // ── Auth ──────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, __) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (_, __) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (_, __) => const OnboardingPage(),
      ),

      // ── Main shell ────────────────────────────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (_, __) => const HomePage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.tips,
              builder: (_, __) => const TipsPage(),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (_, state) =>
                      TipDetailPage(tipId: state.pathParameters['id']!),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.qr,
              builder: (_, __) => const QrPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.wallet,
              builder: (_, __) => const WalletPage(),
              routes: [
                GoRoute(
                  path: 'withdraw',
                  builder: (_, __) => const WithdrawalPage(),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (_, __) => const ProfilePage(),
              routes: [
                GoRoute(
                  path: 'edit',
                  builder: (_, __) => const EditProfilePage(),
                ),
              ],
            ),
          ]),
        ],
      ),

      // ── Standalone modal routes ───────────────────────────────────────────
      GoRoute(
        path: AppRoutes.notifications,
        builder: (_, __) => const NotificationsPage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (_, __) => const SettingsPage(),
      ),

      // ── Public customer tipping flow ──────────────────────────────────────
      GoRoute(
        path: '/t/:waiterId',
        builder: (_, state) =>
            CustomerProfilePage(waiterId: state.pathParameters['waiterId']!),
        routes: [
          GoRoute(
            path: 'payment',
            builder: (_, state) => CustomerPaymentPage(
              waiterId: state.pathParameters['waiterId']!,
              extra: state.extra as Map<String, dynamic>? ?? {},
            ),
          ),
          GoRoute(
            path: 'success',
            builder: (_, state) => CustomerSuccessPage(
              extra: state.extra as Map<String, dynamic>? ?? {},
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            Text('Page not found', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 6),
            Text(state.uri.toString(),
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    ),
  );
}
