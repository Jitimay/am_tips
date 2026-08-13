import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;

  PaymentBloc({required this.paymentRepository})
      : super(const PaymentInitial()) {
    on<PaymentMethodsLoaded>(_onMethodsLoaded);
    on<PaymentInitiated>(_onInitiated);
    on<PaymentStatusChecked>(_onStatusChecked);
  }

  Future<void> _onMethodsLoaded(
      PaymentMethodsLoaded event, Emitter<PaymentState> emit) async {
    emit(const PaymentLoading());
    final result = await paymentRepository.getPaymentMethods();
    result.fold(
      (failure) => emit(PaymentError(failure.message)),
      (methods) => emit(PaymentMethodsLoaded(methods)),
    );
  }

  Future<void> _onInitiated(
      PaymentInitiated event, Emitter<PaymentState> emit) async {
    emit(const PaymentLoading());
    final result = await paymentRepository.initiatePayment(
      tipId: event.tipId,
      methodId: event.methodId,
      idempotencyKey: event.idempotencyKey,
    );
    result.fold(
      (failure) => emit(PaymentError(failure.message)),
      (paymentResult) => emit(PaymentInProgress(paymentResult)),
    );
  }

  Future<void> _onStatusChecked(
      PaymentStatusChecked event, Emitter<PaymentState> emit) async {
    final result =
        await paymentRepository.checkPaymentStatus(event.paymentId);
    result.fold(
      (failure) => emit(PaymentError(failure.message)),
      (status) => emit(PaymentConfirmed(status)),
    );
  }
}
