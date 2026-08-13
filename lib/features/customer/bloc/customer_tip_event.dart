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

class PaymentStarted extends CustomerTipEvent {
  final String methodId;
  const PaymentStarted(this.methodId);
  @override
  List<Object?> get props => [methodId];
}

class PaymentCompleted extends CustomerTipEvent {
  final int? rating;
  final String? message;
  const PaymentCompleted({this.rating, this.message});
  @override
  List<Object?> get props => [rating, message];
}

class PaymentStatusPolled extends CustomerTipEvent {
  const PaymentStatusPolled();
}
