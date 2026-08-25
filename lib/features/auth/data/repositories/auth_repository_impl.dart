import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SecureStorage secureStorage;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorage,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login({
    required String identifier,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final result = await remoteDataSource.login(
        identifier: identifier,
        password: password,
      );
      await _persistTokens(result);
      return Right(result.user.toDomain());
    } on EmailNotVerifiedException catch (e) {
      return Left(EmailNotVerifiedFailure(
        message: e.message,
        email: e.email,
      ));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(
        message: e.message,
        fieldErrors: e.fieldErrors,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on TimeoutException catch (e) {
      return Left(TimeoutFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return const Left(ServerFailure(
        message: 'Could not connect to amTips. Please try again.',
      ));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final result = await remoteDataSource.register(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
      );

      await _persistTokens(result);
      return Right(result.user.toDomain());
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(
        message: e.message,
        fieldErrors: e.fieldErrors,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on TimeoutException catch (e) {
      return Left(TimeoutFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return const Left(ServerFailure(
        message: 'Could not connect to amTips. Please try again.',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      await remoteDataSource.sendEmailVerification();
      return const Right(null);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Left(ServerFailure(
        message: 'Failed to send verification email. Please try again.',
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> checkEmailVerification() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final isVerified = await remoteDataSource.checkEmailVerification();
      return Right(isVerified);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Left(ServerFailure(
        message: 'Failed to check verification status.',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
    } catch (_) {
      // Best-effort — always clear local tokens
    }
    await secureStorage.clearAll();
    return const Right(null);
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    final online = await networkInfo.isConnected;

    if (!online) {
      // Offline — build User from the local Firebase cached state.
      // Firebase stores the session on-device; currentUser is always
      // available without a network call.
      return _userFromLocalCache();
    }

    try {
      final result = await remoteDataSource.getCurrentUser();
      await _persistTokens(result);
      return Right(result.user.toDomain());
    } on EmailNotVerifiedException catch (e) {
      return Left(EmailNotVerifiedFailure(
        message: e.message,
        email: e.email,
      ));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on ServerException catch (e) {
      // Network error despite being "online" — fall back to local cache
      return _userFromLocalCache();
    } catch (e) {
      return _userFromLocalCache();
    }
  }

  /// Builds a [User] entity from the Firebase local cached state.
  /// This is safe to call offline — Firebase SDK stores the last
  /// authenticated user on the device permanently until logout.
  Future<Either<Failure, User>> _userFromLocalCache() async {
    try {
      final fbUser =
          fb_auth.FirebaseAuth.instance.currentUser;
      if (fbUser == null) return const Left(AuthenticationFailure());

      // Use SharedPreferences for onboarding flag — no network needed
      final prefs = await _getPrefs();
      final isOnboardingComplete =
          prefs.getBool(AppConstants.onboardingCompleteKey) ?? false;

      return Right(User(
        id: fbUser.uid,
        email: fbUser.email ?? '',
        phone: fbUser.phoneNumber,
        fullName: fbUser.displayName ?? '',
        avatarUrl: fbUser.photoURL,
        isOnboardingComplete: isOnboardingComplete,
        createdAt: fbUser.metadata.creationTime ?? DateTime.now(),
        updatedAt: fbUser.metadata.lastSignInTime,
      ));
    } catch (e) {
      return const Left(AuthenticationFailure(
        message: 'Session could not be restored.',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      await remoteDataSource.forgotPassword(email: email);
      return const Right(null);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Left(ServerFailure(
        message: 'Could not connect to amTips. Please try again.',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      await remoteDataSource.resetPassword(
        token: token,
        newPassword: newPassword,
      );
      return const Right(null);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Left(ServerFailure(
        message: 'Could not connect to amTips. Please try again.',
      ));
    }
  }

  @override
  Future<bool> get isAuthenticated async {
    return remoteDataSource.isSessionValid();
  }

  Future<void> _persistTokens(AuthResponseModel result) async {
    await secureStorage.saveAccessToken(result.accessToken);
    await secureStorage.saveRefreshToken(result.refreshToken);
    await secureStorage.saveUserId(result.user.id);
  }

  SharedPreferences? _prefs;
  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }
}
