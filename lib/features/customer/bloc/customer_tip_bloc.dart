import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_constants.dart';
import '../../payments/data/datasources/payment_remote_datasource.dart';
import '../../payments/data/services/afripay_service.dart';
import '../../profile/domain/entities/waiter_profile.dart';
import '../domain/customer_tip_repository.dart';

part 'customer_tip_event.dart';
part 'customer_tip_state.dart';

class CustomerTipBloc extends Bloc<CustomerTipEvent, CustomerTipState> {
  final CustomerTipRepository repository;

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
    on<OtpRequested>(_onOtpRequested);
    on<AfriPayCheckoutStarted>(_onCheckoutStarted);
    on<PaymentStatusPolled>(_onStatusPolled);
    on<PaymentCompleted>(_onPaymentCompleted);
    on<CustomerTipReset>(_onReset);
  }

  List<AfriPayMethodDto> _lastMethods = [];

  Future<void> _onProfileRequested(
    CustomerProfileRequested event,
    Emitter<CustomerTipState> emit,
  ) async {
    emit(const CustomerTipLoading());
    _waiterId = event.waiterId;
    final results = await Future.wait([
      repository.getWaiterPublicProfile(event.waiterId),
      repository.getPaymentMethods(AppConstants.defaultCurrency),
    ]);
    final profileResult = results[0] as dynamic;
    final methods = results[1] as List<AfriPayMethodDto>;
    profileResult.fold(
      (failure) => emit(CustomerTipError(failure.message)),
      (profile) {
        _profile = profile;
        _lastMethods = methods;
        emit(CustomerProfileLoaded(profile: profile, paymentMethods: methods));
      },
    );
  }

  void _onAmountSelected(
    TipAmountSelected event,
    Emitter<CustomerTipState> emit,
  ) {
    _tipAmount = event.amount;
    _currency = event.currency;
    if (_profile == null) return;
    final fee = repository.getFeeBreakdown(
      tipAmount: event.amount,
      currency: event.currency,
    ).fold((_) => null, (f) => f);
    final methods = state is CustomerProfileLoaded
        ? (state as CustomerProfileLoaded).paymentMethods
        : state is CustomerTipAmountSelected
            ? (state as CustomerTipAmountSelected).paymentMethods
            : <AfriPayMethodDto>[];
    if (methods.isNotEmpty) _lastMethods = methods;
    emit(CustomerTipAmountSelected(
      profile: _profile!,
      amount: event.amount,
      currency: event.currency,
      feeBreakdown: fee,
      paymentMethods: methods,
    ));
  }

  /// Requests OTP for methods that require it (e.g. LumiCash).
  Future<void> _onOtpRequested(
    OtpRequested event,
    Emitter<CustomerTipState> emit,
  ) async {
    if (_profile == null || _tipAmount == null) return;

    final result = await repository.requestOtp(
      phone: event.phone,
      paymentMethod: event.paymentMethod,
    );

    result.fold(
      (failure) => _emitError(emit, failure.message),
      (response) {
        if (response['status'] == 'error') {
          _emitError(emit, response['message'] as String? ?? 'OTP request failed.');
        } else {
          final fee = repository
              .getFeeBreakdown(
                tipAmount: _tipAmount!,
                currency: _currency ?? AppConstants.defaultCurrency,
              )
              .fold((_) => null, (f) => f);
          final feeBreakdown = fee ??
              AfriPayFeeDto(
                tipAmount: _tipAmount!,
                gatewayFee: AfriPayService.gatewayFee(_tipAmount!),
                platformFee: AfriPayService.platformFee(_tipAmount!),
                totalFee: AfriPayService.totalFee(_tipAmount!),
                customerPays: AfriPayService.customerPays(_tipAmount!),
                waiterReceives: AfriPayService.waiterReceives(_tipAmount!),
                currency: _currency ?? AppConstants.defaultCurrency,
              );
          emit(CustomerOtpSent(
            profile: _profile!,
            feeBreakdown: feeBreakdown,
            paymentMethods: _lastMethods,
            phone: event.phone,
            paymentMethod: event.paymentMethod,
          ));
        }
      },
    );
  }

  /// Inserts tip row → creates pending payment → calls AfriPay C2B API.
  Future<void> _onCheckoutStarted(
    AfriPayCheckoutStarted event,
    Emitter<CustomerTipState> emit,
  ) async {
    if (_profile == null || _tipAmount == null || _waiterId == null) return;
    final currency = _currency ?? AppConstants.defaultCurrency;

    emit(const CustomerTipLoading());

    final fee = repository
        .getFeeBreakdown(tipAmount: _tipAmount!, currency: currency)
        .fold((_) => null, (f) => f);
    final netAmount = fee?.waiterReceives ?? (_tipAmount! * 0.9).round();

    // 1. Insert pending tip
    final tipResult = await repository.insertTip(
      waiterId: _waiterId!,
      amount: netAmount,
      currency: currency,
      isAnonymous: true,
    );
    if (tipResult.isLeft()) {
      tipResult.fold(
        (f) => _emitError(emit, f.message),
        (_) {},
      );
      return;
    }
    final tip = tipResult.getOrElse(() => throw Exception());
    _tipId = tip.id;

    // 2. Create pending payment row in Supabase → get clientToken
    final checkoutResult = await repository.initiateAfriPayCheckout(
      tipId: tip.id,
      waiterId: _waiterId!,
      waiterName: _profile!.fullName.split(' ').first,
      tipAmount: _tipAmount!,
      currency: currency,
    );
    if (checkoutResult.isLeft()) {
      checkoutResult.fold(
        (f) => _emitError(emit, f.message),
        (_) {},
      );
      return;
    }
    final checkout = checkoutResult.getOrElse(() => throw Exception());
    _clientToken = checkout.clientToken;

    // 3. Call AfriPay C2B API directly — sends USSD push to customer's phone
    final c2bResult = await repository.sendC2BRequest(
      clientToken: checkout.clientToken,
      amount: _tipAmount!,
      currency: currency,
      paymentMethod: event.paymentMethod,
      phone: event.phone,
      waiterName: _profile!.fullName.split(' ').first,
      otp: event.otp,
    );

    c2bResult.fold(
      (failure) => _emitError(emit, failure.message),
      (response) {
        if (response['status'] == 'error') {
          _emitError(emit, response['message'] as String? ?? 'Payment failed. Try again.');
        } else {
          // status == 'success' → USSD push sent, waiting for customer to confirm
          emit(CustomerAwaitingPayment(
            tipId: tip.id,
            clientToken: checkout.clientToken,
            feeBreakdown: checkout.feeBreakdown,
            profile: _profile!,
          ));
        }
      },
    );
  }

  Future<void> _onStatusPolled(
    PaymentStatusPolled event,
    Emitter<CustomerTipState> emit,
  ) async {
    if (_clientToken == null || _profile == null || _tipId == null) return;
    final result = await repository.pollPaymentStatus(_clientToken!);
    result.fold(
      (_) {},
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
          case 'cancelled':
            _emitError(emit, 'Your payment was not completed. Please try again.');
            break;
          default:
            break;
        }
      },
    );
  }

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

  void _emitError(Emitter<CustomerTipState> emit, String message) {
    if (_profile == null || _tipAmount == null) {
      emit(CustomerTipError(message));
      return;
    }
    final fee = repository
        .getFeeBreakdown(
          tipAmount: _tipAmount!,
          currency: _currency ?? AppConstants.defaultCurrency,
        )
        .fold((_) => null, (f) => f);
    emit(CustomerTipAmountSelected(
      profile: _profile!,
      amount: _tipAmount!,
      currency: _currency ?? AppConstants.defaultCurrency,
      feeBreakdown: fee,
      paymentMethods: _lastMethods,
      errorMessage: message,
    ));
  }

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
