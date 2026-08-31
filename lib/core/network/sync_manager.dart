import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

/// Centralized manager for internet connectivity state and automatic sync triggers.
class SyncManager {
  final Connectivity _connectivity;
  final ValueNotifier<bool> isOnlineNotifier = ValueNotifier<bool>(true);

  StreamSubscription<List<ConnectivityResult>>? _subscription;
  final List<VoidCallback> _syncCallbacks = [];

  SyncManager({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  bool get isOnline => isOnlineNotifier.value;

  Future<void> initialize() async {
    // Check initial connectivity
    try {
      final results = await _connectivity.checkConnectivity();
      _updateStatus(results);
    } catch (e) {
      debugPrint('[SyncManager] Initial connectivity check failed: $e');
    }

    // Listen to continuous connectivity changes without creating duplicate subscriptions
    await _subscription?.cancel();
    _subscription = _connectivity.onConnectivityChanged.listen(_handleConnectivityChange);
  }

  void _handleConnectivityChange(List<ConnectivityResult> results) {
    final wasOffline = !isOnlineNotifier.value;
    _updateStatus(results);

    // If we just came back online, trigger all registered auto-sync handlers!
    if (wasOffline && isOnlineNotifier.value) {
      debugPrint('[SyncManager] Internet restored! Triggering automatic sync...');
      triggerSync();
    }
  }

  void _updateStatus(List<ConnectivityResult> results) {
    final online = results.isNotEmpty &&
        results.any((r) => r != ConnectivityResult.none);
    if (isOnlineNotifier.value != online) {
      isOnlineNotifier.value = online;
      debugPrint('[SyncManager] Connectivity updated: ${online ? "ONLINE" : "OFFLINE"}');
    }
  }

  /// Register a callback to be called automatically whenever internet is restored.
  void registerSyncCallback(VoidCallback callback) {
    if (!_syncCallbacks.contains(callback)) {
      _syncCallbacks.add(callback);
    }
  }

  /// Unregister a callback.
  void unregisterSyncCallback(VoidCallback callback) {
    _syncCallbacks.remove(callback);
  }

  /// Manually trigger all sync callbacks (e.g. on app resume or pull-to-refresh).
  void triggerSync() {
    for (final cb in List<VoidCallback>.from(_syncCallbacks)) {
      try {
        cb();
      } catch (e) {
        debugPrint('[SyncManager] Error running sync callback: $e');
      }
    }
  }

  void dispose() {
    _subscription?.cancel();
    isOnlineNotifier.dispose();
    _syncCallbacks.clear();
  }
}
