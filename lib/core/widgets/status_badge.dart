import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum BadgeStatus { pending, processing, completed, failed, refunded, cancelled, requested }

/// Small pill badge that communicates transaction/withdrawal status.
class StatusBadge extends StatelessWidget {
  final BadgeStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: _bgColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _label,
        style: AppTextStyles.caption.copyWith(
          color: _bgColor,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Color get _bgColor {
    switch (status) {
      case BadgeStatus.pending:
        return AppColors.statusPending;
      case BadgeStatus.processing:
        return AppColors.statusProcessing;
      case BadgeStatus.completed:
        return AppColors.statusCompleted;
      case BadgeStatus.failed:
        return AppColors.statusFailed;
      case BadgeStatus.refunded:
        return AppColors.statusRefunded;
      case BadgeStatus.cancelled:
        return AppColors.statusCancelled;
      case BadgeStatus.requested:
        return AppColors.statusPending;
    }
  }

  String get _label {
    switch (status) {
      case BadgeStatus.pending:
        return 'Pending';
      case BadgeStatus.processing:
        return 'Processing';
      case BadgeStatus.completed:
        return 'Completed';
      case BadgeStatus.failed:
        return 'Failed';
      case BadgeStatus.refunded:
        return 'Refunded';
      case BadgeStatus.cancelled:
        return 'Cancelled';
      case BadgeStatus.requested:
        return 'Requested';
    }
  }
}
