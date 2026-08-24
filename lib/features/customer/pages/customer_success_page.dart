import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/star_rating.dart';
import '../bloc/customer_tip_bloc.dart';

class CustomerSuccessPage extends StatefulWidget {
  final Map<String, dynamic> extra;
  const CustomerSuccessPage({super.key, required this.extra});

  @override
  State<CustomerSuccessPage> createState() => _CustomerSuccessPageState();
}

class _CustomerSuccessPageState extends State<CustomerSuccessPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  int _selectedRating = 0;
  final _messageController = TextEditingController();
  bool _feedbackSubmitted = false;

  int get _amount => widget.extra['amount'] as int? ?? 0;
  String get _currency => widget.extra['currency'] as String? ?? 'BIF';
  String get _waiterName => widget.extra['waiterName'] as String? ?? '';
  String get _waiterId => widget.extra['waiterId'] as String? ?? '';
  String? get _tipId => widget.extra['tipId'] as String?;
  String? get _transactionRef => widget.extra['transactionRef'] as String?;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _scaleAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.3, 1.0, curve: Curves.easeIn)),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_feedbackSubmitted) return;
    if (_messageController.text.trim().isNotEmpty) {
      final err = Validators.message(_messageController.text.trim());
      if (err != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err), behavior: SnackBarBehavior.floating),
        );
        return;
      }
    }
    setState(() => _feedbackSubmitted = true);
    if (_tipId != null) {
      context.read<CustomerTipBloc>().add(
            PaymentCompleted(
              rating: _selectedRating > 0 ? _selectedRating : null,
              message: _messageController.text.trim().isNotEmpty
                  ? _messageController.text.trim()
                  : null,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
          child: Column(
            children: [
              // ── Success icon ────────────────────────────────────────────
              ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: AppColors.tipGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.4),
                        blurRadius: 32,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.check_rounded,
                      size: 52, color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),

              // ── Hero text ────────────────────────────────────────────────
              FadeTransition(
                opacity: _fadeAnim,
                child: Column(
                  children: [
                    Text('🎉 Tip Sent!',
                        style: AppTextStyles.h1,
                        textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Text(
                      CurrencyFormatter.format(_amount, _currency),
                      style: AppTextStyles.amountLarge.copyWith(
                          color: AppColors.accent, fontSize: 40),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'to $_waiterName',
                      style: AppTextStyles.h3
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Thank you for supporting great service.',
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // ── AfriPay transaction reference ────────────────────────────
              if (_transactionRef != null &&
                  _transactionRef!.isNotEmpty) ...[
                const SizedBox(height: 16),
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color:
                              AppColors.primary.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.receipt_long_outlined,
                            size: 16, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AfriPay reference',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                _transactionRef!,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 28),

              // ── Feedback section ─────────────────────────────────────────
              if (!_feedbackSubmitted) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.outline),
                  ),
                  child: Column(
                    children: [
                      Text('Rate your experience',
                          style: AppTextStyles.labelLarge),
                      const SizedBox(height: 4),
                      Text(
                        'Your rating helps the creator improve.',
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 14),
                      StarRating(
                        rating: _selectedRating,
                        size: 40,
                        interactive: true,
                        onRatingChanged: (r) =>
                            setState(() => _selectedRating = r),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _messageController,
                  label: 'Leave a message (optional)',
                  hint: '"Excellent service!"',
                  maxLines: 3,
                  maxLength: 200,
                  validator: Validators.message,
                ),
                const SizedBox(height: 20),
                AppButton(
                  label: 'Submit Feedback',
                  onPressed: _submitFeedback,
                  variant: AppButtonVariant.outline,
                ),
                const SizedBox(height: 12),
              ] else ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color:
                            AppColors.accent.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle_rounded,
                          color: AppColors.accent, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Thank you for your feedback!',
                        style: AppTextStyles.labelMedium
                            .copyWith(color: AppColors.accent),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // ── Done button ──────────────────────────────────────────────
              AppButton(
                label: 'Done',
                onPressed: () {
                  context
                      .read<CustomerTipBloc>()
                      .add(const CustomerTipReset());
                  context.go('/t/$_waiterId');
                },
              ),
              const SizedBox(height: 20),

              // ── Footer ───────────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.monetization_on_rounded,
                      size: 13, color: AppColors.textHint),
                  const SizedBox(width: 4),
                  Text('Powered by amTips · AfriPay',
                      style: AppTextStyles.caption),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
