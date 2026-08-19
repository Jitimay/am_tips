part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class Authenticated extends AuthState {
  final User user;
  const Authenticated({required this.user});
  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class ForgotPasswordSent extends AuthState {
  const ForgotPasswordSent();
}

class RegisterPendingConfirmation extends AuthState {
  final String email;
  final String? message;
  final bool isResent;
  final bool isChecking;

  const RegisterPendingConfirmation({
    required this.email,
    this.message,
    this.isResent = false,
    this.isChecking = false,
  });

  RegisterPendingConfirmation copyWith({
    String? email,
    String? message,
    bool? isResent,
    bool? isChecking,
  }) {
    return RegisterPendingConfirmation(
      email: email ?? this.email,
      message: message ?? this.message,
      isResent: isResent ?? this.isResent,
      isChecking: isChecking ?? this.isChecking,
    );
  }

  @override
  List<Object?> get props => [email, message, isResent, isChecking];
}
