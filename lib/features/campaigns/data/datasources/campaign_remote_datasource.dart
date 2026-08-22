import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/campaign_model.dart';

abstract class CampaignRemoteDataSource {
  Future<List<CampaignModel>> getCampaigns({bool? activeOnly});
  Future<CampaignModel> getCampaign(String id);
  Future<CampaignModel> getPublicCampaign(String id);
  Future<CampaignModel> createCampaign(CampaignModel model);
  Future<CampaignModel> updateCampaign(CampaignModel model);
  Future<CampaignModel> toggleCampaignStatus(String id, bool isActive);
  Future<void> deleteCampaign(String id);
}

class CampaignRemoteDataSourceImpl implements CampaignRemoteDataSource {
  final SupabaseClient _db;
  static const String _localCampaignsPrefKey = 'cached_campaigns_list';

  CampaignRemoteDataSourceImpl({SupabaseClient? db})
      : _db = db ?? Supabase.instance.client;

  String get _firebaseUid =>
      fb_auth.FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<String?> _getWaiterId() async {
    final uid = _firebaseUid;
    if (uid.isEmpty) return null;
    try {
      final res = await _db
          .from('profiles')
          .select('id')
          .eq('firebase_uid', uid)
          .maybeSingle();
      if (res != null) {
        return res['id'] as String?;
      }
    } catch (_) {}
    return uid;
  }

  @override
  Future<List<CampaignModel>> getCampaigns({bool? activeOnly}) async {
    final waiterId = await _getWaiterId();
    if (waiterId == null || waiterId.isEmpty) {
      return _getLocalCampaigns(activeOnly: activeOnly);
    }

    try {
      var query = _db.from('campaigns').select().eq('waiter_id', waiterId);
      if (activeOnly == true) {
        query = query.eq('is_active', true);
      }
      final data = await query.order('created_at', ascending: false);
      final list = (data as List)
          .map((e) => CampaignModel.fromJson(e as Map<String, dynamic>))
          .toList();

      await _cacheLocalCampaigns(list);
      return list;
    } catch (e) {
      debugPrint('[CampaignRemoteDataSource] Supabase fetch error, fallback to cache: $e');
      final local = await _getLocalCampaigns(activeOnly: activeOnly);
      return local;
    }
  }

  @override
  Future<CampaignModel> getCampaign(String id) async {
    try {
      final data = await _db
          .from('campaigns')
          .select()
          .eq('id', id)
          .single();
      return CampaignModel.fromJson(data);
    } catch (e) {
      debugPrint('[CampaignRemoteDataSource] Supabase get error, searching cache: $e');
      final local = await _getLocalCampaigns();
      final match = local.where((c) => c.id == id).firstOrNull;
      if (match != null) return match;
      throw const ServerException(message: 'Campaign not found.');
    }
  }

  @override
  Future<CampaignModel> getPublicCampaign(String id) async {
    return getCampaign(id);
  }

  @override
  Future<CampaignModel> createCampaign(CampaignModel model) async {
    final waiterId = await _getWaiterId() ?? _firebaseUid;
    final id = model.id.isNotEmpty ? model.id : const Uuid().v4();
    final now = DateTime.now();

    final toSave = CampaignModel(
      id: id,
      waiterId: waiterId.isNotEmpty ? waiterId : model.waiterId,
      title: model.title,
      category: model.category,
      description: model.description,
      targetAmount: model.targetAmount,
      currentAmount: model.currentAmount,
      tipsCount: model.tipsCount,
      currency: model.currency,
      emoji: model.emoji,
      isActive: model.isActive,
      startDate: model.startDate,
      endDate: model.endDate,
      createdAt: now,
      updatedAt: now,
    );

    try {
      final data = await _db
          .from('campaigns')
          .insert(toSave.toJson())
          .select()
          .single();
      final saved = CampaignModel.fromJson(data);
      await _upsertLocalCampaign(saved);
      return saved;
    } catch (e) {
      debugPrint('[CampaignRemoteDataSource] Supabase insert failed, saving to local: $e');
      await _upsertLocalCampaign(toSave);
      return toSave;
    }
  }

