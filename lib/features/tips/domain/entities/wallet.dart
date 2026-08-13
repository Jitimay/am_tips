import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet.freezed.dart';
part 'wallet.g.dart';

enum TransactionType { tipReceived, withdrawal, refund, adjustment }

@freezed
class Wallet with _$Wallet {
  const factory Wallet({
    required String waiterId,
    required int availableBalance,
    required int pendingBalance,
    required String currency,
    DateTime? lastUpdatedAt,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) =>
      _$WalletFromJson(json);
}

@freezed
class WalletTransaction with _$WalletTransaction {
  const factory WalletTransaction({
    required String id,
    required TransactionType type,
    required int amount,
    required String currency,
    required bool isCredit,
    String? reference,
    String? description,
    required DateTime createdAt,
  }) = _WalletTransaction;

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionFromJson(json);
}
