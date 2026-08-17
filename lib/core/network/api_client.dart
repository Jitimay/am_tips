import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/app_constants.dart';
import '../errors/exceptions.dart';
import '../storage/secure_storage.dart';
import '../constants/api_endpoints.dart';

/// Central Dio API client with auth headers, token refresh, and error mapping.
class ApiClient {
  late final Dio _dio;
  final SecureStorage secureStorage;
  final Logger _logger = Logger();

  ApiClient({required this.secureStorage}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(milliseconds: AppConstants.connectTimeout),
        receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeout),
        sendTimeout: const Duration(milliseconds: AppConstants.sendTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(_AuthInterceptor(_logger));

    assert(() {
      // Only log in debug mode
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (o) => _logger.d(o.toString()),
        ),
      );
      return true;
    }());
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<Response<T>> postMultipart<T>(
    String path, {
    required FormData formData,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(path, data: formData, options: options);
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Exception _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();
      case DioExceptionType.connectionError:
        return const NetworkException();
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;
        final message = _extractErrorMessage(data) ?? 'An error occurred.';

        if (statusCode == 401) return AuthenticationException(message: message);
        if (statusCode == 403) return UnauthorizedException(message: message);
        if (statusCode == 422) {
          return ValidationException(
            message: message,
            fieldErrors: _extractFieldErrors(data),
          );
        }
        return ServerException(message: message, statusCode: statusCode, data: data);
      default:
        return ServerException(message: e.message ?? 'Unknown error', statusCode: null);
    }
  }

  String? _extractErrorMessage(dynamic data) {
    if (data is Map) {
      return data['message']?.toString() ??
          data['error']?.toString() ??
          data['detail']?.toString();
    }
    return null;
  }

  Map<String, List<String>>? _extractFieldErrors(dynamic data) {
    if (data is Map && data['errors'] is Map) {
      return (data['errors'] as Map).map(
        (key, value) => MapEntry(
          key.toString(),
          (value is List)
              ? value.map((v) => v.toString()).toList()
              : [value.toString()],
        ),
      );
    }
    return null;
  }
}

/// Interceptor that injects the Supabase session token.
class _AuthInterceptor extends Interceptor {
  final Logger _logger;

  _AuthInterceptor(this._logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = Supabase.instance.client.auth.currentSession?.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
