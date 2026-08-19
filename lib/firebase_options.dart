import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'core/constants/app_secrets.dart';

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: AppSecrets.firebaseApiKeyWeb,
    appId: AppSecrets.firebaseAppIdWeb,
    messagingSenderId: AppSecrets.firebaseMessagingSenderId,
    projectId: AppSecrets.firebaseProjectId,
    authDomain: AppSecrets.firebaseAuthDomain,
    storageBucket: AppSecrets.firebaseStorageBucket,
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: AppSecrets.firebaseApiKeyAndroid,
    appId: AppSecrets.firebaseAppIdAndroid,
    messagingSenderId: AppSecrets.firebaseMessagingSenderId,
    projectId: AppSecrets.firebaseProjectId,
    storageBucket: AppSecrets.firebaseStorageBucket,
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: AppSecrets.firebaseApiKeyIos,
    appId: AppSecrets.firebaseAppIdIos,
    messagingSenderId: AppSecrets.firebaseMessagingSenderId,
    projectId: AppSecrets.firebaseProjectId,
    storageBucket: AppSecrets.firebaseStorageBucket,
    iosBundleId: 'com.example.amTips',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: AppSecrets.firebaseApiKeyIos,
    appId: AppSecrets.firebaseAppIdIos,
    messagingSenderId: AppSecrets.firebaseMessagingSenderId,
    projectId: AppSecrets.firebaseProjectId,
    storageBucket: AppSecrets.firebaseStorageBucket,
    iosBundleId: 'com.example.amTips',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: AppSecrets.firebaseApiKeyWeb,
    appId: AppSecrets.firebaseAppIdWeb,
    messagingSenderId: AppSecrets.firebaseMessagingSenderId,
    projectId: AppSecrets.firebaseProjectId,
    authDomain: AppSecrets.firebaseAuthDomain,
    storageBucket: AppSecrets.firebaseStorageBucket,
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: AppSecrets.firebaseApiKeyWeb,
    appId: AppSecrets.firebaseAppIdWeb,
    messagingSenderId: AppSecrets.firebaseMessagingSenderId,
    projectId: AppSecrets.firebaseProjectId,
    authDomain: AppSecrets.firebaseAuthDomain,
    storageBucket: AppSecrets.firebaseStorageBucket,
  );
}
