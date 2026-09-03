part of 'customer_tip_bloc.dart';

abstract class CustomerTipEvent extends Equatable {
  const CustomerTipEvent();
  @override
  List<Object?> get props => [];
}

class CustomerProfileRequested extends CustomerTipEvent {
  final String waiterId;
  const CustomerProfileRequested(this.waiterId);
  @override
  List<Object?> get props => [waiterId];
}

class TipAmountSelected extends CustomerTipEvent {
  final int amount;
  final String currency;
  const TipAmountSelected({required this.amount, required this.currency});
  @override
  List<Object?> get props => [amount, currency];
}

/// Fired when the customer taps "Pay" — inserts tip row then calls AfriPay API.
/// [phone] — customer's mobile money number.
/// [paymentMethod] — selected AfriPay method id.
/// [otp] — optional OTP for methods that require it.
class AfriPayCheckoutStarted extends CustomerTipEvent {
  final String phone;
  final String paymentMethod;
  final String? otp;
  const AfriPayCheckoutStarted({
    required this.phone,
    required this.paymentMethod,
    this.otp,
  });
  @override
  List<Object?> get props => [phone, paymentMethod, otp];
}

/// Fired when customer requests OTP before paying (e.g. LumiCash).
class OtpRequested extends CustomerTipEvent {
  final String phone;
  final String paymentMethod;
  const OtpRequested({required this.phone, required this.paymentMethod});
  @override
  List<Object?> get props => [phone, paymentMethod];
}

/// Fired periodically while polling for payment confirmation.
class PaymentStatusPolled extends CustomerTipEvent {
  final String? transactionRef;
  const PaymentStatusPolled({this.transactionRef});
  @override
  List<Object?> get props => [transactionRef];
}

/// Fired after success screen — submits optional rating + message.
class PaymentCompleted extends CustomerTipEvent {
  final int? rating;
  final String? message;
  const PaymentCompleted({this.rating, this.message});
  @override
  List<Object?> get props => [rating, message];
}

/// Resets the BLoC for a fresh tip flow.
class CustomerTipReset extends CustomerTipEvent {
  const CustomerTipReset();
}
