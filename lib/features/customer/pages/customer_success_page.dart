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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _scaleAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
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
    setState(() => _feedbackSubmitted = true);
    final tipId = widget.extra['tipId'] as String?;
    if (tipId != null) {
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
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Success animation
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
                        color: AppColors.accent.withValues(alpha: 0.35),
                        blurRadius: 28,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.check_rounded,
                      size: 52, color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),
              FadeTransition(
                opacity: _fadeAnim,
                child: Column(
                  children: [
                    Text(
                      '🎉 Tip Sent!',
                      style: AppTextStyles.h1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      CurrencyFormatter.format(_amount, _currency),
                      style: AppTextStyles.amountLarge.copyWith(
                        color: AppColors.accent,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'to $_waiterName',
                      style: AppTextStyles.h3.copyWith(
                          color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Thank you for supporting great service.',
                      style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              if (!_feedbackSubmitted) ...[
                // Rating
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
                      Text('Rate the service',
                          style: AppTextStyles.labelLarge),
                      const SizedBox(height: 12),
                      StarRating(
                        rating: _selectedRating,
                        size: 36,
                        interactive: true,
                        onRatingChanged: (r) =>
                            setState(() => _selectedRating = r),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Message
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
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle_rounded,
                          color: AppColors.accent, size: 20),
                      const SizedBox(width: 8),
                      Text('Thank you for your feedback!',
                          style: AppTextStyles.labelMedium
                              .copyWith(color: AppColors.accent)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              AppButton(
                label: 'Done',
                onPressed: () => context.go('/t/$_waiterId'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.monetization_on_rounded,
                      size: 14, color: AppColors.textHint),
                  const SizedBox(width: 4),
                  Text('Powered by amTips',
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
