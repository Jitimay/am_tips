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
  const CustomerProfileLoaded({required this.profile, required this.paymentMethods});
  @override
  List<Object?> get props => [profile, paymentMethods];
}

class CustomerTipAmountSelected extends CustomerTipState {
  final PublicWaiterProfile profile;
  final int amount;
  final String currency;
  final AfriPayFeeDto? feeBreakdown;
  final List<AfriPayMethodDto> paymentMethods;
  final String? errorMessage;
  const CustomerTipAmountSelected({
    required this.profile,
    required this.amount,
    required this.currency,
    this.feeBreakdown,
    required this.paymentMethods,
    this.errorMessage,
  });
  @override
  List<Object?> get props => [profile, amount, currency, feeBreakdown, errorMessage];
}

/// OTP was sent to the customer's phone — waiting for them to enter it.
class CustomerOtpSent extends CustomerTipState {
  final PublicWaiterProfile profile;
  final AfriPayFeeDto feeBreakdown;
  final List<AfriPayMethodDto> paymentMethods;
  final String phone;
  final String paymentMethod;
  const CustomerOtpSent({
    required this.profile,
    required this.feeBreakdown,
    required this.paymentMethods,
    required this.phone,
    required this.paymentMethod,
  });
  @override
  List<Object?> get props => [phone, paymentMethod];
}

/// AfriPay C2B request sent — USSD push delivered, waiting for customer to confirm.
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
