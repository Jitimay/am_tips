import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/network/api_client.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications(
      {int page = 1, int pageSize = 20});
  Future<void> markAsRead(String id);
  Future<void> markAllAsRead();
  Future<int> getUnreadCount();
  /// Registers (upserts) the FCM token for the current user in Supabase.
  Future<void> registerPushToken(String token);
  /// Removes the FCM token on logout so stale tokens don't accumulate.
  Future<void> deletePushToken(String token);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiClient apiClient;
  final SupabaseClient _db;

  NotificationRemoteDataSourceImpl({
    required this.apiClient,
    SupabaseClient? supabaseClient,
  }) : _db = supabaseClient ?? Supabase.instance.client;

  String get _firebaseUid =>
      fb_auth.FirebaseAuth.instance.currentUser?.uid ?? '';

  // ── Notifications (from the Supabase notifications table directly) ────────

  @override
  Future<List<NotificationModel>> getNotifications(
      {int page = 1, int pageSize = 20}) async {
    final uid = _firebaseUid;
    if (uid.isEmpty) return [];

    try {
      // Resolve profile id
      final profile = await _db
          .from('profiles')
          .select('id')
          .eq('firebase_uid', uid)
          .single();
      final userId = profile['id'] as String;

      final rows = await _db
          .from('notifications')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .range((page - 1) * pageSize, page * pageSize - 1);

      return rows
          .map((e) => NotificationModel.fromJson(e))
          .toList();
    } on PostgrestException catch (e) {
      debugPrint('[NotificationDS] getNotifications error: ${e.message}');
      return [];
    } catch (e) {
      debugPrint('[NotificationDS] getNotifications error: $e');
      return [];
    }
  }

  @override
  Future<void> markAsRead(String id) async {
    try {
      await _db
          .from('notifications')
          .update({'is_read': true})
          .eq('id', id);
    } catch (e) {
      debugPrint('[NotificationDS] markAsRead error: $e');
    }
  }

  @override
  Future<void> markAllAsRead() async {
    final uid = _firebaseUid;
    if (uid.isEmpty) return;
    try {
      final profile = await _db
          .from('profiles')
          .select('id')
          .eq('firebase_uid', uid)
          .single();
      final userId = profile['id'] as String;
      await _db
          .from('notifications')
          .update({'is_read': true})
          .eq('user_id', userId)
          .eq('is_read', false);
    } catch (e) {
      debugPrint('[NotificationDS] markAllAsRead error: $e');
    }
  }

  @override
  Future<int> getUnreadCount() async {
    final uid = _firebaseUid;
    if (uid.isEmpty) return 0;
    try {
      final profile = await _db
          .from('profiles')
          .select('id')
          .eq('firebase_uid', uid)
          .single();
      final userId = profile['id'] as String;
      final rows = await _db
          .from('notifications')
          .select('id')
          .eq('user_id', userId)
          .eq('is_read', false);
      return (rows as List).length;
    } catch (e) {
      debugPrint('[NotificationDS] getUnreadCount error: $e');
      return 0;
    }
  }

  // ── FCM token registration — stored directly in Supabase ─────────────────
  // Uses the upsert_device_token RPC so the token is available to Edge Functions.

  @override
  Future<void> registerPushToken(String token) async {
    final uid = _firebaseUid;
    if (uid.isEmpty || token.isEmpty) return;

    try {
      final platform = kIsWeb
          ? 'web'
          : Platform.isIOS
              ? 'ios'
              : 'android';

      await _db.rpc('upsert_device_token', params: {
        'p_firebase_uid': uid,
        'p_token': token,
        'p_platform': platform,
      });

      debugPrint('[NotificationDS] FCM token registered in Supabase');
    } on PostgrestException catch (e) {
      debugPrint('[NotificationDS] registerPushToken error: ${e.message}');
    } catch (e) {
      debugPrint('[NotificationDS] registerPushToken error: $e');
    }
  }

  @override
  Future<void> deletePushToken(String token) async {
    final uid = _firebaseUid;
    if (uid.isEmpty || token.isEmpty) return;

    try {
      await _db.rpc('delete_device_token', params: {
        'p_firebase_uid': uid,
        'p_token': token,
      });
      debugPrint('[NotificationDS] FCM token removed from Supabase');
    } catch (e) {
      debugPrint('[NotificationDS] deletePushToken error: $e');
    }
  }
}
