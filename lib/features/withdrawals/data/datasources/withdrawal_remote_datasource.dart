import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/withdrawal_model.dart';

abstract class WithdrawalRemoteDataSource {
  Future<WithdrawalModel> requestWithdrawal(Map<String, dynamic> data);
  Future<List<WithdrawalModel>> getWithdrawals({int page = 1, int pageSize = 20});
  Future<WithdrawalModel> getWithdrawal(String id);
}

class WithdrawalRemoteDataSourceImpl implements WithdrawalRemoteDataSource {
  final SupabaseClient _db;

  WithdrawalRemoteDataSourceImpl({SupabaseClient? client})
      : _db = client ?? Supabase.instance.client;

  String get _firebaseUid =>
      fb_auth.FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<String> get _profileId async {
    final uid = _firebaseUid;
    if (uid.isEmpty) {
      throw const AuthenticationException(message: 'User is not authenticated.');
    }
    try {
      final data = await _db
          .from('profiles')
          .select('id')
          .eq('firebase_uid', uid)
          .single();
      return data['id'] as String;
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
  Future<WithdrawalModel> requestWithdrawal(Map<String, dynamic> data) async {
    try {
      final waiterId = await _profileId;
      final amount = (data['amount'] as num).toInt();
      final currency = data['currency'] as String? ?? 'BIF';
      final paymentAccountId = data['payment_account_id'] as String;

      // 1. Verify wallet balance
      final wallet = await _db
          .from('wallets')
          .select('balance')
          .eq('waiter_id', waiterId)
          .maybeSingle();

      final currentBalance = (wallet?['balance'] as num?)?.toInt() ?? 0;
      if (currentBalance < amount) {
        throw const ValidationException(message: 'Insufficient balance.');
      }

      // 2. Deduct from wallet balance
      await _db
          .from('wallets')
          .update({
            'balance': currentBalance - amount,
            'updated_at': DateTime.now().toUtc().toIso8601String(),
          })
          .eq('waiter_id', waiterId);

      // 3. Insert withdrawal row
      final row = await _db
          .from('withdrawals')
          .insert({
            'waiter_id': waiterId,
            'amount': amount,
            'currency': currency,
            'status': 'requested',
            'payment_account_id': paymentAccountId,
          })
          .select()
          .single();

      return WithdrawalModel.fromJson(row);
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: int.tryParse(e.code ?? ''),
      );
    } catch (e) {
      if (e is ServerException || e is ValidationException || e is AuthenticationException) rethrow;
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  @override
  Future<List<WithdrawalModel>> getWithdrawals({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final waiterId = await _profileId;
      final list = await _db
          .from('withdrawals')
          .select()
          .eq('waiter_id', waiterId)
          .order('created_at', ascending: false)
          .range((page - 1) * pageSize, page * pageSize - 1);

      return list.map((e) => WithdrawalModel.fromJson(e)).toList();
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
  Future<WithdrawalModel> getWithdrawal(String id) async {
    try {
      final data = await _db
          .from('withdrawals')
          .select()
          .eq('id', id)
          .single();
      return WithdrawalModel.fromJson(data);
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
}
