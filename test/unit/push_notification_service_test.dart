import 'package:am_tips/core/errors/failures.dart';
import 'package:am_tips/core/services/push_notification_service.dart';
import 'package:am_tips/core/storage/secure_storage.dart';
import 'package:am_tips/features/notifications/domain/entities/notification.dart';
import 'package:am_tips/features/notifications/domain/repositories/notification_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNotificationRepository implements NotificationRepository {
  String? registeredToken;
  bool shouldFail = false;

  @override
  Future<Either<Failure, void>> registerPushToken(String token) async {
    registeredToken = token;
    if (shouldFail) {
      return const Left(ServerFailure(message: 'Registration failed'));
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<AppNotification>>> getNotifications({
    int page = 1,
    int pageSize = 20,
  }) async {
    return const Right([]);
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    return const Right(0);
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> markAsRead(String id) async {
    return const Right(null);
  }
}

class FakeSecureStorage extends SecureStorage {
  final Map<String, String> _data = {};

  FakeSecureStorage() : super(storage: const FlutterSecureStorage());

  @override
  Future<void> saveAccessToken(String token) async =>
      _data['access_token'] = token;
  @override
  Future<String?> getAccessToken() async => _data['access_token'];
  @override
  Future<void> saveRefreshToken(String token) async =>
      _data['refresh_token'] = token;
  @override
  Future<String?> getRefreshToken() async => _data['refresh_token'];
  @override
  Future<void> saveUserId(String id) async => _data['user_id'] = id;
  @override
  Future<String?> getUserId() async => _data['user_id'];
  @override
  Future<bool> get hasValidSession async => _data.containsKey('access_token');
  @override
  Future<void> clearAll() async => _data.clear();
}

void main() {
  late MockNotificationRepository fakeRepo;
  late FakeSecureStorage fakeStorage;

  setUp(() {
    fakeRepo = MockNotificationRepository();
    fakeStorage = FakeSecureStorage();
  });

  group('PushNotificationService Message Parsing', () {
    test('parses new_tip RemoteMessage correctly into AppNotification', () {
      final service = PushNotificationService(
        notificationRepository: fakeRepo,
        secureStorage: fakeStorage,
      );

      final message = RemoteMessage(
        messageId: 'msg-123',
        sentTime: DateTime(2026, 8, 22, 10, 0, 0),
        notification: const RemoteNotification(
          title: 'You got a tip!',
          body: 'A customer tipped 5,000 BIF',
        ),
        data: {
          'type': 'new_tip',
          'tip_id': 'tip-456',
          'amount': '5000',
        },
      );

      final parsed = service.parseRemoteMessage(message);

      expect(parsed.id, 'msg-123');
      expect(parsed.title, 'You got a tip!');
      expect(parsed.body, 'A customer tipped 5,000 BIF');
      expect(parsed.type, NotificationType.newTip);
      expect(parsed.isRead, false);
      expect(parsed.metadata?['tip_id'], 'tip-456');
    });

    test('parses withdrawal_completed RemoteMessage correctly', () {
      final service = PushNotificationService(
        notificationRepository: fakeRepo,
        secureStorage: fakeStorage,
      );

      final message = RemoteMessage(
        messageId: 'msg-789',
        sentTime: DateTime(2026, 8, 22, 11, 0, 0),
        notification: const RemoteNotification(
          title: 'Withdrawal Success',
          body: '20,000 BIF has been sent to Lumicash',
        ),
        data: {
          'type': 'withdrawal_completed',
          'withdrawal_id': 'wd-001',
        },
      );

      final parsed = service.parseRemoteMessage(message);

      expect(parsed.id, 'msg-789');
      expect(parsed.type, NotificationType.withdrawalCompleted);
      expect(parsed.title, 'Withdrawal Success');
      expect(parsed.body, '20,000 BIF has been sent to Lumicash');
    });

    test('parses withdrawal_failed RemoteMessage correctly', () {
      final service = PushNotificationService(
        notificationRepository: fakeRepo,
        secureStorage: fakeStorage,
      );

      final message = RemoteMessage(
        messageId: 'msg-999',
        sentTime: DateTime(2026, 8, 22, 11, 30, 0),
        data: {
          'type': 'withdrawal_failed',
          'title': 'Withdrawal Failed',
          'body': 'Could not process payout to EcoCash',
        },
      );

      final parsed = service.parseRemoteMessage(message);

      expect(parsed.id, 'msg-999');
      expect(parsed.type, NotificationType.withdrawalFailed);
      expect(parsed.title, 'Withdrawal Failed');
      expect(parsed.body, 'Could not process payout to EcoCash');
    });

    test('parses payment_issue RemoteMessage correctly', () {
      final service = PushNotificationService(
        notificationRepository: fakeRepo,
        secureStorage: fakeStorage,
      );

      final message = RemoteMessage(
        messageId: 'msg-101',
        sentTime: DateTime(2026, 8, 22, 11, 45, 0),
        data: {
          'type': 'payment_issue',
          'title': 'Payment Issue',
          'body': 'Customer payment was declined',
        },
      );

      final parsed = service.parseRemoteMessage(message);

      expect(parsed.id, 'msg-101');
      expect(parsed.type, NotificationType.paymentIssue);
      expect(parsed.title, 'Payment Issue');
    });

    test('parses fallback system RemoteMessage correctly', () {
      final service = PushNotificationService(
        notificationRepository: fakeRepo,
        secureStorage: fakeStorage,
      );

      final message = RemoteMessage(
        messageId: 'msg-000',
        sentTime: DateTime(2026, 8, 22, 12, 0, 0),
        notification: const RemoteNotification(
          title: 'System Announcement',
          body: 'Platform maintenance scheduled for midnight.',
        ),
        data: {
          'type': 'unknown_type',
        },
      );

      final parsed = service.parseRemoteMessage(message);

      expect(parsed.id, 'msg-000');
      expect(parsed.type, NotificationType.system);
      expect(parsed.title, 'System Announcement');
    });
  });

  group('PushNotificationService Channel Configuration', () {
    test('AndroidNotificationChannel is properly configured with high importance', () {
      final channel = PushNotificationService.androidNotificationChannel;
      expect(channel.id, PushNotificationService.notificationChannelId);
      expect(channel.name, PushNotificationService.notificationChannelName);
      expect(channel.description, PushNotificationService.notificationChannelDescription);
      expect(channel.playSound, true);
      expect(channel.enableVibration, true);
    });
  });
}
