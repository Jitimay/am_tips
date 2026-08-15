import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/withdrawal.dart';

part 'withdrawal_model.freezed.dart';
part 'withdrawal_model.g.dart';

@freezed
abstract class WithdrawalModel with _$WithdrawalModel {
  const factory WithdrawalModel({
    required String id,
    @JsonKey(name: 'waiter_id') required String waiterId,
    required int amount,
    required String currency,
    required String status,
    @JsonKey(name: 'payment_account_id') required String paymentAccountId,
    @JsonKey(name: 'provider_reference') String? providerReference,
    @JsonKey(name: 'failure_reason') String? failureReason,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _WithdrawalModel;

  factory WithdrawalModel.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalModelFromJson(json);
}

extension WithdrawalModelX on WithdrawalModel {
  Withdrawal toDomain() => Withdrawal(
        id: id,
        waiterId: waiterId,
        amount: amount,
        currency: currency,
        status: _parseStatus(status),
        paymentAccountId: paymentAccountId,
        providerReference: providerReference,
        failureReason: failureReason,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  static WithdrawalStatus _parseStatus(String s) {
    return WithdrawalStatus.values.firstWhere(
      (e) => e.name == s.toLowerCase(),
      orElse: () => WithdrawalStatus.requested,
    );
  }
}
