import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _CustomerPaymentPageState extends State<CustomerPaymentPage> {
  String? _selectedMethodId;
  bool _requiresOtp = false;
  bool _requestingOtp = false;
  final _phoneCtrl = TextEditingController();
  final _otpCtrl = TextEditingController();
  Timer? _pollTimer;
  List<AfriPayMethodDto> _methods = [];

  int get _amount => widget.extra['amount'] as int? ?? 0;
  String get _currency => widget.extra['currency'] as String? ?? 'BIF';

  @override
  void initState() {
    super.initState();
    final currentState = context.read<CustomerTipBloc>().state;
    if (currentState is CustomerProfileLoaded && currentState.paymentMethods.isNotEmpty) {
      _methods = currentState.paymentMethods;
    } else if (currentState is CustomerTipAmountSelected && currentState.paymentMethods.isNotEmpty) {
      _methods = currentState.paymentMethods;
    }
    context.read<CustomerTipBloc>().add(
          TipAmountSelected(amount: _amount, currency: _currency),
        );
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _phoneCtrl.dispose();
    _otpCtrl.dispose();
    super.dispose();
  }

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (mounted) {
        context.read<CustomerTipBloc>().add(const PaymentStatusPolled());
      }
    });
  }

  void _requestOtp() {
    final phone = _phoneCtrl.text.trim();
    if (phone.isEmpty) {
      _showSnack('Please enter your phone number first.');
      return;
    }
    if (_selectedMethodId == null) {
      _showSnack('Please select a payment method.');
      return;
    }
    setState(() => _requestingOtp = true);
    context.read<CustomerTipBloc>().add(OtpRequested(
          phone: phone,
          paymentMethod: _selectedMethodId!,
        ));
  }

  void _pay() {
    final phone = _phoneCtrl.text.trim();
    if (phone.isEmpty) {
      _showSnack('Please enter your phone number.');
      return;
    }
    if (_selectedMethodId == null) {
      _showSnack('Please select a payment method.');
      return;
    }
    if (_requiresOtp && _otpCtrl.text.trim().isEmpty) {
      _showSnack('Please enter the OTP sent to your phone.');
      return;
    }
    context.read<CustomerTipBloc>().add(AfriPayCheckoutStarted(
          phone: phone,
          paymentMethod: _selectedMethodId!,
          otp: _requiresOtp ? _otpCtrl.text.trim() : null,
        ));
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerTipBloc, CustomerTipState>(
      listener: (context, state) {
        // Cache methods into local state so rebuilds don't re-read from bloc
        if (state is CustomerTipAmountSelected && state.paymentMethods.isNotEmpty) {
          setState(() {
            _methods = state.paymentMethods;
            _requestingOtp = false;
          });
        } else if (state is CustomerProfileLoaded && state.paymentMethods.isNotEmpty) {
          setState(() {
            _methods = state.paymentMethods;
            _requestingOtp = false;
          });
        } else if (state is CustomerOtpSent && state.paymentMethods.isNotEmpty) {
          setState(() {
            _methods = state.paymentMethods;
            _requestingOtp = false;
          });
        }
        if (state is CustomerAwaitingPayment) {
          _startPolling();
        } else if (state is CustomerOtpSent) {
          setState(() => _requestingOtp = false);
          _showSnack('OTP sent! Check your phone and enter it below.');
        } else if (state is CustomerTipAmountSelected && state.errorMessage != null) {
          setState(() => _requestingOtp = false);
          _pollTimer?.cancel();
          _showSnack(state.errorMessage!);
        } else if (state is CustomerTipError) {
          setState(() => _requestingOtp = false);
          _showSnack(state.message);
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
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Pay your tip')),
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<CustomerTipBloc, CustomerTipState>(
          // Only rebuild for loading/awaiting states — NOT for poll ticks
          buildWhen: (prev, curr) =>
              curr is CustomerTipLoading ||
              curr is CustomerAwaitingPayment ||
              curr is CustomerTipAmountSelected ||
              curr is CustomerProfileLoaded ||
              curr is CustomerOtpSent ||
              curr is CustomerTipSuccess ||
              curr is CustomerTipError,
          builder: (context, state) {
            if (state is CustomerTipLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CustomerAwaitingPayment) {
              final steps = _methods
                  .firstWhere((m) => m.id == _selectedMethodId,
                      orElse: () => const AfriPayMethodDto(id: '', name: '', provider: '', type: '', description: '', isAvailable: true, emoji: ''))
                  .description;
              return _AwaitingConfirmationView(
                feeBreakdown: state.feeBreakdown,
                currency: _currency,
                steps: steps,
                onCancel: () {
                  _pollTimer?.cancel();
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/t/${widget.waiterId}');
                  }
                },
              );
            }

            AfriPayFeeDto? fee;
            if (state is CustomerTipAmountSelected) {
              fee = state.feeBreakdown;
            } else if (state is CustomerOtpSent) {
              fee = state.feeBreakdown;
            }

            fee ??= AfriPayFeeDto(
              tipAmount: _amount,
              gatewayFee: AfriPayService.gatewayFee(_amount),
              platformFee: AfriPayService.platformFee(_amount),
              totalFee: AfriPayService.totalFee(_amount),
              customerPays: AfriPayService.customerPays(_amount),
              waiterReceives: AfriPayService.waiterReceives(_amount),
              currency: _currency,
            );

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FeeBreakdownCard(fee: fee, currency: _currency),
                  const SizedBox(height: 28),

                  Text('Select payment method', style: AppTextStyles.h3),
                  const SizedBox(height: 14),
                  ...(_methods).map((m) => _MethodTile(
                        method: m,
                        selected: _selectedMethodId == m.id,
                        onTap: () {
                          setState(() {
                            _selectedMethodId = m.id;
                            _requiresOtp = m.requiresOtp;
                            _otpCtrl.clear();
                          });
                        },
                      )),

                  const SizedBox(height: 24),

                  // Phone number input
                  Text('Your mobile money number', style: AppTextStyles.h3),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      hintText: 'e.g. 25761234567',
                      prefixIcon: Icon(Icons.phone_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),

                  // OTP section
                  if (_requiresOtp) ...[
                    const SizedBox(height: 20),
                    Text('One-Time Password (OTP)', style: AppTextStyles.h3),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _otpCtrl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: 'Enter OTP',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: _requestingOtp
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Center(
                                    child: SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                )
                              : TextButton(
                                  onPressed: _requestOtp,
                                  child: const Text(
                                    'Get OTP',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 32),
                  AppButton(
                    label:
                        'Pay ${CurrencyFormatter.format(_amount, _currency)}',
                    onPressed: _pay,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ── Fee breakdown card ────────────────────────────────────────────────────────

class _FeeBreakdownCard extends StatelessWidget {
  final AfriPayFeeDto fee;
  final String currency;
  const _FeeBreakdownCard({required this.fee, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('You pay', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
          Text(CurrencyFormatter.format(fee.customerPays, currency),
              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

// ── Payment method tile ───────────────────────────────────────────────────────

class _MethodTile extends StatelessWidget {
  final AfriPayMethodDto method;
  final bool selected;
  final VoidCallback onTap;
  const _MethodTile(
      {required this.method, required this.selected, required this.onTap});

  Widget _methodInitial(String name) => Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.primary),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: selected
            ? AppColors.primary.withValues(alpha: 0.06)
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: selected ? AppColors.primary : AppColors.cardBorder,
            width: selected ? 2 : 1.5,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Logo circle
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: method.iconUrl != null
                      ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: method.iconUrl!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => _methodInitial(method.name),
                            placeholder: (context, url) => _methodInitial(method.name),
                          ),
                        )
                      : _methodInitial(method.name),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    method.name.toUpperCase(),
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                if (selected)
                  const Icon(Icons.check_circle_rounded,
                      color: AppColors.primary, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Awaiting confirmation view ────────────────────────────────────────────────

class _AwaitingConfirmationView extends StatelessWidget {
  final AfriPayFeeDto feeBreakdown;
  final String currency;
  final String steps;
  final VoidCallback onCancel;
  const _AwaitingConfirmationView(
      {required this.feeBreakdown,
      required this.currency,
      required this.steps,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.phone_android_rounded,
              size: 64, color: AppColors.primary),
          const SizedBox(height: 24),
          Text('Check your phone!',
              style: AppTextStyles.h2, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(
            'A payment request of ${CurrencyFormatter.format(feeBreakdown.customerPays, currency)} '
            'was sent to your mobile money account.\n\nPlease confirm it on your phone.',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          if (steps.isNotEmpty) ...[
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                steps.replaceAll('\r\n', '\n'),
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.left,
              ),
            ),
          ],
          const SizedBox(height: 32),
          const CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: 32),
          TextButton(
            onPressed: onCancel,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
