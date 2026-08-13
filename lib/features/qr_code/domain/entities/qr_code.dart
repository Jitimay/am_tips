import 'package:freezed_annotation/freezed_annotation.dart';

part 'qr_code.freezed.dart';
part 'qr_code.g.dart';

@freezed
class QrCode with _$QrCode {
  const factory QrCode({
    required String waiterId,
    required String token,
    required String url,
    required DateTime generatedAt,
    DateTime? lastUsedAt,
  }) = _QrCode;

  factory QrCode.fromJson(Map<String, dynamic> json) =>
      _$QrCodeFromJson(json);
}
