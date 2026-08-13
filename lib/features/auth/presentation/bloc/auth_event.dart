part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class SessionRestored extends AuthEvent {
  const SessionRestored();
}

class LoginSubmitted extends AuthEvent {
  final String identifier;
  final String password;
  const LoginSubmitted({required this.identifier, required this.password});
  @override
  List<Object?> get props => [identifier, password];
}

class RegisterSubmitted extends AuthEvent {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  const RegisterSubmitted({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  });
  @override
  List<Object?> get props => [fullName, email, phone];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class ForgotPasswordRequested extends AuthEvent {
  final String email;
  const ForgotPasswordRequested({required this.email});
  @override
  List<Object?> get props => [email];
}
