import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      (failure) => emit(const Unauthenticated()),
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
      (failure) => emit(AuthFailure(message: failure.message)),
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
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(Authenticated(user: user)),
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
    final result =
        await authRepository.forgotPassword(email: event.email);
    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (_) => emit(const ForgotPasswordSent()),
    );
  }
}
