import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/notification.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
abstract class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String type,
    required String title,
    required String body,
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
    Map<String, dynamic>? metadata,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

extension NotificationModelX on NotificationModel {
  AppNotification toDomain() => AppNotification(
        id: id,
        type: _parseType(type),
        title: title,
        body: body,
        isRead: isRead,
        metadata: metadata,
        createdAt: createdAt,
      );

  static NotificationType _parseType(String t) {
    switch (t.toLowerCase()) {
      case 'new_tip':
        return NotificationType.newTip;
      case 'withdrawal_completed':
        return NotificationType.withdrawalCompleted;
      case 'withdrawal_failed':
        return NotificationType.withdrawalFailed;
      case 'payment_issue':
        return NotificationType.paymentIssue;
      default:
        return NotificationType.system;
    }
  }
}
