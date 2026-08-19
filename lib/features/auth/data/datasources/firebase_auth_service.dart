import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/auth_response_model.dart';

/// Dedicated service encapsulating Firebase Authentication SDK interactions.
///
/// Handles email/password registration, login, email verification,
/// password reset, and user session management.
class FirebaseAuthService {
  final fb.FirebaseAuth _auth;

  FirebaseAuthService({fb.FirebaseAuth? auth})
      : _auth = auth ?? fb.FirebaseAuth.instance;

  /// Returns the current Firebase User, if signed in.
  fb.User? get currentUser => _auth.currentUser;

  /// Registers a new user with Firebase Authentication.
  ///
  /// 1. Creates the Firebase user.
  /// 2. Sets the user's display name.
  /// 3. Sends a verification email.
  /// 4. Returns the AuthResponseModel.
  Future<AuthResponseModel> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw const AuthenticationException(
          message: 'Failed to create user account.',
        );
      }

      // Set display name on Firebase user
      if (fullName.isNotEmpty) {
        await user.updateDisplayName(fullName);
      }

      // Send email verification link
      try {
        await user.sendEmailVerification();
        debugPrint('[FirebaseAuthService] Verification email sent successfully to ${user.email}');
      } catch (e) {
        debugPrint('[FirebaseAuthService] Warning: Failed to send verification email: $e');
        // Do not fail registration if only email dispatch hit temporary rate limit
      }

      // Get initial ID token
      final token = await user.getIdToken() ?? '';

      return _toAuthResponseModel(
        user: user,
        token: token,
        fallbackName: fullName,
        fallbackPhone: phone,
      );
    } on fb.FirebaseAuthException catch (e) {
      debugPrint('[FirebaseAuthService] FirebaseAuthException during register: ${e.code} - ${e.message}');
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      debugPrint('[FirebaseAuthService] Unexpected exception during register: $e');
      if (e is AuthenticationException || e is ServerException) rethrow;
      throw ServerException(message: e.toString(), statusCode: null);
    }

  }

  /// Signs in an existing user with email and password.
  ///
  /// Refreshes the user to get the latest `emailVerified` status.
  /// Throws [EmailNotVerifiedException] if the email has not been verified yet.
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw const AuthenticationException(
          message: 'User authentication failed.',
        );
      }

      // Refresh to ensure we have the latest emailVerified status
      await user.reload();
      final refreshedUser = _auth.currentUser ?? user;

      if (!refreshedUser.emailVerified) {
        throw EmailNotVerifiedException(
          email: refreshedUser.email ?? email,
          message: 'Please verify your email before accessing your account.',
        );
      }

      final token = await refreshedUser.getIdToken() ?? '';
      return _toAuthResponseModel(user: refreshedUser, token: token);
    } on fb.FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      if (e is EmailNotVerifiedException ||
          e is AuthenticationException ||
          e is ServerException) {
        rethrow;
      }
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  /// Sends (or resends) an email verification link to the current signed-in user.
  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const AuthenticationException(
          message: 'No user is currently signed in.',
        );
      }
      await user.sendEmailVerification();
      debugPrint('[FirebaseAuthService] Resent verification email to ${user.email}');
    } on fb.FirebaseAuthException catch (e) {
      debugPrint('[FirebaseAuthService] Error resending verification email: ${e.code} - ${e.message}');
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      debugPrint('[FirebaseAuthService] Unexpected error sending verification email: $e');
      if (e is AuthenticationException || e is ServerException) rethrow;
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  /// Reloads the current Firebase user and returns whether the email is verified.
  Future<bool> checkEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;
      await user.reload();
      final refreshed = _auth.currentUser;
      debugPrint('[FirebaseAuthService] checkEmailVerification: email=${refreshed?.email}, emailVerified=${refreshed?.emailVerified}');
      return refreshed?.emailVerified ?? false;
    } catch (e) {
      debugPrint('[FirebaseAuthService] checkEmailVerification error: $e');
      return false;
    }
  }


  /// Refreshes and returns the current user model.
  Future<AuthResponseModel> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const AuthenticationException(message: 'No active session.');
      }
      await user.reload();
      final refreshedUser = _auth.currentUser ?? user;

      if (!refreshedUser.emailVerified) {
        throw EmailNotVerifiedException(
          email: refreshedUser.email ?? '',
          message: 'Email is not verified.',
        );
      }

      final token = await refreshedUser.getIdToken() ?? '';
      return _toAuthResponseModel(user: refreshedUser, token: token);
    } on fb.FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      if (e is EmailNotVerifiedException ||
          e is AuthenticationException ||
          e is ServerException) {
        rethrow;
      }
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  /// Sends a password reset email via Firebase.
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on fb.FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      if (e is AuthenticationException || e is ServerException) rethrow;
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  /// Confirms password reset with code and new password.
  Future<void> confirmPasswordReset({
    required String code,
    required String newPassword,
  }) async {
    try {
      await _auth.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
    } on fb.FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      if (e is AuthenticationException || e is ServerException) rethrow;
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  /// Signs out the current Firebase user.
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw ServerException(
        message: 'Failed to sign out: $e',
        statusCode: null,
      );
    }
  }

  AuthResponseModel _toAuthResponseModel({
    required fb.User user,
    required String token,
    String? fallbackName,
    String? fallbackPhone,
  }) {
    final now = DateTime.now();
    final createdAt = user.metadata.creationTime ?? now;
    final updatedAt = user.metadata.lastSignInTime ?? now;

    return AuthResponseModel(
      accessToken: token,
      refreshToken: user.refreshToken ?? '',
      user: UserModel(
        id: user.uid,
        email: user.email ?? '',
        phone: user.phoneNumber ?? fallbackPhone,
        fullName: user.displayName ?? fallbackName ?? '',
        avatarUrl: user.photoURL,
        isOnboardingComplete: false,
        createdAt: createdAt,
        updatedAt: updatedAt,
      ),
    );
  }

  Exception _mapFirebaseAuthException(fb.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return const AuthenticationException(
          message: 'No account found with this email address.',
        );
      case 'wrong-password':
      case 'invalid-credential':
        return const AuthenticationException(
          message: 'Invalid email or password. Please check your credentials.',
        );
      case 'email-already-in-use':
        return const AuthenticationException(
          message: 'An account with this email address already exists.',
        );
      case 'invalid-email':
        return const AuthenticationException(
          message: 'Please enter a valid email address.',
        );
      case 'weak-password':
        return const AuthenticationException(
          message: 'The password is too weak. Please choose a stronger password.',
        );
      case 'user-disabled':
        return const AuthenticationException(
          message: 'This account has been disabled. Please contact support.',
        );
      case 'too-many-requests':
        return const AuthenticationException(
          message: 'Too many attempts. Please try again later.',
        );
      case 'network-request-failed':
        return const NetworkException(
          message: 'Network error. Please check your internet connection.',
        );
      case 'expired-action-code':
        return const ServerException(
          message: 'The verification or reset link has expired.',
          statusCode: 400,
        );
      case 'invalid-action-code':
        return const ServerException(
          message: 'The verification or reset link is invalid.',
          statusCode: 400,
        );
      default:
        return AuthenticationException(
          message: e.message ?? 'Authentication error (${e.code}).',
        );
    }
  }
}
