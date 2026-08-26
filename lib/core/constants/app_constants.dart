import 'app_secrets.dart';

/// Central application constants for amTips.
class AppConstants {
  AppConstants._();

  // App
  static const String appName = 'amTips';
  static const String appTagline = 'Tip the people who make your experience better.';
  static const String privacyPolicyUrl = 'https://amtips.app/privacy';
  static const String termsOfServiceUrl = 'https://amtips.app/terms';

  // Supabase Storage — actual values live in app_secrets.dart (gitignored)
  static const String supabaseUrl = AppSecrets.supabaseUrl;
  static const String supabaseAnonKey = AppSecrets.supabaseAnonKey;
  static const String supabaseStorageBucket = AppSecrets.supabaseStorageBucket;
  static const String avatarsBucket = 'avatars';
  static const String qrBucket = 'qr-codes';
  static const String uploadsBucket = 'user-uploads';

  // Base URLs – override via environment / build flavor
  static const String baseUrl = 'https://api.amtips.app/v1';
  // Update to your Vercel deployment URL (or custom domain once configured).
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
  static const String balanceVisibleKey = 'balance_visible';

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
  static const List<int> tipPresets = [2000, 5000, 10000, 20000];

  // ── AfriPay Payment Gateway ───────────────────────────────────────────────
  static const String afriPayAppId       = AppSecrets.afriPayAppId;
  static const String afriPayAppSecret   = AppSecrets.afriPayAppSecret;
  static const String afriPayCheckoutUrl = AppSecrets.afriPayCheckoutUrl;
  static const String afriPayCallbackUrl = AppSecrets.afriPayCallbackUrl;
  static const String afriPayReturnUrl   = AppSecrets.afriPayReturnUrl;

  /// AfriPay charges 4% on every payment.
  static const double afriPayFeePercent = 0.04;

  /// amTips platform fee (6% platform cut retained by amTips).
  static const double amTipsPlatformFeePercent = 0.06;

  /// Total fee deduction (4% AfriPay + 6% amTips = 10%).
  static double get totalFeePercent =>
      afriPayFeePercent + amTipsPlatformFeePercent;

  /// Platform fee on withdrawal — amTips charges 0%.
  /// Note: LumiCash deducts their own 3% directly from the payout; that is
  /// between the user and LumiCash and is NOT collected by amTips.
  static const double platformWithdrawalFeePercent = 0.00;

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
