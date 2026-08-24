part of 'customer_tip_bloc.dart';

abstract class CustomerTipState extends Equatable {
  const CustomerTipState();
  @override
  List<Object?> get props => [];
}

class CustomerTipInitial extends CustomerTipState {
  const CustomerTipInitial();
}

class CustomerTipLoading extends CustomerTipState {
  const CustomerTipLoading();
}

class CustomerProfileLoaded extends CustomerTipState {
  final PublicWaiterProfile profile;
  final List<AfriPayMethodDto> paymentMethods;
  const CustomerProfileLoaded({
    required this.profile,
    required this.paymentMethods,
  });
  @override
  List<Object?> get props => [profile, paymentMethods];
}

class CustomerTipAmountSelected extends CustomerTipState {
  final PublicWaiterProfile profile;
  final int amount;
  final String currency;
  final AfriPayFeeDto? feeBreakdown;
  final List<AfriPayMethodDto> paymentMethods;
  const CustomerTipAmountSelected({
    required this.profile,
    required this.amount,
    required this.currency,
    this.feeBreakdown,
    required this.paymentMethods,
  });
  @override
  List<Object?> get props => [profile, amount, currency, feeBreakdown];
}

/// AfriPay checkout has been launched in the browser.
/// App is now waiting for the callback to update Supabase.
class CustomerAwaitingPayment extends CustomerTipState {
  final String tipId;
  final String clientToken;
  final AfriPayFeeDto feeBreakdown;
  final PublicWaiterProfile profile;
  const CustomerAwaitingPayment({
    required this.tipId,
    required this.clientToken,
    required this.feeBreakdown,
    required this.profile,
  });
  @override
  List<Object?> get props => [tipId, clientToken];
}

/// AfriPay confirmed payment — tip is completed.
class CustomerTipSuccess extends CustomerTipState {
  final String tipId;
  final int tipAmount;
  final String currency;
  final PublicWaiterProfile profile;
  final String? transactionRef;
  const CustomerTipSuccess({
    required this.tipId,
    required this.tipAmount,
    required this.currency,
    required this.profile,
    this.transactionRef,
  });
  @override
  List<Object?> get props => [tipId, tipAmount, currency];
}

class CustomerTipError extends CustomerTipState {
  final String message;
  const CustomerTipError(this.message);
  @override
  List<Object?> get props => [message];
}
