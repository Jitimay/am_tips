import '../../domain/entities/campaign.dart';

class CampaignModel {
  final String id;
  final String waiterId;
  final String title;
  final String category;
  final String description;
  final int? targetAmount;
  final int currentAmount;
  final int tipsCount;
  final String currency;
  final String emoji;
  final bool isActive;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CampaignModel({
    required this.id,
    required this.waiterId,
    required this.title,
    required this.category,
    required this.description,
    this.targetAmount,
    this.currentAmount = 0,
    this.tipsCount = 0,
    this.currency = 'BIF',
    this.emoji = '🎉',
    this.isActive = true,
    required this.startDate,
    this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'] as String? ?? '',
      waiterId: json['waiter_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? 'other',
      description: json['description'] as String? ?? '',
      targetAmount: (json['target_amount'] as num?)?.toInt(),
      currentAmount: (json['current_amount'] as num?)?.toInt() ?? 0,
      tipsCount: (json['tips_count'] as num?)?.toInt() ?? 0,
      currency: json['currency'] as String? ?? 'BIF',
      emoji: json['emoji'] as String? ?? '🎉',
      isActive: json['is_active'] as bool? ?? true,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'] as String)
          : DateTime.now(),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'] as String)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'waiter_id': waiterId,
      'title': title,
      'category': category,
      'description': description,
      'target_amount': targetAmount,
      'current_amount': currentAmount,
      'tips_count': tipsCount,
      'currency': currency,
      'emoji': emoji,
      'is_active': isActive,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Campaign toDomain() {
    return Campaign(
      id: id,
      waiterId: waiterId,
      title: title,
      category: CampaignCategory.fromString(category),
      description: description,
      targetAmount: targetAmount,
      currentAmount: currentAmount,
      tipsCount: tipsCount,
      currency: currency,
      emoji: emoji,
      isActive: isActive,
      startDate: startDate,
      endDate: endDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory CampaignModel.fromDomain(Campaign entity) {
    return CampaignModel(
      id: entity.id,
      waiterId: entity.waiterId,
      title: entity.title,
      category: entity.category.name,
      description: entity.description,
      targetAmount: entity.targetAmount,
      currentAmount: entity.currentAmount,
      tipsCount: entity.tipsCount,
      currency: entity.currency,
      emoji: entity.emoji,
      isActive: entity.isActive,
      startDate: entity.startDate,
      endDate: entity.endDate,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
