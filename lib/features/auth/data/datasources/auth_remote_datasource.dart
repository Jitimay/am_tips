import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login({
    required String identifier,
    required String password,
  });

  Future<AuthResponseModel> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  });

  Future<void> logout();

  Future<AuthResponseModel> getCurrentUser();

  Future<void> forgotPassword({required String email});

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<AuthResponseModel> login({
    required String identifier,
    required String password,
  }) async {
    final response = await apiClient.post(
      ApiEndpoints.login,
      data: {'identifier': identifier, 'password': password},
    );
    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AuthResponseModel> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    final response = await apiClient.post(
      ApiEndpoints.register,
      data: {
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'password': password,
      },
    );
    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> logout() async {
    await apiClient.post(ApiEndpoints.logout);
  }

  @override
  Future<AuthResponseModel> getCurrentUser() async {
    final response = await apiClient.get(ApiEndpoints.profile);
    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await apiClient.post(ApiEndpoints.forgotPassword, data: {'email': email});
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    await apiClient.post(
      ApiEndpoints.resetPassword,
      data: {'token': token, 'new_password': newPassword},
    );
  }
}
