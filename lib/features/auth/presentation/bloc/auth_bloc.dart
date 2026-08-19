import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthInitial()) {
    on<SessionRestored>(_onSessionRestored);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<SendEmailVerificationRequested>(_onSendEmailVerificationRequested);
    on<CheckEmailVerificationStatus>(_onCheckEmailVerificationStatus);
    on<LogoutRequested>(_onLogoutRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
  }

  Future<void> _onSessionRestored(
    SessionRestored event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final isAuth = await authRepository.isAuthenticated;
    if (!isAuth) {
      emit(const Unauthenticated());
      return;
    }
    final result = await authRepository.getCurrentUser();
    result.fold(
      (failure) {
        if (failure is EmailNotVerifiedFailure) {
          emit(RegisterPendingConfirmation(email: failure.email));
        } else {
          emit(const Unauthenticated());
        }
      },
      (user) => emit(Authenticated(user: user)),
    );
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await authRepository.login(
      identifier: event.identifier,
      password: event.password,
    );
    result.fold(
      (failure) {
        if (failure is EmailNotVerifiedFailure) {
          emit(RegisterPendingConfirmation(
            email: failure.email,
            message: failure.message,
          ));
        } else {
          emit(AuthFailure(message: failure.message));
        }
      },
      (user) => emit(Authenticated(user: user)),
    );
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await authRepository.register(
      fullName: event.fullName,
      email: event.email,
      phone: event.phone,
      password: event.password,
    );
    result.fold(
      (failure) {
        if (failure is EmailNotVerifiedFailure) {
          emit(RegisterPendingConfirmation(email: failure.email));
        } else {
          emit(AuthFailure(message: failure.message));
        }
      },
      (_) {
        // After registration, user is created and verification email is sent.
        // Direct them to verify their email before allowing full app access.
        emit(RegisterPendingConfirmation(
          email: event.email,
          message: 'Verification link sent to ${event.email}.',
        ));
      },
    );
  }

  Future<void> _onSendEmailVerificationRequested(
    SendEmailVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    final currentEmail = state is RegisterPendingConfirmation
        ? (state as RegisterPendingConfirmation).email
        : '';

    final result = await authRepository.sendEmailVerification();
    result.fold(
      (failure) => emit(RegisterPendingConfirmation(
        email: currentEmail,
        message: failure.message,
      )),
      (_) => emit(RegisterPendingConfirmation(
        email: currentEmail,
        message: 'A new verification link has been sent to your email.',
        isResent: true,
      )),
    );
  }

  Future<void> _onCheckEmailVerificationStatus(
    CheckEmailVerificationStatus event,
    Emitter<AuthState> emit,
  ) async {
    final currentEmail = event.email ??
        (state is RegisterPendingConfirmation
            ? (state as RegisterPendingConfirmation).email
            : '');

    emit(RegisterPendingConfirmation(
      email: currentEmail,
      isChecking: true,
    ));

    final isVerifiedResult = await authRepository.checkEmailVerification();

    await isVerifiedResult.fold(
      (failure) async {
        emit(RegisterPendingConfirmation(
          email: currentEmail,
          message: failure.message,
        ));
      },
      (isVerified) async {
        if (isVerified) {
          final userResult = await authRepository.getCurrentUser();
          userResult.fold(
            (failure) => emit(RegisterPendingConfirmation(
              email: currentEmail,
              message: 'Email verified! Please log in.',
            )),
            (user) => emit(Authenticated(user: user)),
          );
        } else {
          emit(RegisterPendingConfirmation(
            email: currentEmail,
            message: 'Your email has not been verified yet. Please check your inbox and click the verification link.',
          ));
        }
      },
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await authRepository.logout();
    emit(const Unauthenticated());
  }

  Future<void> _onForgotPasswordRequested(
    ForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await authRepository.forgotPassword(email: event.email);
    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (_) => emit(const ForgotPasswordSent()),
    );
  }
}
