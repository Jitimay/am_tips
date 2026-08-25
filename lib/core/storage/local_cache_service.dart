import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Keys for all cached data.
class CacheKeys {
  CacheKeys._();
  static const profile       = 'cache_profile';
  static const tips          = 'cache_tips';
  static const tipStats      = 'cache_tip_stats';
  static const wallet        = 'cache_wallet';
  static const transactions  = 'cache_transactions';
  static const qrCode        = 'cache_qr_code';
  static const notifications = 'cache_notifications';

  // Timestamps — stored alongside the data
  static String ts(String key) => '${key}_ts';
}

/// Simple JSON cache backed by SharedPreferences.
///
/// Every write stores a UTC timestamp alongside the data.
/// [isStale] lets callers decide whether to prefer a fresh fetch
/// or to accept cached data (e.g. when offline).
///
/// Usage:
///   await cache.write(CacheKeys.wallet, walletJson);
///   final json = await cache.read(CacheKeys.wallet);  // null if never cached
///   final stale = await cache.isStale(CacheKeys.wallet, ttl: Duration(minutes: 5));
class LocalCacheService {
  SharedPreferences? _prefs;

  Future<SharedPreferences> get _p async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // ── Write ─────────────────────────────────────────────────────────────────

  /// Stores [data] as JSON under [key] and records the current timestamp.
  Future<void> write(String key, dynamic data) async {
    try {
      final prefs = await _p;
      final encoded = jsonEncode(data);
      await prefs.setString(key, encoded);
      await prefs.setInt(CacheKeys.ts(key),
          DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      debugPrint('[Cache] write($key) error: $e');
    }
  }

  // ── Read ──────────────────────────────────────────────────────────────────

  /// Returns the cached value for [key], or `null` if not found.
  Future<dynamic> read(String key) async {
    try {
      final prefs = await _p;
      final raw = prefs.getString(key);
      if (raw == null) return null;
      return jsonDecode(raw);
    } catch (e) {
      debugPrint('[Cache] read($key) error: $e');
      return null;
    }
  }

  /// Reads and decodes a cached JSON list.
  /// Returns an empty list if nothing is cached.
  Future<List<dynamic>> readList(String key) async {
    final data = await read(key);
    if (data is List) return data;
    return [];
  }

  /// Reads and decodes a cached JSON map.
  /// Returns null if nothing is cached.
  Future<Map<String, dynamic>?> readMap(String key) async {
    final data = await read(key);
    if (data is Map) return Map<String, dynamic>.from(data);
    return null;
  }

  // ── Staleness ─────────────────────────────────────────────────────────────

  /// Returns true if the cached entry is older than [ttl] OR was never cached.
  Future<bool> isStale(String key,
      {Duration ttl = const Duration(minutes: 10)}) async {
    try {
      final prefs = await _p;
      final ts = prefs.getInt(CacheKeys.ts(key));
      if (ts == null) return true;
      final age = DateTime.now()
          .difference(DateTime.fromMillisecondsSinceEpoch(ts));
      return age > ttl;
    } catch (_) {
      return true;
    }
  }

  /// Returns true if there is any cached value for [key].
  Future<bool> has(String key) async {
    final prefs = await _p;
    return prefs.containsKey(key);
  }

  // ── Invalidate ────────────────────────────────────────────────────────────

  Future<void> remove(String key) async {
    final prefs = await _p;
    await prefs.remove(key);
    await prefs.remove(CacheKeys.ts(key));
  }

  Future<void> clearAll() async {
    final prefs = await _p;
    final keys = prefs.getKeys().where(
        (k) => k.startsWith('cache_')).toList();
    for (final k in keys) {
      await prefs.remove(k);
    }
  }

  // ── When was it last cached? ──────────────────────────────────────────────

  Future<DateTime?> lastUpdated(String key) async {
    final prefs = await _p;
    final ts = prefs.getInt(CacheKeys.ts(key));
    if (ts == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(ts);
  }
}
