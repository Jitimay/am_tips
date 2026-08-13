import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/withdrawal.dart';
import '../../domain/repositories/withdrawal_repository.dart';

part 'withdrawal_event.dart';
part 'withdrawal_state.dart';

class WithdrawalBloc extends Bloc<WithdrawalEvent, WithdrawalState> {
  final WithdrawalRepository withdrawalRepository;

  WithdrawalBloc({required this.withdrawalRepository})
      : super(const WithdrawalInitial()) {
    on<WithdrawalRequested>(_onRequested);
    on<WithdrawalsLoaded>(_onLoaded);
  }

  Future<void> _onRequested(
      WithdrawalRequested event, Emitter<WithdrawalState> emit) async {
    emit(const WithdrawalLoading());
    final result = await withdrawalRepository.requestWithdrawal(
      amount: event.amount,
      currency: event.currency,
      paymentAccountId: event.paymentAccountId,
    );
    result.fold(
      (failure) => emit(WithdrawalError(failure.message)),
      (withdrawal) => emit(WithdrawalSuccess(withdrawal)),
    );
  }

  Future<void> _onLoaded(
      WithdrawalsLoaded event, Emitter<WithdrawalState> emit) async {
    emit(const WithdrawalLoading());
    final result = await withdrawalRepository.getWithdrawals();
    result.fold(
      (failure) => emit(WithdrawalError(failure.message)),
      (list) => emit(WithdrawalsLoaded(list)),
    );
  }
}
