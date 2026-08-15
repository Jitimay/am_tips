part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
  @override
  List<Object?> get props => [];
}

/// Triggers fetching the available payment methods.
class PaymentMethodsRequested extends PaymentEvent {
  const PaymentMethodsRequested();
}

class PaymentInitiated extends PaymentEvent {
  final String tipId;
  final String methodId;
  final String idempotencyKey;
  const PaymentInitiated({
    required this.tipId,
    required this.methodId,
    required this.idempotencyKey,
  });
  @override
  List<Object?> get props => [tipId, methodId, idempotencyKey];
}

class PaymentStatusChecked extends PaymentEvent {
  final String paymentId;
  const PaymentStatusChecked(this.paymentId);
  @override
  List<Object?> get props => [paymentId];
}
