part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object?> get props => [];
}

class NotificationsLoaded extends NotificationEvent {
  const NotificationsLoaded();
}

class NotificationMarkedRead extends NotificationEvent {
  final String id;
  const NotificationMarkedRead(this.id);
  @override
  List<Object?> get props => [id];
}

class AllNotificationsMarkedRead extends NotificationEvent {
  const AllNotificationsMarkedRead();
}
