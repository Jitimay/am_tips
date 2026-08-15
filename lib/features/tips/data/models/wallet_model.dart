import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/wallet.dart';

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

@freezed
abstract class WalletModel with _$WalletModel {
  const factory WalletModel({
    @JsonKey(name: 'waiter_id') required String waiterId,
    @JsonKey(name: 'available_balance') required int availableBalance,
    @JsonKey(name: 'pending_balance') @Default(0) int pendingBalance,
    required String currency,
    @JsonKey(name: 'last_updated_at') DateTime? lastUpdatedAt,
  }) = _WalletModel;

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);
}

@freezed
abstract class WalletTransactionModel with _$WalletTransactionModel {
  const factory WalletTransactionModel({
    required String id,
    required String type,
    required int amount,
    required String currency,
    @JsonKey(name: 'is_credit') required bool isCredit,
    String? reference,
    String? description,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _WalletTransactionModel;

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionModelFromJson(json);
}

extension WalletModelX on WalletModel {
  Wallet toDomain() => Wallet(
        waiterId: waiterId,
        availableBalance: availableBalance,
        pendingBalance: pendingBalance,
        currency: currency,
        lastUpdatedAt: lastUpdatedAt,
      );
}

extension WalletTransactionModelX on WalletTransactionModel {
  WalletTransaction toDomain() => WalletTransaction(
        id: id,
        type: _parseType(type),
        amount: amount,
        currency: currency,
        isCredit: isCredit,
        reference: reference,
        description: description,
        createdAt: createdAt,
      );

  static TransactionType _parseType(String t) {
    return TransactionType.values.firstWhere(
      (e) => e.name == _toCamel(t),
      orElse: () => TransactionType.adjustment,
    );
  }

  static String _toCamel(String s) {
    final parts = s.toLowerCase().split('_');
    if (parts.isEmpty) return s;
    return parts[0] +
        parts
            .skip(1)
            .map((p) => p[0].toUpperCase() + p.substring(1))
            .join('');
  }
}
