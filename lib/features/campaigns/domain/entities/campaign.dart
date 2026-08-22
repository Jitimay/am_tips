import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';

/// Preset occasion categories for tipping campaigns.
enum CampaignCategory {
  anniversary,
  christmas,
  birthday,
  wedding,
  graduation,
  holiday,
  project,
  other;

  String get label {
    switch (this) {
      case CampaignCategory.anniversary:
        return 'Anniversary';
      case CampaignCategory.christmas:
        return 'Christmas & Holiday';
      case CampaignCategory.birthday:
        return 'Birthday';
      case CampaignCategory.wedding:
        return 'Wedding / Celebration';
      case CampaignCategory.graduation:
        return 'Graduation / Milestone';
      case CampaignCategory.holiday:
        return 'Holiday Tip Jar';
      case CampaignCategory.project:
        return 'Goal / Project';
      case CampaignCategory.other:
        return 'Special Occasion';
    }
  }

  String get defaultEmoji {
    switch (this) {
      case CampaignCategory.anniversary:
        return '🎉';
      case CampaignCategory.christmas:
        return '🎄';
      case CampaignCategory.birthday:
        return '🎂';
      case CampaignCategory.wedding:
        return '💍';
      case CampaignCategory.graduation:
        return '🎓';
      case CampaignCategory.holiday:
        return '🎁';
      case CampaignCategory.project:
        return '🚀';
      case CampaignCategory.other:
        return '⭐';
    }
  }

  String get defaultTitle {
    switch (this) {
      case CampaignCategory.anniversary:
        return 'My Work Anniversary Tip Jar 🎉';
      case CampaignCategory.christmas:
        return 'Christmas Holiday Tip Jar 🎄';
      case CampaignCategory.birthday:
        return 'Birthday Celebration Tip Jar 🎂';
      case CampaignCategory.wedding:
        return 'Wedding Celebration Fund 💍';
      case CampaignCategory.graduation:
        return 'Graduation Achievement Jar 🎓';
      case CampaignCategory.holiday:
        return 'Holiday Season Tip Jar 🎁';
      case CampaignCategory.project:
        return 'Equipment & Growth Goal 🚀';
      case CampaignCategory.other:
        return 'Special Occasion Tip Jar ⭐';
    }
  }

  String get defaultDescription {
    switch (this) {
      case CampaignCategory.anniversary:
        return 'Celebrating another year of delivering great service! Any tip is deeply appreciated.';
      case CampaignCategory.christmas:
        return 'Wishing you joyful holidays! If you enjoyed my service this season, feel free to leave a holiday tip.';
      case CampaignCategory.birthday:
        return 'Celebrating my birthday today! Thank you for sharing the celebration and for your kind generosity.';
      case CampaignCategory.wedding:
        return 'Celebrating a joyful milestone! Thank you for your love and warm wishes.';
      case CampaignCategory.graduation:
        return 'Celebrating graduation and a new milestone! Thank you for supporting my journey.';
      case CampaignCategory.holiday:
        return 'Spreading festive vibes! Thank you for making this season extra special with your tips.';
      case CampaignCategory.project:
        return 'Working towards an important goal. Every tip brings me one step closer. Thank you!';
      case CampaignCategory.other:
        return 'Thank you for your generous tip and continuous support!';
    }
  }

  List<Color> get gradientColors {
    switch (this) {
      case CampaignCategory.anniversary:
        return const [Color(0xFFE65100), Color(0xFFFFB300)];
      case CampaignCategory.christmas:
        return const [Color(0xFFB71C1C), Color(0xFF2E7D32)];
      case CampaignCategory.birthday:
        return const [Color(0xFF880E4F), Color(0xFFE91E63)];
      case CampaignCategory.wedding:
        return const [Color(0xFF4A148C), Color(0xFFAB47BC)];
      case CampaignCategory.graduation:
        return const [Color(0xFF0D47A1), Color(0xFF1E88E5)];
      case CampaignCategory.holiday:
        return const [Color(0xFF004D40), Color(0xFF00897B)];
      case CampaignCategory.project:
        return const [Color(0xFF311B92), Color(0xFF5E35B1)];
      case CampaignCategory.other:
        return const [AppColors.primaryDark, AppColors.primary];
    }
  }

