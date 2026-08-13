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
  final List<PaymentMethod> paymentMethods;
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
  final TipFeeBreakdown? feeBreakdown;
  final List<PaymentMethod> paymentMethods;
  const CustomerTipAmountSelected({
    required this.profile,
    required this.amount,
    required this.currency,
    this.feeBreakdown,
    required this.paymentMethods,
  });
  @override
  List<Object?> get props =>
      [profile, amount, currency, feeBreakdown, paymentMethods];
}

class CustomerPaymentProcessing extends CustomerTipState {
  final String tipId;
  const CustomerPaymentProcessing(this.tipId);
  @override
  List<Object?> get props => [tipId];
}

class CustomerTipSuccess extends CustomerTipState {
  final Tip tip;
  final PublicWaiterProfile profile;
  const CustomerTipSuccess({required this.tip, required this.profile});
  @override
  List<Object?> get props => [tip, profile];
}

class CustomerTipError extends CustomerTipState {
  final String message;
  const CustomerTipError(this.message);
  @override
  List<Object?> get props => [message];
}
