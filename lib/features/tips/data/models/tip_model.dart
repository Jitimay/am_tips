import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/tip.dart';

part 'tip_model.freezed.dart';
part 'tip_model.g.dart';

@freezed
class TipModel with _$TipModel {
  const factory TipModel({
    required String id,
    @JsonKey(name: 'waiter_id') required String waiterId,
    required int amount,
    required String currency,
    required String status,
    String? message,
    int? rating,
    @JsonKey(name: 'transaction_reference') String? transactionReference,
    @JsonKey(name: 'payment_provider') String? paymentProvider,
    @JsonKey(name: 'is_anonymous') @Default(false) bool isAnonymous,
    @JsonKey(name: 'customer_name') String? customerName,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _TipModel;

  factory TipModel.fromJson(Map<String, dynamic> json) =>
      _$TipModelFromJson(json);
}

@freezed
class TipStatsModel with _$TipStatsModel {
  const factory TipStatsModel({
    @JsonKey(name: 'today_total') required int todayTotal,
    @JsonKey(name: 'week_total') required int weekTotal,
    @JsonKey(name: 'all_time_total') required int allTimeTotal,
    required String currency,
    @JsonKey(name: 'today_count') required int todayCount,
    @JsonKey(name: 'week_count') required int weekCount,
    @JsonKey(name: 'all_time_count') required int allTimeCount,
  }) = _TipStatsModel;

  factory TipStatsModel.fromJson(Map<String, dynamic> json) =>
      _$TipStatsModelFromJson(json);
}

extension TipModelX on TipModel {
  Tip toDomain() => Tip(
        id: id,
        waiterId: waiterId,
        amount: amount,
        currency: currency,
        status: _parseStatus(status),
        message: message,
        rating: rating,
        transactionReference: transactionReference,
        paymentProvider: paymentProvider,
        isAnonymous: isAnonymous,
        customerName: customerName,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  static TipStatus _parseStatus(String s) {
    return TipStatus.values.firstWhere(
      (e) => e.name == s.toLowerCase(),
      orElse: () => TipStatus.pending,
    );
  }
}

extension TipStatsModelX on TipStatsModel {
  TipStats toDomain() => TipStats(
        todayTotal: todayTotal,
        weekTotal: weekTotal,
        allTimeTotal: allTimeTotal,
        currency: currency,
        todayCount: todayCount,
        weekCount: weekCount,
        allTimeCount: allTimeCount,
      );
}
