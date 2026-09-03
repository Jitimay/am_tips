import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/verify_email_page.dart';
import '../../features/customer/pages/search_page.dart';
import '../../features/customer/pages/customer_payment_page.dart';
import '../../features/customer/pages/customer_profile_page.dart';
import '../../features/customer/pages/customer_success_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/qr_code/presentation/pages/qr_page.dart';
import '../../features/qr_code/presentation/pages/qr_scanner_page.dart';
import '../../features/qr_code/presentation/pages/campaign_card_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/privacy_policy_page.dart';
import '../../features/settings/presentation/pages/terms_of_service_page.dart';
import '../../features/tips/presentation/pages/tip_detail_page.dart';
import '../../features/tips/presentation/pages/tips_page.dart';
import '../../features/tips/presentation/pages/analytics_page.dart';
import '../../features/wallet/presentation/pages/wallet_page.dart';
import '../../features/withdrawals/presentation/pages/withdrawal_page.dart';
import '../../app/app_shell.dart';
import '../di/injection.dart';
import '../storage/secure_storage.dart';

/// Route name constants — use these throughout the app.
class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const verifyEmail = '/verify-email';
  static const forgotPassword = '/forgot-password';
  static const onboarding = '/onboarding';

  static const home = '/home';
  static const tips = '/tips';
  static const campaign = '/campaign';
  static const qr = '/qr';
  static const scanner = '/scanner';
  static const wallet = '/wallet';
  static const profile = '/profile';

  static const withdraw = '/wallet/withdraw';
  static const editProfile = '/profile/edit';
  static const notifications = '/notifications';
  static const settings = '/settings';
  static const privacy = '/privacy';
  static const terms = '/terms';
  static const search = '/search';
  static const analytics = '/analytics';

  static const customerProfile = '/t/:waiterId';
}

const _publicRoutes = {
  AppRoutes.splash,
  AppRoutes.login,
  AppRoutes.register,
  AppRoutes.verifyEmail,
  AppRoutes.forgotPassword,
  AppRoutes.onboarding,
};

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      final location = state.matchedLocation;
      if (_publicRoutes.contains(location) || location.startsWith('/t/')) {
        return null;
      }

      // hasValidSession reads Firebase's LOCAL cached state — no network needed.
      // We add a short timeout as a safety net in case Firebase takes too long
      // to restore its local state on a cold start.
      bool hasSession = false;
      try {
        hasSession = await sl<SecureStorage>()
            .hasValidSession
            .timeout(const Duration(seconds: 3));
      } catch (_) {
        // Timeout or error — keep user where they are rather than kick to login.
        // They'll be redirected on next navigation attempt if truly unauthenticated.
        hasSession = false;
      }

      if (!hasSession) return AppRoutes.login;
      return null;
    },
    routes: [
      // ── Auth ──────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, _) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, _) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, _) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.verifyEmail,
        builder: (_, state) => VerifyEmailPage(
          email: state.extra as String?,
        ),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (_, _) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (_, _) => const OnboardingPage(),
      ),

      // ── Main shell ────────────────────────────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (_, _) => const HomePage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.tips,
              builder: (_, _) => const TipsPage(),
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
              path: AppRoutes.campaign,
              builder: (_, _) => const CampaignCardPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.wallet,
              builder: (_, _) => const WalletPage(),
              routes: [
                GoRoute(
                  path: 'withdraw',
                  builder: (_, _) => const WithdrawalPage(),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (_, _) => const ProfilePage(),
              routes: [
                GoRoute(
                  path: 'edit',
                  builder: (_, _) => const EditProfilePage(),
                ),
              ],
            ),
          ]),
        ],
      ),

      // ── Standalone modal routes ───────────────────────────────────────────
      GoRoute(
        path: AppRoutes.qr,
        builder: (_, _) => const QrPage(),
      ),
      GoRoute(
        path: AppRoutes.scanner,
        builder: (_, _) => const QrScannerPage(),
      ),
      GoRoute(
        path: AppRoutes.analytics,
        builder: (_, _) => const AnalyticsPage(),
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (_, _) => const SearchPage(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (_, _) => const NotificationsPage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (_, _) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.privacy,
        builder: (_, _) => const PrivacyPolicyPage(),
      ),
      GoRoute(
        path: AppRoutes.terms,
        builder: (_, _) => const TermsOfServicePage(),
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
