/// DTO for an AfriPay payment method.
class AfriPayMethodDto {
  final String id;
  final String name;
  final String provider;
  final String type;
  final String description;
  final bool isAvailable;
  final String emoji;
  final bool requiresOtp;
  final String? iconUrl;

  const AfriPayMethodDto({
    required this.id,
    required this.name,
    required this.provider,
    required this.type,
    required this.description,
    required this.isAvailable,
    required this.emoji,
    this.requiresOtp = false,
    this.iconUrl,
  });
}