  static CampaignCategory fromString(String? val) {
    if (val == null) return CampaignCategory.other;
    return CampaignCategory.values.firstWhere(
      (c) => c.name.toLowerCase() == val.toLowerCase(),
      orElse: () => CampaignCategory.other,
    );
  }
}

/// Represents a special tip campaign created by a service worker / creator.
class Campaign extends Equatable {
  final String id;
  final String waiterId;
  final String title;
  final CampaignCategory category;
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

  const Campaign({
    required this.id,
    required this.waiterId,
    required this.title,
    required this.category,
    required this.description,
    this.targetAmount,
    this.currentAmount = 0,
    this.tipsCount = 0,
    this.currency = AppConstants.defaultCurrency,
    String? emoji,
    this.isActive = true,
    required this.startDate,
    this.endDate,
    required this.createdAt,
    required this.updatedAt,
  }) : emoji = emoji ?? '🎉';

  /// Ratio from 0.0 to 1.0 of progress towards target amount.
  double get progress {
    if (targetAmount == null || targetAmount! <= 0) return 0.0;
    return (currentAmount / targetAmount!).clamp(0.0, 1.0);
  }

  /// Percentage value integer (0 - 100+).
  int get progressPercentage {
    if (targetAmount == null || targetAmount! <= 0) return 0;
    return ((currentAmount / targetAmount!) * 100).round();
  }

  /// True if target goal is set and reached.
  bool get isGoalReached => targetAmount != null && currentAmount >= targetAmount!;

  /// Formatted target string (e.g. "100,000 BIF").
  String? get formattedTarget =>
      targetAmount != null ? CurrencyFormatter.format(targetAmount!, currency) : null;

  /// Formatted current raised amount (e.g. "45,000 BIF").
  String get formattedRaised =>
      CurrencyFormatter.format(currentAmount, currency);

  /// Number of days remaining if an end date is configured.
  int? get daysRemaining {
    if (endDate == null) return null;
    final diff = endDate!.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }

  /// Direct URL to the customer tip page for this campaign.
  String get tipUrl => '${AppConstants.tipBaseUrl}/$waiterId?c=$id';

  /// Generates the standard WhatsApp / social share text for this campaign.
  String getShareText({required String waiterName}) {
    final buffer = StringBuffer();
    buffer.writeln('$emoji *$title*');
    buffer.writeln();
    if (description.isNotEmpty) {
      buffer.writeln('"$description"');
      buffer.writeln();
    }
    if (targetAmount != null && targetAmount! > 0) {
      buffer.writeln('🎯 Goal: $formattedRaised / $formattedTarget ($progressPercentage%)');
      buffer.writeln();
    }
    buffer.writeln('Support *$waiterName* on amTips by scanning or visiting the link below:');
    buffer.writeln(tipUrl);
    buffer.writeln();
    buffer.writeln('Thank you so much for your generosity! ❤️');
    return buffer.toString();
  }

  Campaign copyWith({
    String? id,
    String? waiterId,
    String? title,
    CampaignCategory? category,
    String? description,
    int? targetAmount,
    int? currentAmount,
    int? tipsCount,
    String? currency,
    String? emoji,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Campaign(
      id: id ?? this.id,
      waiterId: waiterId ?? this.waiterId,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      tipsCount: tipsCount ?? this.tipsCount,
      currency: currency ?? this.currency,
      emoji: emoji ?? this.emoji,
      isActive: isActive ?? this.isActive,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        waiterId,
        title,
        category,
        description,
        targetAmount,
        currentAmount,
        tipsCount,
        currency,
        emoji,
        isActive,
        startDate,
        endDate,
        createdAt,
        updatedAt,
      ];
}
