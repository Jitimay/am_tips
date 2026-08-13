import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
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
  int _availableBalance = 0;
  String _currency = AppConstants.defaultCurrency;
  String? _paymentAccountId;

  @override
  void initState() {
    super.initState();
    final walletState = context.read<WalletCubit>().state;
    if (walletState is WalletLoaded) {
      _availableBalance = walletState.wallet.availableBalance;
      _currency = walletState.wallet.currency;
    }
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoaded &&
        profileState.profile.connectedPaymentAccount != null) {
      _paymentAccountId =
          profileState.profile.connectedPaymentAccount!.id;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _setMax() {
    _amountController.text = _availableBalance.toString();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_paymentAccountId == null) {
      SnackBarUtils.showError(context,
          'No payment account connected. Please add one in your profile.');
      return;
    }
    final amount = int.parse(
        _amountController.text.replaceAll(',', '').trim());
    context.read<WithdrawalBloc>().add(WithdrawalRequested(
          amount: amount,
          currency: _currency,
          paymentAccountId: _paymentAccountId!,
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Balance info
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: AppColors.walletGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available',
                        style: AppTextStyles.labelSmall
                            .copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        CurrencyFormatter.format(
                            _availableBalance, _currency),
                        style: AppTextStyles.amountMedium
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Text('Enter amount', style: AppTextStyles.h3),
                const SizedBox(height: 12),
                AppTextField(
                  controller: _amountController,
                  label: 'Amount',
                  hint: 'e.g. 5000',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  prefixIcon: const Icon(Icons.monetization_on_outlined,
                      size: 20),
                  suffixIcon: TextButton(
                    onPressed: _setMax,
                    child: const Text('MAX'),
                  ),
                  validator: (v) => Validators.withdrawalAmount(
                    v,
                    availableBalance: _availableBalance,
                    min: AppConstants.minWithdrawalAmount,
                    max: AppConstants.maxWithdrawalAmount,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Min: ${CurrencyFormatter.format(AppConstants.minWithdrawalAmount, _currency)}',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: 28),

                // Payment account
                Text('Send to', style: AppTextStyles.h3),
                const SizedBox(height: 12),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoaded &&
                        state.profile.connectedPaymentAccount != null) {
                      final acct =
                          state.profile.connectedPaymentAccount!;
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.4),
                              width: 1.5),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.primary
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                  Icons.account_balance_wallet_outlined,
                                  size: 20,
                                  color: AppColors.primary),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(acct.provider,
                                      style: AppTextStyles.labelMedium),
                                  Text(acct.accountIdentifier,
                                      style: AppTextStyles.bodySmall),
                                ],
                              ),
                            ),
                            const Icon(Icons.check_circle_rounded,
                                color: AppColors.accent, size: 20),
                          ],
                        ),
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'No payment account connected. Add one in your profile.',
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.warning),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 36),

                BlocBuilder<WithdrawalBloc, WithdrawalState>(
                  builder: (context, state) => AppButton(
                    label: 'Confirm Withdrawal',
                    onPressed: _submit,
                    isLoading: state is WithdrawalLoading,
                  ),
                ),
              ],
            ),
          ),
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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_rounded,
                color: AppColors.accent, size: 56),
            const SizedBox(height: 16),
            Text('Withdrawal Requested!',
                style: AppTextStyles.h3, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              'Your withdrawal of ${CurrencyFormatter.format(state.withdrawal.amount, state.withdrawal.currency)} is being processed.',
              style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary),
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
