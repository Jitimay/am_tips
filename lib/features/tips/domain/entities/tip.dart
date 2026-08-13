import 'package:freezed_annotation/freezed_annotation.dart';

part 'tip.freezed.dart';
part 'tip.g.dart';

enum TipStatus { pending, processing, completed, failed, refunded, cancelled }

@freezed
class Tip with _$Tip {
  const factory Tip({
    required String id,
    required String waiterId,
    required int amount,
    required String currency,
    required TipStatus status,
    String? message,
    int? rating,
    String? transactionReference,
    String? paymentProvider,
    @Default(false) bool isAnonymous,
    String? customerName,     // null if anonymous
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Tip;

  factory Tip.fromJson(Map<String, dynamic> json) => _$TipFromJson(json);
}

@freezed
class TipStats with _$TipStats {
  const factory TipStats({
    required int todayTotal,
    required int weekTotal,
    required int allTimeTotal,
    required String currency,
    required int todayCount,
    required int weekCount,
    required int allTimeCount,
  }) = _TipStats;

  factory TipStats.fromJson(Map<String, dynamic> json) =>
      _$TipStatsFromJson(json);
}
