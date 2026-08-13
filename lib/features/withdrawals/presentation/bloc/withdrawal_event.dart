part of 'withdrawal_bloc.dart';

abstract class WithdrawalEvent extends Equatable {
  const WithdrawalEvent();
  @override
  List<Object?> get props => [];
}

class WithdrawalRequested extends WithdrawalEvent {
  final int amount;
  final String currency;
  final String paymentAccountId;
  const WithdrawalRequested({
    required this.amount,
    required this.currency,
    required this.paymentAccountId,
  });
  @override
  List<Object?> get props => [amount, currency, paymentAccountId];
}

class WithdrawalsLoaded extends WithdrawalEvent {
  const WithdrawalsLoaded();
}
