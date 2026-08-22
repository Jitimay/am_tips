import 'package:am_tips/core/errors/failures.dart';
import 'package:am_tips/features/notifications/domain/entities/notification.dart';
import 'package:am_tips/features/notifications/domain/repositories/notification_repository.dart';
import 'package:am_tips/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeNotificationRepository implements NotificationRepository {
  Either<Failure, List<AppNotification>>? getNotificationsResult;
  Either<Failure, int>? getUnreadCountResult;
  Either<Failure, void>? markAsReadResult;
  Either<Failure, void>? markAllAsReadResult;
  Either<Failure, void>? registerPushTokenResult;

  String? lastMarkedReadId;
  String? lastRegisteredToken;

  @override
  Future<Either<Failure, List<AppNotification>>> getNotifications({
    int page = 1,
    int pageSize = 20,
  }) async {
    return getNotificationsResult ?? const Right([]);
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    return getUnreadCountResult ?? const Right(0);
  }

  @override
  Future<Either<Failure, void>> markAsRead(String id) async {
    lastMarkedReadId = id;
    return markAsReadResult ?? const Right(null);
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    return markAllAsReadResult ?? const Right(null);
  }

  @override
  Future<Either<Failure, void>> registerPushToken(String token) async {
    lastRegisteredToken = token;
    return registerPushTokenResult ?? const Right(null);
  }
}

void main() {
  late FakeNotificationRepository fakeRepo;
  late AppNotification notif1;
  late AppNotification notif2;
  late AppNotification newTipNotif;

  setUp(() {
    fakeRepo = FakeNotificationRepository();
    final now = DateTime(2026, 8, 22, 12, 0, 0);

    notif1 = AppNotification(
      id: 'notif-1',
      type: NotificationType.newTip,
      title: 'New Tip Received!',
      body: 'You received a tip of 5,000 BIF',
      isRead: false,
      createdAt: now.subtract(const Duration(minutes: 5)),
    );

    notif2 = AppNotification(
      id: 'notif-2',
      type: NotificationType.withdrawalCompleted,
      title: 'Withdrawal Completed',
      body: 'Your withdrawal of 20,000 BIF has been sent.',
      isRead: true,
      createdAt: now.subtract(const Duration(hours: 1)),
    );

    newTipNotif = AppNotification(
      id: 'notif-3',
      type: NotificationType.newTip,
      title: 'New Tip Received!',
      body: 'You received a tip of 10,000 BIF',
      isRead: false,
      createdAt: now,
    );
  });

  group('NotificationBloc', () {
    test('initial state is NotificationInitial', () {
      final bloc = NotificationBloc(notificationRepository: fakeRepo);
      expect(bloc.state, const NotificationInitial());
    });

    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationLoading, NotificationLoaded] when NotificationsLoaded succeeds',
      build: () {
        fakeRepo.getNotificationsResult = Right([notif1, notif2]);
        fakeRepo.getUnreadCountResult = const Right(1);
        return NotificationBloc(notificationRepository: fakeRepo);
      },
      act: (bloc) => bloc.add(const NotificationsLoaded()),
      expect: () => [
        const NotificationLoading(),
        NotificationLoaded(
          notifications: [notif1, notif2],
          unreadCount: 1,
        ),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationLoading, NotificationError] when NotificationsLoaded fails',
      build: () {
        fakeRepo.getNotificationsResult =
            const Left(ServerFailure(message: 'Failed to fetch notifications'));
        return NotificationBloc(notificationRepository: fakeRepo);
      },
      act: (bloc) => bloc.add(const NotificationsLoaded()),
      expect: () => [
        const NotificationLoading(),
        const NotificationError('Failed to fetch notifications'),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'marks single notification as read and decrements unreadCount',
      build: () {
        return NotificationBloc(notificationRepository: fakeRepo);
      },
      seed: () => NotificationLoaded(
        notifications: [notif1, notif2],
        unreadCount: 1,
      ),
      act: (bloc) => bloc.add(const NotificationMarkedRead('notif-1')),
      expect: () => [
        NotificationLoaded(
          notifications: [notif1.copyWith(isRead: true), notif2],
          unreadCount: 0,
        ),
      ],
      verify: (_) {
        expect(fakeRepo.lastMarkedReadId, 'notif-1');
      },
    );

    blocTest<NotificationBloc, NotificationState>(
      'marks all notifications as read and sets unreadCount to 0',
      build: () {
        return NotificationBloc(notificationRepository: fakeRepo);
      },
      seed: () => NotificationLoaded(
        notifications: [notif1, notif2],
        unreadCount: 1,
      ),
      act: (bloc) => bloc.add(const AllNotificationsMarkedRead()),
      expect: () => [
        NotificationLoaded(
          notifications: [
            notif1.copyWith(isRead: true),
            notif2.copyWith(isRead: true),
          ],
          unreadCount: 0,
        ),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'prepends received notification and increments unread count when state is NotificationLoaded',
      build: () {
        return NotificationBloc(notificationRepository: fakeRepo);
      },
      seed: () => NotificationLoaded(
        notifications: [notif1, notif2],
        unreadCount: 1,
      ),
      act: (bloc) => bloc.add(NotificationReceived(newTipNotif)),
      expect: () => [
        NotificationLoaded(
          notifications: [newTipNotif, notif1, notif2],
          unreadCount: 2,
        ),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'refreshes notifications seamlessly on NotificationsRefreshed without emitting NotificationLoading',
      build: () {
        fakeRepo.getNotificationsResult = Right([newTipNotif, notif1, notif2]);
        fakeRepo.getUnreadCountResult = const Right(2);
        return NotificationBloc(notificationRepository: fakeRepo);
      },
      seed: () => NotificationLoaded(
        notifications: [notif1, notif2],
        unreadCount: 1,
      ),
      act: (bloc) => bloc.add(const NotificationsRefreshed()),
      expect: () => [
        NotificationLoaded(
          notifications: [newTipNotif, notif1, notif2],
          unreadCount: 2,
        ),
      ],
    );
  });
}
