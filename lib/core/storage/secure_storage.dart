import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_constants.dart';

/// Wrapper around [FlutterSecureStorage] for typed access to sensitive data.
/// Never stores tokens in plain SharedPreferences.
class SecureStorage {
  final FlutterSecureStorage _storage;

  const SecureStorage({
    FlutterSecureStorage? storage,
  }) : _storage = storage ?? const FlutterSecureStorage(
          aOptions: AndroidOptions(),
          iOptions: IOSOptions(
            accessibility: KeychainAccessibility.first_unlock_this_device,
          ),
        );

  // ── Tokens ────────────────────────────────────────────────────────────────

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: AppConstants.accessTokenKey, value: token);
  }

  Future<String?> getAccessToken() async {
    return _storage.read(key: AppConstants.accessTokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: AppConstants.refreshTokenKey, value: token);
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(key: AppConstants.refreshTokenKey);
  }

  Future<void> saveUserId(String id) async {
    await _storage.write(key: AppConstants.userIdKey, value: id);
  }

  Future<String?> getUserId() async {
    return _storage.read(key: AppConstants.userIdKey);
  }

  Future<bool> get hasValidSession async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
