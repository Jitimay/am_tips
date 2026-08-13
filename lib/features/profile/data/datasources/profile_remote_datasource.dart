import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/waiter_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<WaiterProfileModel> getProfile();
  Future<WaiterProfileModel> updateProfile(Map<String, dynamic> data);
  Future<String> uploadAvatar(String filePath);
  Future<PublicWaiterProfileModel> getPublicProfile(String waiterId);
  Future<PaymentAccountModel> connectPaymentAccount(Map<String, dynamic> data);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient apiClient;
  ProfileRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<WaiterProfileModel> getProfile() async {
    final res = await apiClient.get(ApiEndpoints.profile);
    return WaiterProfileModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<WaiterProfileModel> updateProfile(Map<String, dynamic> data) async {
    final res = await apiClient.patch(ApiEndpoints.updateProfile, data: data);
    return WaiterProfileModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<String> uploadAvatar(String filePath) async {
    final formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(filePath, filename: 'avatar.jpg'),
    });
    final res = await apiClient.postMultipart(
      ApiEndpoints.uploadAvatar,
      formData: formData,
    );
    return (res.data as Map<String, dynamic>)['avatar_url'] as String;
  }

  @override
  Future<PublicWaiterProfileModel> getPublicProfile(String waiterId) async {
    final res = await apiClient.get(ApiEndpoints.publicProfile(waiterId));
    return PublicWaiterProfileModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<PaymentAccountModel> connectPaymentAccount(
      Map<String, dynamic> data) async {
    final res = await apiClient.post('/profile/payment-accounts', data: data);
    return PaymentAccountModel.fromJson(res.data as Map<String, dynamic>);
  }
}
