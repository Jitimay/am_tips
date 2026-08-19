import 'package:am_tips/core/errors/exceptions.dart';
import 'package:am_tips/core/errors/failures.dart';
import 'package:am_tips/core/network/network_info.dart';
import 'package:am_tips/core/storage/secure_storage.dart';
import 'package:am_tips/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:am_tips/features/auth/data/models/auth_response_model.dart';
import 'package:am_tips/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';


class FakeNetworkInfo implements NetworkInfo {
  bool connected = true;
  @override
  Future<bool> get isConnected async => connected;
}

class FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  AuthResponseModel? responseModel;
  bool isVerified = true;
  bool throwUnverifiedOnLogin = false;
  bool throwAuthError = false;

  @override
  Future<AuthResponseModel> login({
    required String identifier,
    required String password,
  }) async {
    if (throwUnverifiedOnLogin) {
      throw EmailNotVerifiedException(
        email: identifier,
        message: 'Please verify your email.',
      );
    }
    if (throwAuthError) {
      throw const AuthenticationException(message: 'Invalid credentials.');
    }
    return responseModel!;
  }

  @override
  Future<AuthResponseModel> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    if (throwAuthError) {
      throw const AuthenticationException(message: 'Account exists.');
    }
    return responseModel!;
  }

  @override
  Future<void> sendEmailVerification() async {}

  @override
  Future<bool> checkEmailVerification() async => isVerified;

  @override
  Future<void> logout() async {}

  @override
  Future<AuthResponseModel> getCurrentUser() async => responseModel!;

  @override
  Future<void> forgotPassword({required String email}) async {}

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {}

  @override
  Future<bool> isSessionValid() async => isVerified;
}

class FakeSecureStorage extends SecureStorage {
  final Map<String, String> _data = {};

  FakeSecureStorage() : super(storage: const FlutterSecureStorage());

  @override
  Future<void> saveAccessToken(String token) async =>
      _data['access_token'] = token;
  @override
  Future<String?> getAccessToken() async => _data['access_token'];
  @override
  Future<void> saveRefreshToken(String token) async =>
      _data['refresh_token'] = token;
  @override
  Future<String?> getRefreshToken() async => _data['refresh_token'];
  @override
  Future<void> saveUserId(String id) async => _data['user_id'] = id;
  @override
  Future<String?> getUserId() async => _data['user_id'];
  @override
  Future<bool> get hasValidSession async => _data.containsKey('user_id');
  @override
  Future<void> clearAll() async => _data.clear();
}

void main() {
  late AuthRepositoryImpl repository;
  late FakeAuthRemoteDataSource fakeRemote;
  late FakeSecureStorage fakeStorage;
  late FakeNetworkInfo fakeNetwork;
  late AuthResponseModel testModel;

  setUp(() {
    fakeRemote = FakeAuthRemoteDataSource();
    fakeStorage = FakeSecureStorage();
    fakeNetwork = FakeNetworkInfo();
    repository = AuthRepositoryImpl(
      remoteDataSource: fakeRemote,
      secureStorage: fakeStorage,
      networkInfo: fakeNetwork,
    );

    testModel = AuthResponseModel(
      accessToken: 'jwt-token-123',
      refreshToken: 'refresh-token-123',
      user: UserModel(
        id: 'uid-456',
        email: 'waiter@amtips.app',
        fullName: 'Joshua Ndayishimiye',
        phone: '+25779000000',
        isOnboardingComplete: true,
        createdAt: DateTime(2026, 1, 1),
      ),
    );
    fakeRemote.responseModel = testModel;
  });

  group('AuthRepositoryImpl', () {
    test('login returns User and persists tokens on success', () async {
      final result = await repository.login(
        identifier: 'waiter@amtips.app',
        password: 'Password123!',
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Should succeed'),
        (user) {
          expect(user.id, 'uid-456');
          expect(user.email, 'waiter@amtips.app');
          expect(user.fullName, 'Joshua Ndayishimiye');
        },
      );
      expect(await fakeStorage.getAccessToken(), 'jwt-token-123');
      expect(await fakeStorage.getUserId(), 'uid-456');
    });

    test('login returns EmailNotVerifiedFailure when email is not verified',
        () async {
      fakeRemote.throwUnverifiedOnLogin = true;

      final result = await repository.login(
        identifier: 'waiter@amtips.app',
        password: 'Password123!',
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) {
          expect(failure, isA<EmailNotVerifiedFailure>());
          final unverified = failure as EmailNotVerifiedFailure;
          expect(unverified.email, 'waiter@amtips.app');
        },
        (_) => fail('Should fail with EmailNotVerifiedFailure'),
      );
    });

    test('register returns User on success and saves token', () async {
      final result = await repository.register(
        fullName: 'Joshua Ndayishimiye',
        email: 'waiter@amtips.app',
        phone: '+25779000000',
        password: 'Password123!',
      );

      expect(result.isRight(), isTrue);
      expect(await fakeStorage.getUserId(), 'uid-456');
    });

    test('sendEmailVerification returns Right(null) on success', () async {
      final result = await repository.sendEmailVerification();
      expect(result.isRight(), isTrue);
    });

    test('checkEmailVerification returns verification status', () async {
      fakeRemote.isVerified = true;
      final result = await repository.checkEmailVerification();
      expect(result, const Right(true));

      fakeRemote.isVerified = false;
      final result2 = await repository.checkEmailVerification();
      expect(result2, const Right(false));
    });

    test('logout clears secure storage', () async {
      await fakeStorage.saveAccessToken('token');
      await fakeStorage.saveUserId('uid');

      final result = await repository.logout();
      expect(result.isRight(), isTrue);
      expect(await fakeStorage.getAccessToken(), isNull);
      expect(await fakeStorage.getUserId(), isNull);
    });

    test('returns NetworkFailure when offline', () async {
      fakeNetwork.connected = false;

      final result = await repository.login(
        identifier: 'waiter@amtips.app',
        password: 'Password123!',
      );

      expect(result, const Left(NetworkFailure()));
    });
  });
}
