import 'app_secrets.dart';

/// Central application constants for amTips.
class AppConstants {
  AppConstants._();

  // App
  static const String appName = 'amTips';
  static const String appTagline = 'Tip the people who make your experience better.';

  // Supabase — actual values live in app_secrets.dart (gitignored)
  static const String supabaseUrl = AppSecrets.supabaseUrl;
  static const String supabaseAnonKey = AppSecrets.supabaseAnonKey;

  // Base URLs – override via environment / build flavor
  static const String baseUrl = 'https://api.amtips.app/v1';
  static const String webBaseUrl = 'https://amtips.app';
  static const String tipBaseUrl = '$webBaseUrl/t';

  // Token storage keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';

  // Cache keys
  static const String cachedProfileKey = 'cached_profile';
  static const String cachedTipsKey = 'cached_tips';
  static const String cachedWalletKey = 'cached_wallet';
  static const String onboardingCompleteKey = 'onboarding_complete';

  // Hive box names
  static const String profileBox = 'profile_box';
  static const String tipsBox = 'tips_box';
  static const String walletBox = 'wallet_box';
  static const String settingsBox = 'settings_box';

  // Network timeouts (ms)
  static const int connectTimeout = 10000;
  static const int receiveTimeout = 10000;
  static const int sendTimeout = 10000;

  // Pagination
  static const int defaultPageSize = 20;

  // Tip preset amounts (in minor currency units / BIF)
  static const List<int> tipPresets = [1000, 2000, 5000, 10000];

  // Withdrawal limits
  static const int minWithdrawalAmount = 1000;
  static const int maxWithdrawalAmount = 1000000;

  // QR code size
  static const double qrSize = 280.0;
  static const double qrSizeEnlarged = 350.0;

  // Rating
  static const int maxRating = 5;
  static const int maxMessageLength = 200;

  // Currencies
  static const String defaultCurrency = 'BIF';
  static const List<String> supportedCurrencies = [
    'BIF', 'USD', 'EUR', 'KES', 'UGX', 'RWF', 'TZS',
  ];

  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);
}
