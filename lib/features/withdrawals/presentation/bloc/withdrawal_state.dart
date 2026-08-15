part of 'withdrawal_bloc.dart';

abstract class WithdrawalState extends Equatable {
  const WithdrawalState();
  @override
  List<Object?> get props => [];
}

class WithdrawalInitial extends WithdrawalState {
  const WithdrawalInitial();
}

class WithdrawalLoading extends WithdrawalState {
  const WithdrawalLoading();
}

class WithdrawalSuccess extends WithdrawalState {
  final Withdrawal withdrawal;
  const WithdrawalSuccess(this.withdrawal);
  @override
  List<Object?> get props => [withdrawal];
}

class WithdrawalHistoryLoaded extends WithdrawalState {
  final List<Withdrawal> withdrawals;
  const WithdrawalHistoryLoaded(this.withdrawals);
  @override
  List<Object?> get props => [withdrawals];
}

class WithdrawalError extends WithdrawalState {
  final String message;
  const WithdrawalError(this.message);
  @override
  List<Object?> get props => [message];
}
