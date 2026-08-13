/// All backend API endpoint paths.
class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  // Profile
  static const String profile = '/profile';
  static const String updateProfile = '/profile';
  static const String uploadAvatar = '/profile/avatar';
  static String publicProfile(String waiterId) => '/public/waiters/$waiterId';

  // QR Code
  static const String generateQr = '/qr/generate';
  static const String myQr = '/qr/me';

  // Tips
  static const String tips = '/tips';
  static String tipById(String id) => '/tips/$id';
  static const String tipStats = '/tips/stats';

  // Customer tipping (public endpoints — no auth)
  static String waiterPublicProfile(String waiterId) =>
      '/public/waiters/$waiterId';
  static String initiateTip(String waiterId) =>
      '/public/waiters/$waiterId/tips';
  static String tipPaymentStatus(String tipId) => '/public/tips/$tipId/status';
  static String completeTip(String tipId) => '/public/tips/$tipId/complete';

  // Payments
  static const String paymentMethods = '/payments/methods';
  static String initiatePayment(String tipId) => '/payments/$tipId/initiate';
  static String paymentStatus(String paymentId) =>
      '/payments/$paymentId/status';

  // Wallet
  static const String wallet = '/wallet';
  static const String walletTransactions = '/wallet/transactions';

  // Withdrawals
  static const String withdrawals = '/withdrawals';
  static String withdrawalById(String id) => '/withdrawals/$id';

  // Notifications
  static const String notifications = '/notifications';
  static String markNotificationRead(String id) => '/notifications/$id/read';
  static const String markAllNotificationsRead = '/notifications/read-all';
  static const String registerPushToken = '/notifications/push-token';

  // Settings
  static const String settings = '/settings';
  static const String changePassword = '/settings/change-password';
  static const String deleteAccount = '/settings/account';
}
