import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/app_button.dart';
import '../../../features/payments/domain/entities/payment.dart';
import '../bloc/customer_tip_bloc.dart';

class CustomerPaymentPage extends StatefulWidget {
  final String waiterId;
  final Map<String, dynamic> extra;

  const CustomerPaymentPage({
    super.key,
    required this.waiterId,
    required this.extra,
  });

  @override
  State<CustomerPaymentPage> createState() => _CustomerPaymentPageState();
}

class _CustomerPaymentPageState extends State<CustomerPaymentPage> {
  String? _selectedMethodId;
  Timer? _pollTimer;

  int get _amount => widget.extra['amount'] as int? ?? 0;
  String get _currency =>
      widget.extra['currency'] as String? ?? 'BIF';

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  void _startPolling() {
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (mounted) {
        context.read<CustomerTipBloc>().add(const PaymentStatusPolled());
      }
    });
  }

  void _pay() {
    if (_selectedMethodId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method.')),
      );
      return;
    }
    context
        .read<CustomerTipBloc>()
        .add(PaymentStarted(_selectedMethodId!));
    _startPolling();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerTipBloc, CustomerTipState>(
      listener: (context, state) {
        if (state is CustomerTipSuccess) {
          _pollTimer?.cancel();
          context.go('/t/${widget.waiterId}/success',
              extra: {
                'tipId': state.tip.id,
                'amount': state.tip.amount,
                'currency': state.tip.currency,
                'waiterName': state.profile.fullName.split(' ').first,
                'waiterId': widget.waiterId,
              });
        } else if (state is CustomerTipError) {
          _pollTimer?.cancel();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Choose payment method')),
        body: BlocBuilder<CustomerTipBloc, CustomerTipState>(
          builder: (context, state) {
            if (state is CustomerPaymentProcessing) {
              return _ProcessingView();
            }

            final feeBreakdown = state is CustomerTipAmountSelected
                ? state.feeBreakdown
                : null;
            final methods = state is CustomerTipAmountSelected
                ? state.paymentMethods
                : state is CustomerProfileLoaded
                    ? state.paymentMethods
                    : <PaymentMethod>[];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amount summary
                  _AmountSummary(
                    amount: _amount,
                    currency: _currency,
                    feeBreakdown: feeBreakdown,
                  ),
                  const SizedBox(height: 28),

                  Text('Pay with', style: AppTextStyles.h3),
                  const SizedBox(height: 14),

                  if (methods.isEmpty)
                    _DefaultMethodTile(
                      selected: _selectedMethodId == 'default',
                      onTap: () =>
                          setState(() => _selectedMethodId = 'default'),
                    )
                  else
                    ...methods.map(
                      (m) => _MethodTile(
                        method: m,
                        isSelected: _selectedMethodId == m.id,
                        onTap: () =>
                            setState(() => _selectedMethodId = m.id),
                      ),
                    ),

                  const SizedBox(height: 32),
                  BlocBuilder<CustomerTipBloc, CustomerTipState>(
                    builder: (context, state) => AppButton(
                      label: 'Pay ${CurrencyFormatter.format(_amount, _currency)}',
                      onPressed: _pay,
                      isLoading: state is CustomerTipLoading,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SecurityNote(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AmountSummary extends StatelessWidget {
  final int amount;
  final String currency;
  final dynamic feeBreakdown;

  const _AmountSummary({
    required this.amount,
    required this.currency,
    this.feeBreakdown,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.tipGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Tip Amount',
            style: AppTextStyles.labelMedium
                .copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Text(
            CurrencyFormatter.format(amount, currency),
            style: AppTextStyles.amountLarge
                .copyWith(color: Colors.white, fontSize: 40),
          ),
          if (feeBreakdown != null &&
              feeBreakdown.platformFee > 0) ...[
            const SizedBox(height: 12),
            const Divider(color: Colors.white24),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Platform fee',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: Colors.white70)),
                Text(
                  CurrencyFormatter.format(
                      feeBreakdown.platformFee, currency),
                  style: AppTextStyles.bodySmall
                      .copyWith(color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Waiter receives',
                    style: AppTextStyles.labelSmall
                        .copyWith(color: Colors.white)),
                Text(
                  CurrencyFormatter.format(
                      feeBreakdown.waiterReceives, currency),
                  style: AppTextStyles.labelSmall
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  const _MethodTile({
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: method.isAvailable ? onTap : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.06)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : Theme.of(context).colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.phone_android_rounded,
                  size: 20, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(method.name, style: AppTextStyles.labelMedium),
                  if (method.description != null)
                    Text(method.description!,
                        style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            if (!method.isAvailable)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.textHint.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Unavailable',
                    style: AppTextStyles.caption),
              )
            else if (isSelected)
              const Icon(Icons.check_circle_rounded,
                  color: AppColors.primary, size: 22),
          ],
        ),
      ),
    );
  }
}

class _DefaultMethodTile extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  const _DefaultMethodTile({required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.06)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.primary : Theme.of(context).colorScheme.outline,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.mobile_friendly_rounded,
                  size: 20, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mobile Money', style: AppTextStyles.labelMedium),
                  Text('Lumicash, Ecocash and more',
                      style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle_rounded,
                  color: AppColors.primary, size: 22),
          ],
        ),
      ),
    );
  }
}

class _ProcessingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.primary),
            const SizedBox(height: 24),
            Text('Processing payment…',
                style: AppTextStyles.h3, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              'Please wait while we confirm your payment.',
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SecurityNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.lock_outline_rounded,
            size: 14, color: AppColors.textHint),
        const SizedBox(width: 4),
        Text('Payments are processed securely.',
            style: AppTextStyles.caption),
      ],
    );
  }
}
