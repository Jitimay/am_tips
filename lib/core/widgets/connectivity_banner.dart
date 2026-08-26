import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Wraps any widget with an offline/online transition banner that appears at the top.
/// Informs the user when they are viewing offline cached data and when data has refreshed.
class ConnectivityBanner extends StatefulWidget {
  final Widget child;
  const ConnectivityBanner({super.key, required this.child});

  @override
  State<ConnectivityBanner> createState() => _ConnectivityBannerState();
}

class _ConnectivityBannerState extends State<ConnectivityBanner>
    with SingleTickerProviderStateMixin {
  late final StreamSubscription<List<ConnectivityResult>> _sub;
  bool _isOffline = false;
  bool _showOnlineRestored = false;
  Timer? _restoredTimer;

  late final AnimationController _controller;
  late final Animation<double> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnim = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _sub = Connectivity().onConnectivityChanged.listen(_onConnectivityChanged);

    // Check initial state
    Connectivity().checkConnectivity().then((results) {
      _onConnectivityChanged(results);
    });
  }

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    final offline = results.every((r) => r == ConnectivityResult.none);
    if (offline == _isOffline) return;

    if (!offline && _isOffline) {
      // Just transitioned from OFFLINE -> ONLINE
      setState(() {
        _isOffline = false;
        _showOnlineRestored = true;
      });
      _restoredTimer?.cancel();
      _restoredTimer = Timer(const Duration(seconds: 3), () {
        if (mounted) {
          _controller.reverse().then((_) {
            if (mounted) setState(() => _showOnlineRestored = false);
          });
        }
      });
    } else {
      setState(() {
        _isOffline = offline;
        _showOnlineRestored = false;
      });
      if (offline) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _restoredTimer?.cancel();
    _sub.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Only show the "Back online" green flash — no offline banner
        AnimatedBuilder(
          animation: _slideAnim,
          builder: (context, child) => Transform.translate(
            offset: Offset(0, _slideAnim.value * 48),
            child: _showOnlineRestored
                ? const _OnlineRestoredBanner()
                : const SizedBox.shrink(),
          ),
        ),
        Expanded(child: widget.child),
      ],
    );
  }
}

class _OnlineRestoredBanner extends StatelessWidget {
  const _OnlineRestoredBanner();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.success,
      child: SafeArea(
        bottom: false,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: AppColors.success,
          child: Row(
            children: [
              const Icon(Icons.check_circle_outline_rounded,
                  color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Back online — synced and updated!',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
