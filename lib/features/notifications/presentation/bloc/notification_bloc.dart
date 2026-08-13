import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc
    extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository notificationRepository;

  NotificationBloc({required this.notificationRepository})
      : super(const NotificationInitial()) {
    on<NotificationsLoaded>(_onLoaded);
    on<NotificationMarkedRead>(_onMarkRead);
    on<AllNotificationsMarkedRead>(_onMarkAllRead);
  }

  Future<void> _onLoaded(
      NotificationsLoaded event, Emitter<NotificationState> emit) async {
    emit(const NotificationLoading());
    final notifResult = await notificationRepository.getNotifications();
    final countResult = await notificationRepository.getUnreadCount();

    notifResult.fold(
      (failure) => emit(NotificationError(failure.message)),
      (notifications) {
        final count = countResult.fold((_) => 0, (c) => c);
        emit(NotificationLoaded(
            notifications: notifications, unreadCount: count));
      },
    );
  }

  Future<void> _onMarkRead(
      NotificationMarkedRead event,
      Emitter<NotificationState> emit) async {
    await notificationRepository.markAsRead(event.id);
    if (state is NotificationLoaded) {
      final current = state as NotificationLoaded;
      final updated = current.notifications.map((n) {
        return n.id == event.id ? n.copyWith(isRead: true) : n;
      }).toList();
      final unread = updated.where((n) => !n.isRead).length;
      emit(NotificationLoaded(notifications: updated, unreadCount: unread));
    }
  }

  Future<void> _onMarkAllRead(
      AllNotificationsMarkedRead event,
      Emitter<NotificationState> emit) async {
    await notificationRepository.markAllAsRead();
    if (state is NotificationLoaded) {
      final current = state as NotificationLoaded;
      final updated =
          current.notifications.map((n) => n.copyWith(isRead: true)).toList();
      emit(NotificationLoaded(notifications: updated, unreadCount: 0));
    }
  }
}
