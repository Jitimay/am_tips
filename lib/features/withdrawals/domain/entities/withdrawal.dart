import 'package:freezed_annotation/freezed_annotation.dart';

part 'withdrawal.freezed.dart';
part 'withdrawal.g.dart';

enum WithdrawalStatus { requested, processing, completed, failed }

@freezed
class Withdrawal with _$Withdrawal {
  const factory Withdrawal({
    required String id,
    required String waiterId,
    required int amount,
    required String currency,
    required WithdrawalStatus status,
    required String paymentAccountId,
    String? providerReference,
    String? failureReason,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Withdrawal;

  factory Withdrawal.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalFromJson(json);
}
