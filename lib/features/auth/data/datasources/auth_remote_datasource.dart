import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login({
    required String identifier,
    required String password,
  });

  Future<AuthResponseModel?> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  });

  Future<void> logout();

  Future<AuthResponseModel> getCurrentUser();

  Future<void> forgotPassword({required String email});

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  Future<AuthResponseModel> login({
    required String identifier,
    required String password,
  }) async {
    try {
      final res = await _client.auth.signInWithPassword(
        email: identifier,
        password: password,
      );
      return _toModel(res);
    } on AuthException catch (e) {
      throw AuthenticationException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  /// Returns null when email confirmation is required (session will be null).
  @override
  Future<AuthResponseModel?> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final res = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone': phone,
        },
      );

      // session is null when email confirmation is required
      if (res.session == null) {
        return null; // signals "pending confirmation" to the repository
      }

      return _toModel(res);
    } on AuthException catch (e) {
      throw AuthenticationException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  @override
  Future<void> logout() async {
    await _client.auth.signOut();
  }

  @override
  Future<AuthResponseModel> getCurrentUser() async {
    final session = _client.auth.currentSession;
    final supaUser = _client.auth.currentUser;
    if (session == null || supaUser == null) {
      throw const AuthenticationException(message: 'No active session');
    }
    return AuthResponseModel(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken ?? '',
      user: _userModelFromSupabase(supaUser),
    );
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await _client.auth.resetPasswordForEmail(
        email,
        redirectTo: 'amtips://auth/callback',
      );
    } on AuthException catch (e) {
      throw ServerException(message: e.message, statusCode: null);
    }
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      await _client.auth.updateUser(UserAttributes(password: newPassword));
    } on AuthException catch (e) {
      throw ServerException(message: e.message, statusCode: null);
    }
  }

  AuthResponseModel _toModel(AuthResponse res) {
    final session = res.session;
    final user = res.user;
    if (session == null || user == null) {
      throw const AuthenticationException(message: 'Authentication failed');
    }
    return AuthResponseModel(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken ?? '',
      user: _userModelFromSupabase(user),
    );
  }

  UserModel _userModelFromSupabase(User user) {
    final meta = user.userMetadata ?? {};
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      phone: user.phone,
      fullName: meta['full_name'] as String? ?? '',
      avatarUrl: meta['avatar_url'] as String?,
      isOnboardingComplete:
          meta['is_onboarding_complete'] as bool? ?? false,
      createdAt: DateTime.parse(user.createdAt),
    );
  }
}
