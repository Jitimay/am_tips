import 'dart:async';
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
    final errorStr = details.exceptionAsString();
    final isOverflow = errorStr.contains('overflowed by') ||
        (details.library == 'rendering library' && details.silent);
    if (!isOverflow) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    } else {
      FirebaseCrashlytics.instance.recordError(
        details.exception,
        details.stack,
        reason: 'Render overflow (non-fatal UI layout clipping)',
        fatal: false,
      );
    }
    debugPrint('[FlutterError] $errorStr');
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
  StreamSubscription<fb_auth.User?>? _authSub;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }

  Future<void> _resetAndRetry() async {
    await _authSub?.cancel();
    _authSub = null;
    if (mounted) {
      setState(() {
        _errorMessage = null;
        _ready = false;
      });
    }
    await _bootstrap();
  }

  Future<void> _recordBootstrapError(
    String stage,
    Object error,
    StackTrace stack, {
    bool fatal = false,
  }) async {
    debugPrint('[Bootstrap][$stage] ${fatal ? "Fatal" : "Non-fatal"} error: $error\n$stack');
    try {
      await FirebaseCrashlytics.instance.setCustomKey('bootstrap_stage', stage);
      await FirebaseCrashlytics.instance.recordError(error, stack, fatal: fatal);
    } catch (e) {
      debugPrint('[Crashlytics] Failed to record bootstrap error for stage $stage: $e');
    }
  }

  Future<void> _bootstrap() async {
    // 1. Firebase init
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FirebaseMessaging.onBackgroundMessage(
          firebaseMessagingBackgroundHandler);
    } catch (e, st) {
      await _recordBootstrapError('FirebaseInit', e, st, fatal: false);
    }

    // 2. Supabase init
    try {
      await Supabase.initialize(
        url: AppConstants.supabaseUrl,
        // ignore: deprecated_member_use
        anonKey: AppConstants.supabaseAnonKey,
      );
    } catch (e, st) {
      // Safe to ignore if already initialized; otherwise log non-fatally
      if (!e.toString().contains('already initialized')) {
        await _recordBootstrapError('SupabaseInit', e, st, fatal: false);
      }
    }

    // 3. System Chrome orientation & status bar styling
    try {
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
    } catch (e, st) {
      await _recordBootstrapError('SystemChrome', e, st, fatal: false);
    }

    // 4. Dependency Injection Configuration
    try {
      await configureDependencies();
    } catch (e, st) {
      await _recordBootstrapError('DependencyInjection', e, st, fatal: true);
      if (mounted) {
        setState(() => _errorMessage =
            'Could not start amTips.\n\n${e.toString().split('\n').first}');
      }
      return;
    }

    // 5. Isar Offline Database Initialization
    try {
      await sl<IsarDatabaseService>().db;
    } catch (e, st) {
      await _recordBootstrapError('IsarDatabase', e, st, fatal: false);
    }

    // 6. Connectivity Sync Manager Initialization
    try {
      await sl<SyncManager>().initialize();
    } catch (e, st) {
      await _recordBootstrapError('SyncManager', e, st, fatal: false);
    }

    // 7. Push Notifications Initialization
    try {
      await sl<PushNotificationService>().initialize();
    } catch (e, st) {
      await _recordBootstrapError('PushNotificationService', e, st, fatal: false);
    }

    // 8. Firebase Auth State Listener (Keep Supabase UID header in sync)
    try {
      await _authSub?.cancel();
      _authSub = fb_auth.FirebaseAuth.instance.authStateChanges().listen((user) {
        try {
          final currentHeaders =
              Map<String, String>.from(Supabase.instance.client.headers);
          if (user != null) {
            currentHeaders['x-firebase-uid'] = user.uid;
            Supabase.instance.client.headers = currentHeaders;
            if (user.emailVerified) {
              sl<PushNotificationService>().syncToken();
            }
          } else {
            currentHeaders.remove('x-firebase-uid');
            Supabase.instance.client.headers = currentHeaders;
          }
        } catch (e, st) {
          debugPrint('[AuthStateListener] Error handling auth state change: $e\n$st');
        }
      });
    } catch (e, st) {
      await _recordBootstrapError('AuthStateListener', e, st, fatal: false);
    }

    // 9. One-time migration: check onboarding status
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey(AppConstants.onboardingCompleteKey)) {
        final fbUser = fb_auth.FirebaseAuth.instance.currentUser;
        if (fbUser != null && fbUser.emailVerified) {
          await prefs.setBool(AppConstants.onboardingCompleteKey, true);
        }
      }
    } catch (e, st) {
      await _recordBootstrapError('OnboardingMigration', e, st, fatal: false);
    }

    if (mounted) {
      setState(() => _ready = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return _ErrorScreen(
        message: _errorMessage!,
        onRetry: _resetAndRetry,
      );
    }
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
  final VoidCallback onRetry;
  const _ErrorScreen({required this.message, required this.onRetry});

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
                onPressed: onRetry,
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
