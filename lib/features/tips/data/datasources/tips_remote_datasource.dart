import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/tip_model.dart';
import '../models/wallet_model.dart';

abstract class TipsRemoteDataSource {
  Future<List<TipModel>> getTips({String? filter, int page = 1, int pageSize = 20});
  Future<TipModel> getTip(String id);
  Future<TipStatsModel> getTipStats();
  Future<WalletModel> getWallet();
  Future<List<WalletTransactionModel>> getTransactions({int page = 1, int pageSize = 20});
}

class TipsRemoteDataSourceImpl implements TipsRemoteDataSource {
  final SupabaseClient _db = Supabase.instance.client;

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
  Future<List<TipModel>> getTips({
    String? filter,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final waiterId = await _profileId;
      var query = _db.from('tips').select().eq('waiter_id', waiterId);
      if (filter != null) query = query.eq('status', filter);
      final list = await query
          .order('created_at', ascending: false)
          .range((page - 1) * pageSize, page * pageSize - 1);
      return list.map((e) => TipModel.fromJson(e)).toList();
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
  Future<TipModel> getTip(String id) async {
    try {
      final data = await _db.from('tips').select().eq('id', id).single();
      return TipModel.fromJson(data);
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
  Future<TipStatsModel> getTipStats() async {
    try {
      final waiterId = await _profileId;
      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day).toIso8601String();
      final weekStart = now.subtract(const Duration(days: 7)).toIso8601String();

      final all = await _db
          .from('tips')
          .select('amount, created_at')
          .eq('waiter_id', waiterId)
          .eq('status', 'completed');

      int todayTotal = 0, todayCount = 0;
      int weekTotal = 0, weekCount = 0;
      int allTimeTotal = 0, allTimeCount = all.length;

      for (final t in all) {
        final amount = (t['amount'] as num).toInt();
        final createdAt = t['created_at'] as String;
        allTimeTotal += amount;
        if (createdAt.compareTo(weekStart) >= 0) { weekTotal += amount; weekCount++; }
        if (createdAt.compareTo(todayStart) >= 0) { todayTotal += amount; todayCount++; }
      }

      return TipStatsModel(
        todayTotal: todayTotal, todayCount: todayCount,
        weekTotal: weekTotal, weekCount: weekCount,
        allTimeTotal: allTimeTotal, allTimeCount: allTimeCount,
        currency: 'BIF',
      );
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
  Future<WalletModel> getWallet() async {
    try {
      final waiterId = await _profileId;
      final data = await _db
          .from('wallets')
          .select()
          .eq('waiter_id', waiterId)
          .maybeSingle(); // returns null if no wallet row yet — safe

      // No wallet row yet (new user, no tips received) — return empty wallet
      if (data == null) {
        return WalletModel(
          waiterId: waiterId,
          availableBalance: 0,
          pendingBalance: 0,
          currency: 'BIF',
          lastUpdatedAt: null,
        );
      }

      return WalletModel.fromJson({
        ...data,
        'available_balance': data['balance'],
      });
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
  Future<List<WalletTransactionModel>> getTransactions({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final waiterId = await _profileId;
      final list = await _db
          .from('tips')
          .select('id, amount, currency, created_at, status')
          .eq('waiter_id', waiterId)
          .eq('status', 'completed')
          .order('created_at', ascending: false)
          .range((page - 1) * pageSize, page * pageSize - 1);

      return list.map((e) => WalletTransactionModel.fromJson({
        'id': e['id'],
        'type': 'tip',
        'amount': e['amount'],
        'currency': e['currency'] ?? 'BIF',
        'is_credit': true,
        'created_at': e['created_at'],
      })).toList();
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
}
