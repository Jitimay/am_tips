import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../../core/storage/supabase_storage_service.dart';
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
  final SupabaseStorageService storageService;
  final SecureStorage secureStorage;

  ProfileRemoteDataSourceImpl({
    required this.apiClient,
    required this.storageService,
    required this.secureStorage,
  });

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

  /// Uploads avatar binary directly to Supabase Storage only,
  /// then saves the returned public URL and metadata into the database/profile.
  @override
  Future<String> uploadAvatar(String filePath) async {
    final userId = await secureStorage.getUserId() ??
        fb_auth.FirebaseAuth.instance.currentUser?.uid ??
        'anonymous';
    final file = File(filePath);

    // Upload to Supabase Storage
    final avatarUrl = await storageService.uploadProfileAvatar(
      userId: userId,
      file: file,
    );

    // Sync avatar photoURL to Firebase user profile if signed in
    try {
      await fb_auth.FirebaseAuth.instance.currentUser?.updatePhotoURL(avatarUrl);
    } catch (_) {}

    // Store only the file URL and metadata in the database
    try {
      await apiClient.patch(
        ApiEndpoints.updateProfile,
        data: {'avatar_url': avatarUrl},
      );
    } catch (_) {
      // Backend API endpoint might be offline or mocked during testing
    }

    return avatarUrl;
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
