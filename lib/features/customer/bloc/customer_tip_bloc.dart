import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_constants.dart';
import '../../payments/data/datasources/payment_remote_datasource.dart';
import '../../profile/domain/entities/waiter_profile.dart';
import '../../tips/domain/entities/tip.dart';
import '../domain/customer_tip_repository.dart';

part 'customer_tip_event.dart';
part 'customer_tip_state.dart';

class CustomerTipBloc extends Bloc<CustomerTipEvent, CustomerTipState> {
  final CustomerTipRepository repository;

  // In-flight state kept in the BLoC — not in the UI
  PublicWaiterProfile? _profile;
  String? _waiterId;
  int? _tipAmount;
  String? _currency;
  String? _tipId;
  String? _clientToken;

  CustomerTipBloc({required this.repository})
      : super(const CustomerTipInitial()) {
    on<CustomerProfileRequested>(_onProfileRequested);
    on<TipAmountSelected>(_onAmountSelected);
    on<AfriPayCheckoutStarted>(_onCheckoutStarted);
    on<PaymentStatusPolled>(_onStatusPolled);
    on<PaymentCompleted>(_onPaymentCompleted);
    on<CustomerTipReset>(_onReset);
  }

  // ── Profile ───────────────────────────────────────────────────────────────

  Future<void> _onProfileRequested(
    CustomerProfileRequested event,
    Emitter<CustomerTipState> emit,
  ) async {
    emit(const CustomerTipLoading());
    _waiterId = event.waiterId;

    final result = await repository.getWaiterPublicProfile(event.waiterId);
    result.fold(
      (failure) => emit(CustomerTipError(failure.message)),
      (profile) {
        _profile = profile;
        final methods = repository.getPaymentMethods();
        emit(CustomerProfileLoaded(
          profile: profile,
          paymentMethods: methods,
        ));
      },
    );
  }

  // ── Amount selected → compute fee immediately (local, no network) ─────────

  void _onAmountSelected(
    TipAmountSelected event,
    Emitter<CustomerTipState> emit,
  ) {
    _tipAmount = event.amount;
    _currency = event.currency;
    if (_profile == null) return;

    final feeResult = repository.getFeeBreakdown(
      tipAmount: event.amount,
      currency: event.currency,
    );
    final fee = feeResult.fold((_) => null, (f) => f);
    final methods = repository.getPaymentMethods();

    emit(CustomerTipAmountSelected(
      profile: _profile!,
      amount: event.amount,
      currency: event.currency,
      feeBreakdown: fee,
      paymentMethods: methods,
    ));
  }

  // ── Checkout: insert tip → open AfriPay browser ───────────────────────────

  Future<void> _onCheckoutStarted(
    AfriPayCheckoutStarted event,
    Emitter<CustomerTipState> emit,
  ) async {
    if (_profile == null || _tipAmount == null || _waiterId == null) return;
    final currency = _currency ?? AppConstants.defaultCurrency;

    emit(const CustomerTipLoading());

    // 1. Calculate net amount for waiter after 4% AfriPay + 6% amTips fee
    final feeResult = repository.getFeeBreakdown(
      tipAmount: _tipAmount!,
      currency: currency,
    );
    final fee = feeResult.fold((_) => null, (f) => f);
    final netAmount = fee?.waiterReceives ?? (_tipAmount! * 0.9).round();

    // Insert pending tip row in Supabase
    final tipResult = await repository.insertTip(
      waiterId: _waiterId!,
      amount: netAmount,
      currency: currency,
      isAnonymous: true,
    );

    final failureOrTip = tipResult.fold<_Either>((f) => _Left(f), (t) => _Right(t));
    if (failureOrTip is _Left) {
      emit(CustomerTipError((failureOrTip).failure.message));
      return;
    }
    final tip = (failureOrTip as _Right).tip;
    _tipId = tip.id;

    // 2. Launch AfriPay checkout (browser opens, user pays)
    final checkoutResult = await repository.initiateAfriPayCheckout(
      tipId: tip.id,
      waiterId: _waiterId!,
      waiterName: _profile!.fullName.split(' ').first,
      tipAmount: _tipAmount!,
      currency: currency,
    );

    checkoutResult.fold(
      (failure) => emit(CustomerTipError(failure.message)),
      (checkout) {
        _clientToken = checkout.clientToken;
        emit(CustomerAwaitingPayment(
          tipId: tip.id,
          clientToken: checkout.clientToken,
          feeBreakdown: checkout.feeBreakdown,
          profile: _profile!,
        ));
      },
    );
  }

  // ── Poll Supabase until AfriPay callback updates the payment row ──────────

  Future<void> _onStatusPolled(
    PaymentStatusPolled event,
    Emitter<CustomerTipState> emit,
  ) async {
    if (_clientToken == null || _profile == null || _tipId == null) return;

    final result = await repository.pollPaymentStatus(_clientToken!);
    result.fold(
      (_) {}, // network blip — keep polling
      (status) {
        switch (status) {
          case 'completed':
            emit(CustomerTipSuccess(
              tipId: _tipId!,
              tipAmount: _tipAmount ?? 0,
              currency: _currency ?? AppConstants.defaultCurrency,
              profile: _profile!,
              transactionRef: event.transactionRef,
            ));
            break;
          case 'failed':
            emit(const CustomerTipError(
                'Your payment was not completed. Please try again.'));
            break;
          default:
            // Still pending — do nothing, let timer continue
            break;
        }
      },
    );
  }

  // ── Submit optional feedback after success ────────────────────────────────

  Future<void> _onPaymentCompleted(
    PaymentCompleted event,
    Emitter<CustomerTipState> emit,
  ) async {
    if (_tipId == null) return;
    await repository.submitFeedback(
      tipId: _tipId!,
      rating: event.rating,
      message: event.message,
    );
  }

  // ── Reset for new tip flow ────────────────────────────────────────────────

  void _onReset(CustomerTipReset event, Emitter<CustomerTipState> emit) {
    _profile = null;
    _waiterId = null;
    _tipAmount = null;
    _currency = null;
    _tipId = null;
    _clientToken = null;
    emit(const CustomerTipInitial());
  }
}

// Simple local sum type to avoid nested fold
abstract class _Either {}
class _Left extends _Either {
  final dynamic failure;
  _Left(this.failure);
}
class _Right extends _Either {
  final Tip tip;
  _Right(this.tip);
}
