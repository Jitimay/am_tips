import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/foundation.dart';
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
      final uid = _firebaseUid;
      if (uid.isEmpty) {
        throw const AuthenticationException(message: 'User is not authenticated.');
      }

      final amount = (data['amount'] as num).toInt();
      final currency = data['currency'] as String? ?? 'BIF';
      final paymentAccountId = data['payment_account_id'] as String;

      // Atomic RPC: balance check + deduct + insert in one DB transaction.
      // Throws PostgrestException with ERRCODE P0003 if insufficient balance.
      final rows = await _db.rpc('request_withdrawal', params: {
        'p_firebase_uid': uid,
        'p_amount': amount,
        'p_currency': currency,
        'p_payment_account_id': paymentAccountId,
      });

      final row = (rows as List).first as Map<String, dynamic>;
      final withdrawal = WithdrawalModel.fromJson(row);

      // Trigger AfriPay disbursement via Edge Function (fire-and-forget).
      // The edge function updates the withdrawal status asynchronously.
      _triggerDisbursement(withdrawal.id);

      return withdrawal;
    } on PostgrestException catch (e) {
      if (e.message.contains('Insufficient balance')) {
        throw const ValidationException(message: 'Insufficient balance.');
      }
      throw ServerException(
        message: e.message,
        statusCode: int.tryParse(e.code ?? ''),
      );
    } catch (e) {
      if (e is ServerException || e is ValidationException || e is AuthenticationException) rethrow;
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  void _triggerDisbursement(String withdrawalId) {
    _db.functions
        .invoke('afripay-disbursement', body: {'withdrawal_id': withdrawalId})
        .then((_) => debugPrint('[Withdrawal] Disbursement triggered: $withdrawalId'))
        .catchError((e) => debugPrint('[Withdrawal] Disbursement trigger failed: $e'));
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
