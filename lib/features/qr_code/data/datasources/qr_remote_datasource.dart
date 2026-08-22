import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/qr_code_model.dart';

abstract class QrRemoteDataSource {
  Future<QrCodeModel> getMyQrCode();
  Future<QrCodeModel> regenerateQrCode();
}

class QrRemoteDataSourceImpl implements QrRemoteDataSource {
  final SupabaseClient _db = Supabase.instance.client;

  String get _uid => fb_auth.FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<Map<String, dynamic>> _fetchProfile() async {
    if (_uid.isEmpty) {
      throw const AuthenticationException(message: 'User is not authenticated.');
    }
    return await _db
        .from('profiles')
        .select('id, qr_token, created_at')
        .eq('firebase_uid', _uid)
        .single();
  }

  @override
  Future<QrCodeModel> getMyQrCode() async {
    try {
      final profile = await _fetchProfile();
      final profileId = profile['id'] as String;
      var token = profile['qr_token'] as String? ?? '';

      // If token is empty, generate one now
      if (token.isEmpty) {
        token = const Uuid().v4();
        await _db
            .from('profiles')
            .update({'qr_token': token})
            .eq('firebase_uid', _uid);
      }

      return QrCodeModel(
        waiterId: profileId,
        token: token,
        url: '${AppConstants.tipBaseUrl}/$profileId',
        generatedAt: DateTime.parse(profile['created_at'] as String),
      );
    } on AuthenticationException {
      rethrow;
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message, statusCode: int.tryParse(e.code ?? ''));
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  @override
  Future<QrCodeModel> regenerateQrCode() async {
    try {
      final profile = await _fetchProfile();
      final profileId = profile['id'] as String;
      final newToken = const Uuid().v4();
      final now = DateTime.now().toUtc();

      await _db
          .from('profiles')
          .update({'qr_token': newToken})
          .eq('firebase_uid', _uid);

      return QrCodeModel(
        waiterId: profileId,
        token: newToken,
        url: '${AppConstants.tipBaseUrl}/$profileId',
        generatedAt: now,
      );
    } on AuthenticationException {
      rethrow;
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message, statusCode: int.tryParse(e.code ?? ''));
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }
}
