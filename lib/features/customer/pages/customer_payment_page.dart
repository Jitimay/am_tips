import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/app_button.dart';
import '../../payments/data/datasources/payment_remote_datasource.dart';
import '../../payments/data/services/afripay_service.dart';
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

class _CustomerPaymentPageState extends State<CustomerPaymentPage>
    with WidgetsBindingObserver {
  String? _selectedMethodId;
  Timer? _pollTimer;
  bool _browserLaunched = false;

  int get _amount => widget.extra['amount'] as int? ?? 0;
  String get _currency => widget.extra['currency'] as String? ?? 'BIF';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Pre-compute fee immediately — local calculation, no network
    context.read<CustomerTipBloc>().add(
          TipAmountSelected(amount: _amount, currency: _currency),
        );
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// When the user returns from the AfriPay browser tab, start polling.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _browserLaunched) {
      _startPolling();
    }
  }

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (mounted) {
        context.read<CustomerTipBloc>().add(const PaymentStatusPolled());
      }
    });
  }

  void _pay() {
    if (_selectedMethodId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a payment method.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() => _browserLaunched = false);
    context.read<CustomerTipBloc>().add(const AfriPayCheckoutStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerTipBloc, CustomerTipState>(
      listener: (context, state) {
        if (state is CustomerAwaitingPayment) {
          // Browser was launched — mark it so we start polling on resume
          setState(() => _browserLaunched = true);
        } else if (state is CustomerTipSuccess) {
          _pollTimer?.cancel();
          context.go(
            '/t/${widget.waiterId}/success',
            extra: {
              'tipId': state.tipId,
              'amount': state.tipAmount,
              'currency': state.currency,
              'waiterName': state.profile.fullName.split(' ').first,
              'waiterId': widget.waiterId,
              'transactionRef': state.transactionRef,
            },
          );
        } else if (state is CustomerTipError) {
          _pollTimer?.cancel();
          setState(() => _browserLaunched = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Pay your tip')),
        body: BlocBuilder<CustomerTipBloc, CustomerTipState>(
          builder: (context, state) {
            // While inserting tip / launching browser
            if (state is CustomerTipLoading) {
              return const _LoadingView(
                message: 'Opening payment page…',
              );
            }

            // Browser launched — user is paying — show waiting screen
            if (state is CustomerAwaitingPayment) {
              return _AwaitingView(
                feeBreakdown: state.feeBreakdown,
                currency: _currency,
                onOpenAgain: () {
                  // Let user re-open AfriPay if they accidentally closed it
                  context
                      .read<CustomerTipBloc>()
                      .add(const AfriPayCheckoutStarted());
                },
                onCancel: () {
                  _pollTimer?.cancel();
                  context.pop();
                },
              );
            }

            // Normal state — show method selector + fee breakdown
            AfriPayFeeDto? fee;
            List<AfriPayMethodDto> methods = [];

            if (state is CustomerTipAmountSelected) {
              fee = state.feeBreakdown;
              methods = state.paymentMethods;
            } else if (state is CustomerProfileLoaded) {
              methods = state.paymentMethods;
            }

            // Compute fee locally if not yet available
            fee ??= AfriPayFeeDto(
              tipAmount: _amount,
              gatewayFee: AfriPayService.gatewayFee(_amount),
              platformFee: 0,
              totalFee: AfriPayService.gatewayFee(_amount),
              customerPays: AfriPayService.customerPays(_amount),
              waiterReceives: _amount,
              currency: _currency,
            );

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Fee breakdown card ──────────────────────────────
                  _FeeBreakdownCard(fee: fee, currency: _currency),
                  const SizedBox(height: 28),

                  // ── Payment method selection ───────────────────────
                  Text('Pay with', style: AppTextStyles.h3),
                  const SizedBox(height: 14),
                  ...methods.map(
                    (m) => _MethodTile(
                      method: m,
                      isSelected: _selectedMethodId == m.id,
                      onTap: () =>
                          setState(() => _selectedMethodId = m.id),
                    ),
                  ),
                  if (methods.isEmpty) ...[
                    _MethodTile(
                      method: const AfriPayMethodDto(
                        id: 'lumicash',
                        name: 'LumiCash',
                        provider: 'afripay',
                        type: 'mobile_money',
                        description: 'Pay with your LumiCash mobile wallet',
                        isAvailable: true,
                        emoji: '📱',
                      ),
                      isSelected: _selectedMethodId == 'lumicash',
                      onTap: () =>
                          setState(() => _selectedMethodId = 'lumicash'),
                    ),
                    _MethodTile(
                      method: const AfriPayMethodDto(
                        id: 'bancobu_enoti',
                        name: 'BANCOBU eNoti',
                        provider: 'afripay',
                        type: 'mobile_money',
                        description: 'Pay via BANCOBU eNoti mobile banking',
                        isAvailable: true,
                        emoji: '🏦',
                      ),
                      isSelected: _selectedMethodId == 'bancobu_enoti',
                      onTap: () => setState(
                          () => _selectedMethodId = 'bancobu_enoti'),
                    ),
                  ],
                  const SizedBox(height: 32),

                  // ── Pay button ─────────────────────────────────────
                  AppButton(
                    label:
                        'Pay ${CurrencyFormatter.format(fee.customerPays, _currency)}',
                    onPressed: _selectedMethodId != null ? _pay : null,
                  ),
                  const SizedBox(height: 16),

                  // ── Security note ──────────────────────────────────
                  const _SecurityNote(),
                  const SizedBox(height: 8),

                  // ── AfriPay branding ───────────────────────────────
                  const _AfriPayBadge(),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Fee Breakdown Card — Task 4
// Shows tip amount, AfriPay 4% fee, total customer pays, waiter receives.
// ─────────────────────────────────────────────────────────────────────────────

class _FeeBreakdownCard extends StatelessWidget {
  final AfriPayFeeDto fee;
  final String currency;

  const _FeeBreakdownCard({required this.fee, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.tipGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment summary',
            style: AppTextStyles.labelSmall
                .copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 12),

          // ── Tip amount (large) ──────────────────────────────────────
          Text(
            CurrencyFormatter.format(fee.tipAmount, currency),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tip amount',
            style: AppTextStyles.caption
                .copyWith(color: Colors.white60),
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.white.withValues(alpha: 0.2)),
          const SizedBox(height: 12),

          // ── Fee rows ──────────────────────────────────────────────
          _FeeRow(
            label: 'AfriPay processing fee (4%)',
            value: CurrencyFormatter.format(fee.gatewayFee, currency),
          ),
          if (fee.platformFee > 0) ...[
            const SizedBox(height: 6),
            _FeeRow(
              label: 'amTips platform fee',
              value: CurrencyFormatter.format(fee.platformFee, currency),
            ),
          ],
          const SizedBox(height: 10),
          Divider(color: Colors.white.withValues(alpha: 0.15)),
          const SizedBox(height: 10),

          // ── You pay ───────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'You pay',
                style: AppTextStyles.labelMedium
                    .copyWith(color: Colors.white),
              ),
              Text(
                CurrencyFormatter.format(fee.customerPays, currency),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // ── Waiter receives ───────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.check_circle_outline_rounded,
                      color: Colors.white70, size: 14),
                  const SizedBox(width: 5),
                  Text(
                    'Creator receives',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: Colors.white70),
                  ),
                ],
              ),
              Text(
                CurrencyFormatter.format(fee.waiterReceives, currency),
                style: AppTextStyles.labelMedium
                    .copyWith(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeeRow extends StatelessWidget {
  final String label;
  final String value;

  const _FeeRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: AppTextStyles.bodySmall
                .copyWith(color: Colors.white60)),
        Text(value,
            style: AppTextStyles.bodySmall
                .copyWith(color: Colors.white70)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Method Tile
// ─────────────────────────────────────────────────────────────────────────────

class _MethodTile extends StatelessWidget {
  final AfriPayMethodDto method;
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.06)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : Theme.of(context).colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Emoji icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.primarySurface,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  method.emoji,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Name + description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.name,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    method.description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            // Check / unavailable indicator
            if (!method.isAvailable)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.textHint.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Unavailable',
                    style: AppTextStyles.caption),
              )
            else
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isSelected
                    ? const Icon(Icons.check_circle_rounded,
                        color: AppColors.primary, size: 24,
                        key: ValueKey('checked'))
                    : const Icon(Icons.radio_button_unchecked_rounded,
                        color: AppColors.textHint, size: 24,
                        key: ValueKey('unchecked')),
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Awaiting Payment View — shown after browser launches
// ─────────────────────────────────────────────────────────────────────────────

class _AwaitingView extends StatelessWidget {
  final AfriPayFeeDto feeBreakdown;
  final String currency;
  final VoidCallback onOpenAgain;
  final VoidCallback onCancel;

  const _AwaitingView({
    required this.feeBreakdown,
    required this.currency,
    required this.onOpenAgain,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated pulse circle
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.85, end: 1.0),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOut,
            builder: (_, scale, child) => Transform.scale(
              scale: scale,
              child: child,
            ),
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(Icons.payment_rounded,
                  color: Colors.white, size: 44),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Complete your payment',
            style: AppTextStyles.h2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'The AfriPay checkout page has opened in your browser.\n'
            'Complete the payment with LumiCash or BANCOBU eNoti, '
            'then come back here.',
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Amount reminder
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.info_outline_rounded,
                    color: AppColors.primary, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Total: ${CurrencyFormatter.format(feeBreakdown.customerPays, currency)}  '
                  '(incl. 4% fee)',
                  style: AppTextStyles.labelMedium
                      .copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Polling indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Waiting for payment confirmation…',
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 32),

          AppButton(
            label: 'Re-open Payment Page',
            onPressed: onOpenAgain,
            variant: AppButtonVariant.outline,
            prefixIcon: const Icon(Icons.open_in_browser_rounded,
                size: 18, color: AppColors.primary),
          ),
          const SizedBox(height: 12),
          AppButton(
            label: 'Cancel',
            onPressed: onCancel,
            variant: AppButtonVariant.ghost,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Loading View
// ─────────────────────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  final String message;
  const _LoadingView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.primary),
            const SizedBox(height: 20),
            Text(message,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Security note + AfriPay badge
// ─────────────────────────────────────────────────────────────────────────────

class _SecurityNote extends StatelessWidget {
  const _SecurityNote();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.lock_outline_rounded,
            size: 13, color: AppColors.textHint),
        const SizedBox(width: 5),
        Text(
          'Payments are processed securely by AfriPay.',
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}

class _AfriPayBadge extends StatelessWidget {
  const _AfriPayBadge();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.verified_rounded,
                size: 14, color: AppColors.primary),
            const SizedBox(width: 6),
            Text(
              'Powered by AfriPay · LumiCash · BANCOBU eNoti',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
