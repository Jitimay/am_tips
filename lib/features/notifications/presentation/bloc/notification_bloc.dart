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
    on<NotificationReceived>(_onNotificationReceived);
    on<NotificationsRefreshed>(_onRefreshed);
  }

  Future<void> _onNotificationReceived(
    NotificationReceived event,
    Emitter<NotificationState> emit,
  ) async {
    if (state is NotificationLoaded) {
      final current = state as NotificationLoaded;
      final alreadyExists =
          current.notifications.any((n) => n.id == event.notification.id);
      if (alreadyExists) return;

      final updated = [event.notification, ...current.notifications];
      final unread = event.notification.isRead
          ? current.unreadCount
          : current.unreadCount + 1;
      emit(NotificationLoaded(notifications: updated, unreadCount: unread));
    } else {
      add(const NotificationsLoaded());
    }
  }

  Future<void> _onRefreshed(
    NotificationsRefreshed event,
    Emitter<NotificationState> emit,
  ) async {
    final notifResult = await notificationRepository.getNotifications();
    final countResult = await notificationRepository.getUnreadCount();

    notifResult.fold(
      (failure) {
        if (state is! NotificationLoaded) {
          emit(NotificationError(failure.message));
        }
      },
      (notifications) {
        final count = countResult.fold((_) => 0, (c) => c);
        emit(NotificationLoaded(
          notifications: notifications,
          unreadCount: count,
        ));
      },
    );
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
