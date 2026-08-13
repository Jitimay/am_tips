import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../domain/entities/notification.dart';
import '../bloc/notification_bloc.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(const NotificationsLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoaded && state.unreadCount > 0) {
                return TextButton(
                  onPressed: () => context
                      .read<NotificationBloc>()
                      .add(const AllNotificationsMarkedRead()),
                  child: const Text('Mark all read'),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NotificationError) {
            return ErrorState(
              message: state.message,
              onRetry: () => context
                  .read<NotificationBloc>()
                  .add(const NotificationsLoaded()),
            );
          }
          if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return EmptyState(
                icon: Icons.notifications_none_rounded,
                title: 'No notifications',
                subtitle: "You're all caught up!",
              );
            }
            return RefreshIndicator(
              onRefresh: () async => context
                  .read<NotificationBloc>()
                  .add(const NotificationsLoaded()),
              child: ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, i) {
                  final n = state.notifications[i];
                  return _NotificationTile(
                    notification: n,
                    onTap: () {
                      if (!n.isRead) {
                        context
                            .read<NotificationBloc>()
                            .add(NotificationMarkedRead(n.id));
                      }
                    },
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
  });

  IconData get _icon {
    switch (notification.type) {
      case NotificationType.newTip:
        return Icons.monetization_on_rounded;
      case NotificationType.withdrawalCompleted:
        return Icons.check_circle_rounded;
      case NotificationType.withdrawalFailed:
        return Icons.error_rounded;
      case NotificationType.paymentIssue:
        return Icons.warning_rounded;
      case NotificationType.system:
        return Icons.info_rounded;
    }
  }

  Color get _color {
    switch (notification.type) {
      case NotificationType.newTip:
        return AppColors.accent;
      case NotificationType.withdrawalCompleted:
        return AppColors.success;
      case NotificationType.withdrawalFailed:
      case NotificationType.paymentIssue:
        return AppColors.error;
      case NotificationType.system:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: notification.isRead
            ? Colors.transparent
            : AppColors.primary.withValues(alpha: 0.04),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: _color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(_icon, color: _color, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: AppTextStyles.labelMedium.copyWith(
                            fontWeight: notification.isRead
                                ? FontWeight.w400
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    notification.body,
                    style: AppTextStyles.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormatter.formatRelative(notification.createdAt),
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
