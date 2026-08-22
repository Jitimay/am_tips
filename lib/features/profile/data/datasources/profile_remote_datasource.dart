import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
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
  final SupabaseStorageService storageService;
  final SupabaseClient _db = Supabase.instance.client;

  ProfileRemoteDataSourceImpl({required this.storageService});

  String get _firebaseUid =>
      fb_auth.FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  Future<WaiterProfileModel> getProfile() async {
    final uid = _firebaseUid;
    if (uid.isEmpty) {
      throw const AuthenticationException(message: 'User is not authenticated.');
    }
    try {
      final data = await _db
          .from('profiles')
          .select('*, payment_accounts(*)')
          .eq('firebase_uid', uid)
          .single();
      return WaiterProfileModel.fromJson(_mapProfile(data));
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: int.tryParse(e.code ?? ''),
      );
    } catch (e) {
      if (e is ServerException || e is AuthenticationException) rethrow;
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  @override
  Future<WaiterProfileModel> updateProfile(Map<String, dynamic> data) async {
    final uid = _firebaseUid;
    if (uid.isEmpty) {
      throw const AuthenticationException(message: 'User is not authenticated.');
    }
    try {
      final updated = await _db
          .from('profiles')
          .upsert({
            ...data,
            'firebase_uid': uid,
            'updated_at': DateTime.now().toIso8601String(),
          }, onConflict: 'firebase_uid')
          .select('*, payment_accounts(*)')
          .single();
      return WaiterProfileModel.fromJson(_mapProfile(updated));
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: int.tryParse(e.code ?? ''),
      );
    } catch (e) {
      if (e is ServerException || e is AuthenticationException) rethrow;
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  @override
  Future<String> uploadAvatar(String filePath) async {
    final uid = _firebaseUid;
    if (uid.isEmpty) {
      throw const AuthenticationException(message: 'User is not authenticated.');
    }
    try {
      final avatarUrl = await storageService.uploadProfileAvatar(
        userId: uid,
        file: File(filePath),
      );
      try {
        await fb_auth.FirebaseAuth.instance.currentUser?.updatePhotoURL(avatarUrl);
      } catch (_) {}
      await updateProfile({'avatar_url': avatarUrl});
      return avatarUrl;
    } catch (e) {
      if (e is ServerException || e is AuthenticationException) rethrow;
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  @override
  Future<PublicWaiterProfileModel> getPublicProfile(String waiterId) async {
    try {
      final data = await _db
          .from('profiles')
          .select(
              'id, full_name, avatar_url, restaurant_name, city, country, personal_message, average_rating, total_ratings, professions')
          .eq('id', waiterId)
          .single();
      return PublicWaiterProfileModel.fromJson(data);
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: int.tryParse(e.code ?? ''),
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  @override
  Future<PaymentAccountModel> connectPaymentAccount(Map<String, dynamic> data) async {
    final uid = _firebaseUid;
    if (uid.isEmpty) {
      throw const AuthenticationException(message: 'User is not authenticated.');
    }
    try {
      final profile = await _db
          .from('profiles')
          .select('id')
          .eq('firebase_uid', uid)
          .single();
      final result = await _db
          .from('payment_accounts')
          .upsert({...data, 'waiter_id': profile['id']})
          .select()
          .single();
      return PaymentAccountModel.fromJson(result);
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: int.tryParse(e.code ?? ''),
      );
    } catch (e) {
      if (e is ServerException || e is AuthenticationException) rethrow;
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  /// Supabase returns payment_accounts as a list; map it to match the model.
  Map<String, dynamic> _mapProfile(Map<String, dynamic> data) {
    final accounts = data['payment_accounts'] as List?;
    return {
      ...data,
      'user_id': data['firebase_uid'],
      'connected_payment_account':
          (accounts != null && accounts.isNotEmpty) ? accounts.first : null,
    };
  }
}
