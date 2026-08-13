import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Financial stat card used on the home dashboard.
class StatCard extends StatelessWidget {
  final String label;
  final String amount;
  final String currency;
  final IconData? icon;
  final Color? accentColor;
  final bool isLoading;

  const StatCard({
    super.key,
    required this.label,
    required this.amount,
    required this.currency,
    this.icon,
    this.accentColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppColors.primary;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null)
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 16, color: color),
                ),
              if (icon != null) const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (isLoading)
            Container(
              height: 24,
              width: 80,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(4),
              ),
            )
          else
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: amount,
                    style: AppTextStyles.amountMedium.copyWith(color: color),
                  ),
                  TextSpan(
                    text: ' $currency',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
