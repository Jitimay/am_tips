part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentMethodsLoaded extends PaymentState {
  final List<PaymentMethod> methods;
  const PaymentMethodsLoaded(this.methods);
  @override
  List<Object?> get props => [methods];
}

class PaymentInProgress extends PaymentState {
  final PaymentResult result;
  const PaymentInProgress(this.result);
  @override
  List<Object?> get props => [result];
}

class PaymentConfirmed extends PaymentState {
  final PaymentStatus status;
  const PaymentConfirmed(this.status);
  @override
  List<Object?> get props => [status];
}

class PaymentError extends PaymentState {
  final String message;
  const PaymentError(this.message);
  @override
  List<Object?> get props => [message];
}
