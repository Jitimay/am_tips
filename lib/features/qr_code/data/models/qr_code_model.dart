import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/qr_code.dart';

part 'qr_code_model.freezed.dart';
part 'qr_code_model.g.dart';

@freezed
class QrCodeModel with _$QrCodeModel {
  const factory QrCodeModel({
    @JsonKey(name: 'waiter_id') required String waiterId,
    required String token,
    required String url,
    @JsonKey(name: 'generated_at') required DateTime generatedAt,
    @JsonKey(name: 'last_used_at') DateTime? lastUsedAt,
  }) = _QrCodeModel;

  factory QrCodeModel.fromJson(Map<String, dynamic> json) =>
      _$QrCodeModelFromJson(json);
}

extension QrCodeModelX on QrCodeModel {
  QrCode toDomain() => QrCode(
        waiterId: waiterId,
        token: token,
        url: url,
        generatedAt: generatedAt,
        lastUsedAt: lastUsedAt,
      );
}