  @override
  Future<CampaignModel> updateCampaign(CampaignModel model) async {
    final updated = CampaignModel(
      id: model.id,
      waiterId: model.waiterId,
      title: model.title,
      category: model.category,
      description: model.description,
      targetAmount: model.targetAmount,
      currentAmount: model.currentAmount,
      tipsCount: model.tipsCount,
      currency: model.currency,
      emoji: model.emoji,
      isActive: model.isActive,
      startDate: model.startDate,
      endDate: model.endDate,
      createdAt: model.createdAt,
      updatedAt: DateTime.now(),
    );

    try {
      final data = await _db
          .from('campaigns')
          .update(updated.toJson())
          .eq('id', model.id)
          .select()
          .single();
      final saved = CampaignModel.fromJson(data);
      await _upsertLocalCampaign(saved);
      return saved;
    } catch (e) {
      debugPrint('[CampaignRemoteDataSource] Supabase update failed, updating local: $e');
      await _upsertLocalCampaign(updated);
      return updated;
    }
  }

  @override
  Future<CampaignModel> toggleCampaignStatus(String id, bool isActive) async {
    try {
      final data = await _db
          .from('campaigns')
          .update({
            'is_active': isActive,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', id)
          .select()
          .single();
      final saved = CampaignModel.fromJson(data);
      await _upsertLocalCampaign(saved);
      return saved;
    } catch (e) {
      debugPrint('[CampaignRemoteDataSource] Supabase toggle status failed: $e');
      final local = await _getLocalCampaigns();
      final existing = local.where((c) => c.id == id).firstOrNull;
      if (existing != null) {
        final updated = CampaignModel(
          id: existing.id,
          waiterId: existing.waiterId,
          title: existing.title,
          category: existing.category,
          description: existing.description,
          targetAmount: existing.targetAmount,
          currentAmount: existing.currentAmount,
          tipsCount: existing.tipsCount,
          currency: existing.currency,
          emoji: existing.emoji,
          isActive: isActive,
          startDate: existing.startDate,
          endDate: existing.endDate,
          createdAt: existing.createdAt,
          updatedAt: DateTime.now(),
        );
        await _upsertLocalCampaign(updated);
        return updated;
      }
      throw const ServerException(message: 'Campaign not found.');
    }
  }

  @override
  Future<void> deleteCampaign(String id) async {
    try {
      await _db.from('campaigns').delete().eq('id', id);
    } catch (e) {
      debugPrint('[CampaignRemoteDataSource] Supabase delete error: $e');
    }
    await _removeLocalCampaign(id);
  }

  // ── Local Storage Helpers ──────────────────────────────────────────────────

  Future<List<CampaignModel>> _getLocalCampaigns({bool? activeOnly}) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_localCampaignsPrefKey);
    if (jsonStr == null || jsonStr.isEmpty) return [];

    try {
      final List decoded = jsonDecode(jsonStr) as List;
      final list = decoded
          .map((e) => CampaignModel.fromJson(e as Map<String, dynamic>))
          .toList();
      if (activeOnly == true) {
        return list.where((c) => c.isActive).toList();
      }
      return list;
    } catch (_) {
      return [];
    }
  }

  Future<void> _cacheLocalCampaigns(List<CampaignModel> list) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(list.map((c) => c.toJson()).toList());
    await prefs.setString(_localCampaignsPrefKey, encoded);
  }

  Future<void> _upsertLocalCampaign(CampaignModel model) async {
    final current = await _getLocalCampaigns();
    final index = current.indexWhere((c) => c.id == model.id);
    if (index >= 0) {
      current[index] = model;
    } else {
      current.insert(0, model);
    }
    await _cacheLocalCampaigns(current);
  }

  Future<void> _removeLocalCampaign(String id) async {
    final current = await _getLocalCampaigns();
    current.removeWhere((c) => c.id == id);
    await _cacheLocalCampaigns(current);
  }
}
