import 'package:am_tips/core/errors/failures.dart';
import 'package:am_tips/features/auth/domain/entities/user.dart';
import 'package:am_tips/features/auth/domain/repositories/auth_repository.dart';
import 'package:am_tips/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAuthRepository implements AuthRepository {
  Either<Failure, User>? loginResult;
  Either<Failure, User>? registerResult;
  Either<Failure, User>? currentUserResult;
  Either<Failure, void>? logoutResult;
  Either<Failure, void>? forgotPasswordResult;
  Either<Failure, void>? resetPasswordResult;
  Either<Failure, void>? sendEmailVerificationResult;
  Either<Failure, bool>? checkEmailVerificationResult;
  bool isAuth = false;

  @override
  Future<Either<Failure, User>> login({
    required String identifier,
    required String password,
  }) async {
    return loginResult ?? const Left(ServerFailure(message: 'Login failed'));
  }

  @override
  Future<Either<Failure, User>> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    return registerResult ??
        const Left(ServerFailure(message: 'Registration failed'));
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return logoutResult ?? const Right(null);
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    return currentUserResult ??
        const Left(AuthenticationFailure(message: 'No session'));
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    return sendEmailVerificationResult ?? const Right(null);
  }

  @override
  Future<Either<Failure, bool>> checkEmailVerification() async {
    return checkEmailVerificationResult ?? const Right(true);
  }

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    return forgotPasswordResult ?? const Right(null);
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    return resetPasswordResult ?? const Right(null);
  }

  @override
  Future<bool> get isAuthenticated async => isAuth;
}

void main() {
  late FakeAuthRepository fakeRepo;
  late User testUser;

  setUp(() {
    fakeRepo = FakeAuthRepository();
    testUser = User(
      id: 'uid-123',
      email: 'waiter@amtips.app',
      fullName: 'Joshua Ndayishimiye',
      phone: '+25779000000',
      isOnboardingComplete: true,
      createdAt: DateTime.now(),
    );
  });

  group('AuthBloc', () {
    test('initial state is AuthInitial', () {
      final bloc = AuthBloc(authRepository: fakeRepo);
      expect(bloc.state, const AuthInitial());
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, RegisterPendingConfirmation] on successful registration',
      build: () {
        fakeRepo.registerResult = Right(testUser);
        return AuthBloc(authRepository: fakeRepo);
      },
      act: (bloc) => bloc.add(const RegisterSubmitted(
        fullName: 'Joshua Ndayishimiye',
        email: 'waiter@amtips.app',
        phone: '+25779000000',
        password: 'Password123!',
      )),
      expect: () => [
        const AuthLoading(),
        const RegisterPendingConfirmation(
          email: 'waiter@amtips.app',
          message: 'Verification link sent to waiter@amtips.app.',
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Authenticated] on successful login with verified email',
      build: () {
        fakeRepo.loginResult = Right(testUser);
        return AuthBloc(authRepository: fakeRepo);
      },
      act: (bloc) => bloc.add(const LoginSubmitted(
        identifier: 'waiter@amtips.app',
        password: 'Password123!',
      )),
      expect: () => [
        const AuthLoading(),
        Authenticated(user: testUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, RegisterPendingConfirmation] on login when email is not verified',
      build: () {
        fakeRepo.loginResult = const Left(EmailNotVerifiedFailure(
          email: 'waiter@amtips.app',
          message: 'Please verify your email before accessing your account.',
        ));
        return AuthBloc(authRepository: fakeRepo);
      },
      act: (bloc) => bloc.add(const LoginSubmitted(
        identifier: 'waiter@amtips.app',
        password: 'Password123!',
      )),
      expect: () => [
        const AuthLoading(),
        const RegisterPendingConfirmation(
          email: 'waiter@amtips.app',
          message: 'Please verify your email before accessing your account.',
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] on login failure',
      build: () {
        fakeRepo.loginResult = const Left(AuthenticationFailure(
          message: 'Invalid email or password.',
        ));
        return AuthBloc(authRepository: fakeRepo);
      },
      act: (bloc) => bloc.add(const LoginSubmitted(
        identifier: 'wrong@amtips.app',
        password: 'WrongPassword!',
      )),
      expect: () => [
        const AuthLoading(),
        const AuthFailure(message: 'Invalid email or password.'),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'resends verification email on SendEmailVerificationRequested',
      build: () {
        fakeRepo.sendEmailVerificationResult = const Right(null);
        return AuthBloc(authRepository: fakeRepo);
      },
      seed: () => const RegisterPendingConfirmation(email: 'waiter@amtips.app'),
      act: (bloc) => bloc.add(const SendEmailVerificationRequested()),
      expect: () => [
        const RegisterPendingConfirmation(
          email: 'waiter@amtips.app',
          message: 'A new verification link has been sent to your email.',
          isResent: true,
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'checks email verification status and emits Authenticated when verified',
      build: () {
        fakeRepo.checkEmailVerificationResult = const Right(true);
        fakeRepo.currentUserResult = Right(testUser);
        return AuthBloc(authRepository: fakeRepo);
      },
      seed: () => const RegisterPendingConfirmation(email: 'waiter@amtips.app'),
      act: (bloc) => bloc.add(const CheckEmailVerificationStatus(
        email: 'waiter@amtips.app',
      )),
      expect: () => [
        const RegisterPendingConfirmation(
          email: 'waiter@amtips.app',
          isChecking: true,
        ),
        Authenticated(user: testUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'checks email verification status and notifies when still unverified',
      build: () {
        fakeRepo.checkEmailVerificationResult = const Right(false);
        return AuthBloc(authRepository: fakeRepo);
      },
      seed: () => const RegisterPendingConfirmation(email: 'waiter@amtips.app'),
      act: (bloc) => bloc.add(const CheckEmailVerificationStatus(
        email: 'waiter@amtips.app',
      )),
      expect: () => [
        const RegisterPendingConfirmation(
          email: 'waiter@amtips.app',
          isChecking: true,
        ),
        const RegisterPendingConfirmation(
          email: 'waiter@amtips.app',
          message:
              'Your email has not been verified yet. Please check your inbox and click the verification link.',
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Unauthenticated] on LogoutRequested',
      build: () {
        fakeRepo.logoutResult = const Right(null);
        return AuthBloc(authRepository: fakeRepo);
      },
      act: (bloc) => bloc.add(const LogoutRequested()),
      expect: () => [
        const AuthLoading(),
        const Unauthenticated(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, ForgotPasswordSent] on ForgotPasswordRequested',
      build: () {
        fakeRepo.forgotPasswordResult = const Right(null);
        return AuthBloc(authRepository: fakeRepo);
      },
      act: (bloc) => bloc.add(const ForgotPasswordRequested(
        email: 'waiter@amtips.app',
      )),
      expect: () => [
        const AuthLoading(),
        const ForgotPasswordSent(),
      ],
    );
  });
}
