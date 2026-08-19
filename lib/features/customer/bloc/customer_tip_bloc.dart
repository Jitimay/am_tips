import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_constants.dart';
import '../../payments/domain/entities/payment.dart';
import '../../profile/domain/entities/waiter_profile.dart';
import '../../tips/domain/entities/tip.dart';
import '../domain/customer_tip_repository.dart';

part 'customer_tip_event.dart';
part 'customer_tip_state.dart';

class CustomerTipBloc extends Bloc<CustomerTipEvent, CustomerTipState> {
  final CustomerTipRepository repository;
  final _uuid = const Uuid();

  // Hold in-flight state
  PublicWaiterProfile? _profile;
  String? _waiterId;
  int? _amount;
  String? _currency;
  String? _tipId;
  Tip? _currentTip;

  CustomerTipBloc({required this.repository})
      : super(const CustomerTipInitial()) {
    on<CustomerProfileRequested>(_onProfileRequested);
    on<TipAmountSelected>(_onAmountSelected);
    on<PaymentStarted>(_onPaymentStarted);
    on<PaymentCompleted>(_onPaymentCompleted);
    on<PaymentStatusPolled>(_onStatusPolled);
  }

  Future<void> _onProfileRequested(
      CustomerProfileRequested event,
      Emitter<CustomerTipState> emit) async {
    emit(const CustomerTipLoading());
    _waiterId = event.waiterId;

    final profileResult =
        await repository.getWaiterPublicProfile(event.waiterId);
    final methodsResult = await repository.getPaymentMethods();

    profileResult.fold(
      (failure) => emit(CustomerTipError(failure.message)),
      (profile) {
        _profile = profile;
        final methods =
            methodsResult.fold((_) => <PaymentMethod>[], (m) => m);
        emit(CustomerProfileLoaded(
          profile: profile,
          paymentMethods: methods,
        ));
      },
    );
  }

  Future<void> _onAmountSelected(
      TipAmountSelected event, Emitter<CustomerTipState> emit) async {
    _amount = event.amount;
    _currency = event.currency;
    if (_profile == null || _waiterId == null) return;

    // Fetch fee breakdown without blocking UX
    final feeResult = await repository.getFeeBreakdown(
      waiterId: _waiterId!,
      amount: event.amount,
      currency: event.currency,
    );
    final fee = feeResult.fold((_) => null, (f) => f);
    final methods =
        state is CustomerProfileLoaded
            ? (state as CustomerProfileLoaded).paymentMethods
            : state is CustomerTipAmountSelected
                ? (state as CustomerTipAmountSelected).paymentMethods
                : <PaymentMethod>[];

    emit(CustomerTipAmountSelected(
      profile: _profile!,
      amount: event.amount,
      currency: event.currency,
      feeBreakdown: fee,
      paymentMethods: methods,
    ));
  }

  Future<void> _onPaymentStarted(
      PaymentStarted event, Emitter<CustomerTipState> emit) async {
    if (_profile == null || _amount == null || _waiterId == null) return;
    final currency = _currency ?? AppConstants.defaultCurrency;

    emit(const CustomerTipLoading());

    // 1. Create tip
    final idempotencyKey = _uuid.v4();
    final tipResult = await repository.initiateTip(
      waiterId: _waiterId!,
      amount: _amount!,
      currency: currency,
      isAnonymous: true,
      idempotencyKey: idempotencyKey,
    );

    await tipResult.fold(
      (failure) async => emit(CustomerTipError(failure.message)),
      (tip) async {
        _tipId = tip.id;
        _currentTip = tip;
        final paymentKey = _uuid.v4();
        final paymentResult = await repository.initiatePayment(
          tipId: tip.id,
          methodId: event.methodId,
          idempotencyKey: paymentKey,
        );

        paymentResult.fold(
          (failure) => emit(CustomerTipError(failure.message)),
          (_) => emit(CustomerPaymentProcessing(tip.id)),
        );
      },
    );
  }

  Future<void> _onStatusPolled(
      PaymentStatusPolled event,
      Emitter<CustomerTipState> emit) async {
    if (_tipId == null || _profile == null) return;

    final result = await repository.checkTipStatus(_tipId!);
    result.fold(
      (_) {},
      (status) async {
        if (status == TipStatus.completed) {
          final completedTip = (_currentTip ??
                  Tip(
                    id: _tipId!,
                    waiterId: _waiterId!,
                    amount: _amount ?? 0,
                    currency: _currency ?? AppConstants.defaultCurrency,
                    status: TipStatus.completed,
                    createdAt: DateTime.now(),
                  ))
              .copyWith(status: TipStatus.completed);
          emit(CustomerTipSuccess(tip: completedTip, profile: _profile!));
        } else if (status == TipStatus.failed ||
            status == TipStatus.cancelled) {
          emit(const CustomerTipError(
              'Payment was not completed. Please try again.'));
        }
      },
    );
  }

  Future<void> _onPaymentCompleted(
      PaymentCompleted event,
      Emitter<CustomerTipState> emit) async {
    if (_tipId != null) {
      await repository.submitFeedback(
        tipId: _tipId!,
        rating: event.rating,
        message: event.message,
      );
    }
  }
}
