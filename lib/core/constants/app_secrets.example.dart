/// Secret keys — never commit this file.
/// Copy this file to app_secrets.dart and fill in your values.
class AppSecrets {
  AppSecrets._();

  static const String supabaseUrl = 'https://YOUR_PROJECT.supabase.co';
  static const String supabaseAnonKey = 'YOUR_ANON_KEY';
  static const String supabaseStorageBucket = 'avatars';

  // Firebase Configuration (Client SDK credentials)
  static const String firebaseProjectId = 'YOUR_FIREBASE_PROJECT_ID';
  static const String firebaseMessagingSenderId = 'YOUR_SENDER_ID';
  static const String firebaseAuthDomain = 'YOUR_PROJECT.firebaseapp.com';
  static const String firebaseStorageBucket = 'YOUR_PROJECT.appspot.com';
  static const String firebaseApiKeyAndroid = 'YOUR_ANDROID_API_KEY';
  static const String firebaseAppIdAndroid = 'YOUR_ANDROID_APP_ID';
  static const String firebaseApiKeyIos = 'YOUR_IOS_API_KEY';
  static const String firebaseAppIdIos = 'YOUR_IOS_APP_ID';
  static const String firebaseApiKeyWeb = 'YOUR_WEB_API_KEY';
  static const String firebaseAppIdWeb = 'YOUR_WEB_APP_ID';
}

