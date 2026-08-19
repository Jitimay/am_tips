/// Application-level exceptions thrown from the data layer.
/// These are mapped to [Failure] objects in repositories.
library;

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? data;

  const ServerException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'ServerException($statusCode): $message';
}

class NetworkException implements Exception {
  final String message;
  const NetworkException({this.message = 'No internet connection.'});

  @override
  String toString() => 'NetworkException: $message';
}

class TimeoutException implements Exception {
  final String message;
  const TimeoutException({this.message = 'Connection timed out.'});

  @override
  String toString() => 'TimeoutException: $message';
}

class AuthenticationException implements Exception {
  final String message;
  const AuthenticationException({this.message = 'Authentication failed.'});

  @override
  String toString() => 'AuthenticationException: $message';
}

class EmailNotVerifiedException implements Exception {
  final String message;
  final String email;

  const EmailNotVerifiedException({
    this.message = 'Please verify your email before continuing.',
    required this.email,
  });

  @override
  String toString() => 'EmailNotVerifiedException: $message ($email)';
}


class UnauthorizedException implements Exception {
  final String message;
  const UnauthorizedException({this.message = 'Unauthorized.'});

  @override
  String toString() => 'UnauthorizedException: $message';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, List<String>>? fieldErrors;

  const ValidationException({required this.message, this.fieldErrors});

  @override
  String toString() => 'ValidationException: $message';
}

class CacheException implements Exception {
  final String message;
  const CacheException({this.message = 'Cache error.'});

  @override
  String toString() => 'CacheException: $message';
}

class PaymentException implements Exception {
  final String message;
  final int? statusCode;

  const PaymentException({required this.message, this.statusCode});

  @override
  String toString() => 'PaymentException: $message';
}
