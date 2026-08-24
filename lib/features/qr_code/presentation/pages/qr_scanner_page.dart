import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// QR code scanner page.
///
/// Scans amTips QR codes (amtips.app/t/{waiterId} or amtips://t/{waiterId})
/// and navigates to the customer tipping page.
/// Can also be used to scan any amTips-formatted QR.
class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage>
    with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool _hasNavigated = false;
  bool _torchOn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_controller.value.isInitialized) return;
    if (state == AppLifecycleState.resumed) {
      _controller.start();
    } else if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  // ── QR detection ──────────────────────────────────────────────────────────

  void _onDetect(BarcodeCapture capture) {
    if (_hasNavigated) return;
    final barcode = capture.barcodes.firstOrNull;
    final rawValue = barcode?.rawValue;
    if (rawValue == null || rawValue.isEmpty) return;

    final waiterId = _extractWaiterId(rawValue);
    if (waiterId == null) {
      _showInvalidQrSnackbar(rawValue);
      return;
    }

    setState(() => _hasNavigated = true);
    HapticFeedback.mediumImpact();
    _controller.stop();

    // Navigate to the customer tipping page
    context.push('/t/$waiterId').then((_) {
      // Reset when user comes back so they can scan again
      if (mounted) {
        setState(() => _hasNavigated = false);
        _controller.start();
      }
    });
  }

  /// Extracts the waiter ID from various QR URL formats:
  ///   https://amtips.app/t/{id}
  ///   amtips://t/{id}
  ///   {id}  (raw UUID — fallback)
  String? _extractWaiterId(String raw) {
    final trimmed = raw.trim();

    // https://amtips.app/t/{id}
    final webPattern = RegExp(
      r'https?://(?:www\.)?amtips\.app/t/([a-zA-Z0-9\-_]+)',
    );
    final webMatch = webPattern.firstMatch(trimmed);
    if (webMatch != null) return webMatch.group(1);

    // amtips://t/{id}
    final deepLinkPattern = RegExp(r'amtips://t/([a-zA-Z0-9\-_]+)');
    final deepMatch = deepLinkPattern.firstMatch(trimmed);
    if (deepMatch != null) return deepMatch.group(1);

    // Raw UUID (36 chars)
    final uuidPattern = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
    );
    if (uuidPattern.hasMatch(trimmed)) return trimmed;

    return null;
  }

  void _showInvalidQrSnackbar(String raw) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.qr_code_scanner_rounded,
                color: Colors.white, size: 18),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Not an amTips QR code. Please scan an amTips tip code.',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 80),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _toggleTorch() {
    setState(() => _torchOn = !_torchOn);
    _controller.toggleTorch();
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── Camera feed ─────────────────────────────────────────────────
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
            errorBuilder: (context, error) {
              return _CameraErrorView(error: error.errorCode.name);
            },
          ),

          // ── Overlay ──────────────────────────────────────────────────────
          _ScannerOverlay(),

          // ── Top bar ──────────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Close
                  _CircleButton(
                    icon: Icons.close_rounded,
                    onTap: () => context.pop(),
                  ),
                  // Title
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Scan amTips QR',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  // Torch
                  _CircleButton(
                    icon: _torchOn
                        ? Icons.flashlight_off_rounded
                        : Icons.flashlight_on_rounded,
                    onTap: _toggleTorch,
                  ),
                ],
              ),
            ),
          ),

          // ── Bottom hint ───────────────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.75),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    // amTips logo strip
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.chat_bubble_rounded,
                              color: Colors.white, size: 14),
                        ),
                        const SizedBox(width: 7),
                        const Text(
                          AppConstants.appName,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Point your camera at a creator\'s\namTips QR code to send a tip.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white70,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Scanner overlay — dark frame with transparent viewfinder square
// ─────────────────────────────────────────────────────────────────────────────

class _ScannerOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _OverlayPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _OverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const cutoutSize = 260.0;
    const cornerRadius = 20.0;
    const cornerLength = 32.0;
    const strokeWidth = 3.5;

    final cx = size.width / 2;
    final cy = size.height / 2 - 40; // slightly above center

    final rect = Rect.fromCenter(
      center: Offset(cx, cy),
      width: cutoutSize,
      height: cutoutSize,
    );

    // Dark overlay with cutout
    final overlayPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(cornerRadius)))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(
      overlayPath,
      Paint()..color = Colors.black.withValues(alpha: 0.55),
    );

    // Corner markers — purple brand color
    final cornerPaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final l = rect.left;
    final t = rect.top;
    final r = rect.right;
    final b = rect.bottom;
    final cr = cornerRadius;

    // Top-left
    canvas.drawPath(
      Path()
        ..moveTo(l + cr, t)
        ..lineTo(l + cr + cornerLength, t)
        ..moveTo(l, t + cr)
        ..lineTo(l, t + cr + cornerLength),
      cornerPaint,
    );
    // Top-right
    canvas.drawPath(
      Path()
        ..moveTo(r - cr - cornerLength, t)
        ..lineTo(r - cr, t)
        ..moveTo(r, t + cr)
        ..lineTo(r, t + cr + cornerLength),
      cornerPaint,
    );
    // Bottom-left
    canvas.drawPath(
      Path()
        ..moveTo(l + cr, b)
        ..lineTo(l + cr + cornerLength, b)
        ..moveTo(l, b - cr)
        ..lineTo(l, b - cr - cornerLength),
      cornerPaint,
    );
    // Bottom-right
    canvas.drawPath(
      Path()
        ..moveTo(r - cr - cornerLength, b)
        ..lineTo(r - cr, b)
        ..moveTo(r, b - cr)
        ..lineTo(r, b - cr - cornerLength),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.45),
          shape: BoxShape.circle,
          border: Border.all(
              color: Colors.white.withValues(alpha: 0.2), width: 1),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

class _CameraErrorView extends StatelessWidget {
  final String error;
  const _CameraErrorView({required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.no_photography_outlined,
                color: Colors.white54, size: 56),
            const SizedBox(height: 16),
            Text(
              'Camera unavailable',
              style: AppTextStyles.h3.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              _friendlyError(error),
              style: AppTextStyles.bodySmall
                  .copyWith(color: Colors.white54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Go back',
                  style: TextStyle(color: AppColors.primaryLight)),
            ),
          ],
        ),
      ),
    );
  }

  String _friendlyError(String code) {
    switch (code.toLowerCase()) {
      case 'permissiondenied':
        return 'Camera permission denied.\nGo to Settings → amTips → allow Camera.';
      case 'nocamerasavailable':
        return 'No camera found on this device.';
      default:
        return 'Could not start camera ($code).';
    }
  }
}
