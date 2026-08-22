import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'core/constants/app_constants.dart';
import 'core/di/injection.dart';
import 'core/services/push_notification_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase Authentication & Services
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') rethrow;
  } catch (e) {
    if (!e.toString().contains('duplicate-app')) rethrow;
  }

  // Register top-level Firebase Cloud Messaging background handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Initialize Supabase (used exclusively for File Storage)
  try {
    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      // ignore: deprecated_member_use
      anonKey: AppConstants.supabaseAnonKey,
    );
  } catch (_) {
    // Already initialized in current isolate/session
  }


  // Lock to portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI appearance
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // Wire up all dependencies
  await configureDependencies();

  // Initialize Firebase Cloud Messaging & Notification handlers
  await sl<PushNotificationService>().initialize();

  // Keep Supabase x-firebase-uid header and FCM push token in sync with Firebase auth state.
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

  // One-time migration: if user is already verified, assume onboarding done
  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey(AppConstants.onboardingCompleteKey)) {
    final fbUser = fb_auth.FirebaseAuth.instance.currentUser;
    if (fbUser != null && fbUser.emailVerified) {
      await prefs.setBool(AppConstants.onboardingCompleteKey, true);
    }
  }

  runApp(const AmTipsApp());
}
