import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'core/constants/app_constants.dart';
import 'core/di/injection.dart';
import 'core/network/sync_manager.dart';
import 'core/services/push_notification_service.dart';
import 'core/storage/isar_database_service.dart';
import 'core/theme/app_colors.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Catch all uncaught Flutter framework errors and show a friendly screen.
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    debugPrint('[FlutterError] ${details.exceptionAsString()}');
  };

  // Catch all uncaught async errors (Dart zone errors)
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _InitApp(),
    ),
  );
}

class _InitApp extends StatefulWidget {
  @override
  State<_InitApp> createState() => _InitAppState();
}

class _InitAppState extends State<_InitApp> {
  String? _errorMessage;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    try {
      // 1. Firebase init
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }

      // 1b. Crashlytics
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

      // 2. FCM background handler (must be top-level)
      FirebaseMessaging.onBackgroundMessage(
          firebaseMessagingBackgroundHandler);

      // 3. Supabase init
      try {
        await Supabase.initialize(
          url: AppConstants.supabaseUrl,
          // ignore: deprecated_member_use
          anonKey: AppConstants.supabaseAnonKey,
        );
      } catch (_) {
        // Already initialized — safe to ignore
      }

      // 4. Orientation + system UI
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      );

      // 5. Dependency injection
      await configureDependencies();

      // 6. Initialize Isar Offline DB & Connectivity Sync Manager
      try {
        await sl<IsarDatabaseService>().db;
      } catch (e) {
        debugPrint('[Isar] DB initialization warning: $e');
      }
      await sl<SyncManager>().initialize();

      // 7. Push notifications
      await sl<PushNotificationService>().initialize();

      // 7. Keep Supabase UID header in sync with Firebase auth state
      fb_auth.FirebaseAuth.instance.authStateChanges().listen((user) {
        final headers = Supabase.instance.client.headers;
        if (user != null) {
          headers['x-firebase-uid'] = user.uid;
          if (user.emailVerified) {
            sl<PushNotificationService>().syncToken();
          }
        } else {
          headers.remove('x-firebase-uid');
        }
      });

      // 8. One-time migration: if user already verified, mark onboarding done
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey(AppConstants.onboardingCompleteKey)) {
        final fbUser = fb_auth.FirebaseAuth.instance.currentUser;
        if (fbUser != null && fbUser.emailVerified) {
          await prefs.setBool(AppConstants.onboardingCompleteKey, true);
        }
      }

      if (mounted) setState(() => _ready = true);
    } catch (e, st) {
      debugPrint('[Bootstrap] Fatal error: $e\n$st');
      if (mounted) {
        setState(() => _errorMessage =
            'Could not start amTips.\n\n${e.toString().split('\n').first}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) return _ErrorScreen(message: _errorMessage!);
    if (!_ready) return _SplashLoader();
    return const AmTipsApp();
  }
}

// ── Startup loading screen ────────────────────────────────────────────────────
class _SplashLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: const Center(
        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
      ),
    );
  }
}

// ── Startup error screen ──────────────────────────────────────────────────────
class _ErrorScreen extends StatelessWidget {
  final String message;
  const _ErrorScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.error_outline_rounded,
                    size: 40, color: AppColors.error),
              ),
              const SizedBox(height: 24),
              const Text(
                'Something went wrong',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1033),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: Color(0xFF8B8BA0),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  // Restart the app by re-running main
                  main();
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(180, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
