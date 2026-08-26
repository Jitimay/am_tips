import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../tips/presentation/bloc/wallet_cubit.dart';
import '../bloc/withdrawal_bloc.dart';

class WithdrawalPage extends StatefulWidget {
  const WithdrawalPage({super.key});

  @override
  State<WithdrawalPage> createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ensure latest data is loaded
    context.read<WalletCubit>().loadWallet();
    context.read<ProfileBloc>().add(const LoadProfile());
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit({
    required int availableBalance,
    required String currency,
    required String? paymentAccountId,
  }) {
    if (!_formKey.currentState!.validate()) return;

    if (paymentAccountId == null) {
      SnackBarUtils.showError(
        context,
        'No payment account connected. Add one in Edit Profile first.',
      );
      // Take user directly to edit profile
      context.push(AppRoutes.editProfile);
      return;
    }

    final amount = int.parse(
        _amountController.text.replaceAll(',', '').trim());

    context.read<WithdrawalBloc>().add(WithdrawalRequested(
          amount: amount,
          currency: currency,
          paymentAccountId: paymentAccountId,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WithdrawalBloc, WithdrawalState>(
      listener: (context, state) {
        if (state is WithdrawalSuccess) {
          context.read<WalletCubit>().refreshWallet();
          _showSuccessDialog(context, state);
        } else if (state is WithdrawalError) {
          SnackBarUtils.showError(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Withdraw Funds')),
        body: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, walletState) {
            return BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, profileState) {
                // ── Derive real values from BLoC states ────────────
                final wallet = walletState is WalletLoaded
                    ? walletState.wallet
                    : null;
                final availableBalance =
                    wallet?.availableBalance ?? 0;
                final currency =
                    wallet?.currency ?? AppConstants.defaultCurrency;

                final account = profileState is ProfileLoaded
                    ? profileState.profile.connectedPaymentAccount
                    : null;
                final paymentAccountId = account?.id;

                final isLoading =
                    walletState is WalletLoading ||
                    profileState is ProfileLoading;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Available balance card ──────────────────
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: AppColors.walletGradient,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: isLoading
                              ? const Center(
                                  child: SizedBox(
                                    height: 36,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Available to withdraw',
                                      style:
                                          AppTextStyles.labelSmall.copyWith(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      CurrencyFormatter.format(
                                          availableBalance, currency),
                                      style:
                                          AppTextStyles.amountMedium.copyWith(
                                        color: Colors.white,
                                        fontSize: 32,
                                      ),
                                    ),
                                    if (availableBalance == 0) ...[
                                      const SizedBox(height: 8),
                                      Text(
                                        'Receive tips first to build your balance.',
                                        style: AppTextStyles.bodySmall
                                            .copyWith(color: Colors.white60),
                                      ),
                                    ],
                                  ],
                                ),
                        ),
                        const SizedBox(height: 28),

                        // ── Send to (payment account) ───────────────
                        Text('Send to', style: AppTextStyles.h3),
                        const SizedBox(height: 12),
                        if (account != null)
                          _AccountCard(account: account)
                        else
                          _NoAccountCard(),
                        const SizedBox(height: 28),

                        // ── Amount entry ────────────────────────────
                        Text('Enter amount', style: AppTextStyles.h3),
                        const SizedBox(height: 12),
                        AppTextField(
                          controller: _amountController,
                          label: 'Amount ($currency)',
                          hint: 'e.g. 5000',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          prefixIcon: const Icon(
                              Icons.monetization_on_outlined,
                              size: 20),
                          suffixIcon: TextButton(
                            onPressed: () {
                              _amountController.text =
                                  availableBalance.toString();
                              setState(() {});
                            },
                            child: const Text('MAX'),
                          ),
                          validator: (v) => Validators.withdrawalAmount(
                            v,
                            availableBalance: availableBalance,
                            min: AppConstants.minWithdrawalAmount,
                            max: AppConstants.maxWithdrawalAmount,
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Min: ${CurrencyFormatter.format(AppConstants.minWithdrawalAmount, currency)}  '
                          '·  Max: ${CurrencyFormatter.format(AppConstants.maxWithdrawalAmount, currency)}',
                          style: AppTextStyles.caption,
                        ),

                        // ── Fee breakdown ───────────────────────────
                        Builder(builder: (_) {
                          final raw = int.tryParse(
                              _amountController.text.replaceAll(',', '').trim()) ?? 0;
                          if (raw <= 0) return const SizedBox(height: 36);
                          final fee = (raw * 0.03).round();
                          final receives = raw - fee;
                          return Container(
                            margin: const EdgeInsets.only(top: 16, bottom: 20),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.primarySurface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                _FeeRow(label: 'Withdrawal amount', value: CurrencyFormatter.format(raw, currency)),
                                const SizedBox(height: 6),
                                _FeeRow(label: 'AfriPay fee (3%)', value: '− ${CurrencyFormatter.format(fee, currency)}', valueColor: AppColors.error),
                                const Divider(height: 16),
                                _FeeRow(label: 'You receive', value: CurrencyFormatter.format(receives, currency), bold: true, valueColor: AppColors.accent),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 16),

                        // ── Confirm button ──────────────────────────
                        BlocBuilder<WithdrawalBloc, WithdrawalState>(
                          builder: (context, withdrawState) => AppButton(
                            label: account != null
                                ? 'Confirm Withdrawal'
                                : 'Add Payment Account First',
                            onPressed: account != null &&
                                    availableBalance > 0
                                ? () => _submit(
                                      availableBalance: availableBalance,
                                      currency: currency,
                                      paymentAccountId: paymentAccountId,
                                    )
                                : account == null
                                    ? () => context
                                        .push(AppRoutes.editProfile)
                                    : null,
                            isLoading:
                                withdrawState is WithdrawalLoading,
                            variant: account != null
                                ? AppButtonVariant.primary
                                : AppButtonVariant.outline,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: Text(
                            '3% AfriPay processing fee applies',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showSuccessDialog(
      BuildContext context, WithdrawalSuccess state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.accentSurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded,
                  color: AppColors.accent, size: 36),
            ),
            const SizedBox(height: 16),
            Text('Withdrawal Requested!',
                style: AppTextStyles.h3, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              'Your withdrawal of ${CurrencyFormatter.format(state.withdrawal.amount, state.withdrawal.currency)} to ${state.withdrawal.paymentAccountId} is being processed.',
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Payout is instant via AfriPay.',
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.accent),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _AccountCard extends StatelessWidget {
  final dynamic account;
  const _AccountCard({required this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: AppColors.accent.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.accentSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.account_balance_wallet_outlined,
                size: 22, color: AppColors.accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.provider as String,
                  style: AppTextStyles.labelMedium,
                ),
                Text(
                  account.accountIdentifier as String,
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded,
              color: AppColors.accent, size: 22),
        ],
      ),
    );
  }
}

class _NoAccountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: AppColors.warning.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: AppColors.warning, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No payment account connected',
                  style: AppTextStyles.labelMedium
                      .copyWith(color: AppColors.warning),
                ),
                Text(
                  'Tap the button below to add one in Edit Profile.',
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeeRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  final Color? valueColor;

  const _FeeRow({
    required this.label,
    required this.value,
    this.bold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: bold
                ? AppTextStyles.labelMedium
                : AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
        Text(value,
            style: (bold ? AppTextStyles.labelMedium : AppTextStyles.bodySmall)
                .copyWith(color: valueColor)),
      ],
    );
  }
}
