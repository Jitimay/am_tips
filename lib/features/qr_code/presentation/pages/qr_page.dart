import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../bloc/qr_cubit.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  final GlobalKey _qrKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<QrCubit>().loadQrCode();
  }

  Future<void> _shareQr(String url, String waiterName) async {
    try {
      final boundary =
          _qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        await Share.share(
          'Scan my amTips QR to leave a tip!\n$url',
          subject: 'Tip $waiterName on amTips',
        );
        return;
      }
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;

      final bytes = byteData.buffer.asUint8List();
      final dir = await getTemporaryDirectory();
      final file = await File('${dir.path}/amtips_qr.png').writeAsBytes(bytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Scan to tip $waiterName on amTips!\n$url',
        subject: 'amTips QR Code',
      );
    } catch (e) {
      await Share.share('Scan my amTips QR to leave a tip!\n$url');
    }
  }

  Future<void> _saveQr(String url, String waiterName) async {
    try {
      final boundary =
          _qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;
      final bytes = byteData.buffer.asUint8List();
      final dir = await getApplicationDocumentsDirectory();
      await File('${dir.path}/amtips_qr_$waiterName.png')
          .writeAsBytes(bytes);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('QR saved to documents!')),
        );
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My QR Code')),
      body: BlocBuilder<QrCubit, QrState>(
        builder: (context, qrState) {
          if (qrState is QrLoading || qrState is QrInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (qrState is QrError) {
            return ErrorState(
              message: qrState.message,
              onRetry: () => context.read<QrCubit>().loadQrCode(),
            );
          }
          final qr = qrState is QrLoaded
              ? qrState.qrCode
              : (qrState as QrSharing).qrCode;

          return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, profileState) {
              final name = profileState is ProfileLoaded
                  ? profileState.profile.fullName.split(' ').first
                  : 'You';
              final restaurant = profileState is ProfileLoaded
                  ? profileState.profile.restaurantName
                  : '';

              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // QR card (capturable for share/save)
                    RepaintBoundary(
                      key: _qrKey,
                      child: _QrCard(
                        url: qr.url,
                        waiterName: name,
                        restaurantName: restaurant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // URL display
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.link_rounded,
                              size: 16, color: AppColors.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              qr.url,
                              style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.primary),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    // Action buttons
                    AppButton(
                      label: 'Share QR Code',
                      onPressed: () => _shareQr(qr.url, name),
                      prefixIcon: const Icon(Icons.share_rounded,
                          size: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    AppButton(
                      label: 'Save QR Code',
                      onPressed: () => _saveQr(qr.url, name),
                      variant: AppButtonVariant.outline,
                      prefixIcon: const Icon(Icons.download_rounded,
                          size: 18, color: AppColors.primary),
                    ),
                    const SizedBox(height: 12),
                    AppButton(
                      label: 'Regenerate QR',
                      onPressed: () => _confirmRegenerate(context),
                      variant: AppButtonVariant.ghost,
                      prefixIcon: const Icon(Icons.refresh_rounded,
                          size: 18, color: AppColors.primary),
                    ),
                    const SizedBox(height: 24),
                    // Info note
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.info.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info_outline_rounded,
                              size: 18, color: AppColors.info),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Print or display this QR code at your workstation. Customers scan it with their phone camera — no app required.',
                              style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _confirmRegenerate(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Regenerate QR Code?'),
        content: const Text(
            'Your old QR code will stop working. Any existing prints will need to be replaced.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<QrCubit>().regenerate();
            },
            child: Text('Regenerate',
                style: TextStyle(color: AppColors.warning)),
          ),
        ],
      ),
    );
  }
}

// ── Printable QR card ──────────────────────────────────────────────────────

class _QrCard extends StatelessWidget {
  final String url;
  final String waiterName;
  final String restaurantName;

  const _QrCard({
    required this.url,
    required this.waiterName,
    required this.restaurantName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Brand header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.monetization_on_rounded,
                    size: 16, color: Colors.white),
              ),
              const SizedBox(width: 6),
              Text(
                AppConstants.appName,
                style: AppTextStyles.h3.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Waiter name
          Text(
            waiterName,
            style: AppTextStyles.h1.copyWith(color: AppColors.textPrimary),
          ),
          if (restaurantName.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              restaurantName,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
          ],
          const SizedBox(height: 20),

          // QR code
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider, width: 1),
            ),
            child: QrImageView(
              data: url,
              version: QrVersions.auto,
              size: AppConstants.qrSize,
              backgroundColor: Colors.white,
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: AppColors.textPrimary,
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text(
            'Scan to leave a tip',
            style: AppTextStyles.labelMedium
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 6),
          Text(
            'Thank you ❤️',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
