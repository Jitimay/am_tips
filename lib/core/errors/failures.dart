import 'package:equatable/equatable.dart';

/// Base class for all application failures.
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection. Please check your network.', super.statusCode});
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message = 'Request timed out. Please try again.', super.statusCode});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({super.message = 'Authentication failed. Please log in again.'});
}

class EmailNotVerifiedFailure extends Failure {
  final String email;

  const EmailNotVerifiedFailure({
    super.message = 'Please verify your email before continuing.',
    required this.email,
  });

  @override
  List<Object?> get props => [message, email];
}


class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message = 'You are not authorized to perform this action.'});
}

class ValidationFailure extends Failure {
  final Map<String, List<String>>? fieldErrors;

  const ValidationFailure({
    required super.message,
    this.fieldErrors,
  });

  @override
  List<Object?> get props => [message, fieldErrors];
}

class PaymentFailure extends Failure {
  const PaymentFailure({required super.message, super.statusCode});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'The requested resource was not found.'});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Failed to load cached data.'});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'An unexpected error occurred. Please try again.'});
}
