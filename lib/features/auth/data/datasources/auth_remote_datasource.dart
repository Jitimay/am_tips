import '../models/auth_response_model.dart';
import 'firebase_auth_service.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login({
    required String identifier,
    required String password,
  });

  Future<AuthResponseModel> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  });

  Future<void> sendEmailVerification();

  Future<bool> checkEmailVerification();

  Future<void> logout();

  Future<AuthResponseModel> getCurrentUser();

  Future<void> forgotPassword({required String email});

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });

  Future<bool> isSessionValid();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuthService authService;

  AuthRemoteDataSourceImpl({FirebaseAuthService? authService})
      : authService = authService ?? FirebaseAuthService();

  @override
  Future<AuthResponseModel> login({
    required String identifier,
    required String password,
  }) async {
    return authService.login(email: identifier, password: password);
  }

  @override
  Future<AuthResponseModel> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    return authService.register(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
    );
  }

  @override
  Future<void> sendEmailVerification() async {
    return authService.sendEmailVerification();
  }

  @override
  Future<bool> checkEmailVerification() async {
    return authService.checkEmailVerification();
  }

  @override
  Future<void> logout() async {
    return authService.signOut();
  }

  @override
  Future<AuthResponseModel> getCurrentUser() async {
    return authService.getCurrentUser();
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    return authService.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    return authService.confirmPasswordReset(
      code: token,
      newPassword: newPassword,
    );
  }

  @override
  Future<bool> isSessionValid() async {
    final user = authService.currentUser;
    if (user == null) return false;
    return user.emailVerified;
  }
}
