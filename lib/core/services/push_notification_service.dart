import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uuid/uuid.dart';

import '../../features/notifications/domain/entities/notification.dart';
import '../../features/notifications/domain/repositories/notification_repository.dart';
import '../../firebase_options.dart';
import '../router/app_router.dart';
import '../storage/isar_database_service.dart';
import '../storage/secure_storage.dart';

/// Top-level background message handler required by Firebase Cloud Messaging.
/// This runs in an isolated background Dart execution context.
///
/// When the app is in the background:
///  - Messages with a `notification` block are shown automatically by the OS.
///  - Data-only messages (no `notification` block) are silently delivered and
///    would otherwise be lost. We show a local notification for those here.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    debugPrint('[FCM Background] Initialization error: $e');
    return;
  }

  debugPrint('[FCM Background] Message received: id=${message.messageId}, data=${message.data}');

  // Only show a local notification for data-only messages.
  // If there's a notification block the OS already shows it.
  if (message.notification == null && message.data.isNotEmpty) {
    final title = message.data['title'] as String? ?? 'amTips';
    final body  = message.data['body']  as String? ?? '';

    if (title.isNotEmpty || body.isNotEmpty) {
      try {
        final plugin = FlutterLocalNotificationsPlugin();
        const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
        await plugin.initialize(
          const InitializationSettings(android: androidInit),
        );

        // Create the channel in case it wasn't created yet in this isolate
        await plugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(
              const AndroidNotificationChannel(
                PushNotificationService.notificationChannelId,
                PushNotificationService.notificationChannelName,
                description: PushNotificationService.notificationChannelDescription,
                importance: Importance.max,
              ),
            );

        final notifId = (message.messageId ?? const Uuid().v4()).hashCode.abs();
        await plugin.show(
          id: notifId,
          title: title,
          body: body,
          notificationDetails: const NotificationDetails(
            android: AndroidNotificationDetails(
              PushNotificationService.notificationChannelId,
              PushNotificationService.notificationChannelName,
              importance: Importance.max,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      } catch (e) {
        debugPrint('[FCM Background] Failed to show local notification: $e');
      }
    }
  }
}

/// Service managing Firebase Cloud Messaging (FCM) and local notifications.
class PushNotificationService {
  static const String notificationChannelId = 'amtips_notifications_channel';
  static const String notificationChannelName = 'amTips Notifications';
  static const String notificationChannelDescription =
      'Notifications for incoming tips, withdrawals, and account updates';

  final FirebaseMessaging? _customMessaging;
  final FlutterLocalNotificationsPlugin? _customLocalNotifications;
  final NotificationRepository notificationRepository;
  final SecureStorage secureStorage;
  final IsarDatabaseService? isarDb;

  FirebaseMessaging get _messaging =>
      _customMessaging ?? FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin get _localNotifications =>
      _customLocalNotifications ?? FlutterLocalNotificationsPlugin();

  final StreamController<AppNotification> _notificationStreamController =
      StreamController<AppNotification>.broadcast();
  final StreamController<Map<String, dynamic>> _openedStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  bool _initialized = false;
  String? _lastToken;

  PushNotificationService({
    FirebaseMessaging? messaging,
    FlutterLocalNotificationsPlugin? localNotifications,
    required this.notificationRepository,
    required this.secureStorage,
    this.isarDb,
  })  : _customMessaging = messaging,
        _customLocalNotifications = localNotifications;

  /// Cached device token if already fetched.
  String? get lastToken => _lastToken;

  /// Whether the push service has completed initialization.
  bool get isInitialized => _initialized;

  /// Stream of incoming notifications received while in foreground.
  Stream<AppNotification> get onNotificationReceived =>
      _notificationStreamController.stream;

  /// Stream of notification data payloads opened by user.
  Stream<Map<String, dynamic>> get onNotificationOpened =>
      _openedStreamController.stream;

  /// Returns the Android notification channel specification.
  static const AndroidNotificationChannel androidNotificationChannel =
      AndroidNotificationChannel(
    notificationChannelId,
    notificationChannelName,
    description: notificationChannelDescription,
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
  );

  /// Initializes FCM and local notification listeners, permissions, and channels.
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      // 1. Request notification permissions
      await requestPermissions();

      // 2. Initialize local notifications
      await _initializeLocalNotifications();

      // 3. Configure foreground presentation options for Apple platforms
      if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
        await _messaging.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      }

      // 4. Listen for incoming foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // 5. Listen for notification taps when the app is opened from the background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('[FCM] onMessageOpenedApp: ${message.data}');
        _openedStreamController.add(message.data);
        handleNotificationRouting(message.data);
      });

      // 6. Check for cold launch from terminated state via notification tap
      final initialMessage = await _messaging.getInitialMessage();
      if (initialMessage != null) {
        debugPrint('[FCM] App launched from terminated state via notification: ${initialMessage.data}');
        _openedStreamController.add(initialMessage.data);
        // Delay slightly to let router/navigation initialize
        Future.delayed(const Duration(milliseconds: 600), () {
          handleNotificationRouting(initialMessage.data);
        });
      }

      // 7. Listen for FCM token refresh
      _messaging.onTokenRefresh.listen((newToken) {
        debugPrint('[FCM] Token refreshed: $newToken');
        _lastToken = newToken;
        syncToken(force: true);
      });

      _initialized = true;
      debugPrint('[FCM] PushNotificationService initialized successfully.');
    } catch (e, st) {
      debugPrint('[FCM] PushNotificationService initialization error: $e\n$st');
    }
  }

  /// Requests push notification permissions on iOS, Android 13+, and Web.
  Future<NotificationSettings?> requestPermissions() async {
    try {
      final settings = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      debugPrint('[FCM] Permission status: ${settings.authorizationStatus}');

      // For Android 13+ (API level 33+)
      if (!kIsWeb && Platform.isAndroid) {
        final androidPlugin = _localNotifications
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();
        await androidPlugin?.requestNotificationsPermission();
      }

      return settings;
    } catch (e) {
      debugPrint('[FCM] Error requesting permissions: $e');
      return null;
    }
  }

  /// Sets up Flutter Local Notifications plugin and Android channels.
  Future<void> _initializeLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: darwinInit,
      macOS: darwinInit,
    );

    await _localNotifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          try {
            final Map<String, dynamic> data =
                jsonDecode(payload) as Map<String, dynamic>;
            debugPrint('[FCM] Local notification tapped with payload: $data');
            _openedStreamController.add(data);
            handleNotificationRouting(data);
          } catch (e) {
            debugPrint('[FCM] Error decoding notification payload: $e');
            AppRouter.router.push(AppRoutes.notifications);
          }
        } else {
          AppRouter.router.push(AppRoutes.notifications);
        }
      },
    );

    // Create high importance notification channel on Android
    if (!kIsWeb && Platform.isAndroid) {
      final androidPlugin = _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.createNotificationChannel(androidNotificationChannel);
    }
  }

  /// Handles incoming FCM messages while app is in foreground.
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint('[FCM] Foreground message received: title=${message.notification?.title}, data=${message.data}');

    final appNotification = parseRemoteMessage(message);
    _notificationStreamController.add(appNotification);
    await isarDb?.saveNotifications([appNotification]);

    // Show heads-up notification in foreground
    final title = message.notification?.title ??
        message.data['title'] ??
        'amTips Notification';
    final body = message.notification?.body ??
        message.data['body'] ??
        '';

    if (title.isNotEmpty || body.isNotEmpty) {
      final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: androidNotificationChannel.description,
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          styleInformation: body.length > 40
              ? BigTextStyleInformation(body)
              : null,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      // Use a stable, unique ID — messageId can be null which would cause
      // all null-ID notifications to collide on ID 0 and replace each other.
      final id = (message.messageId ?? const Uuid().v4()).hashCode.abs();
      await _localNotifications.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: notificationDetails,
        payload: jsonEncode(message.data),
      );
    }
  }

  /// Retrieves the current FCM device token.
  Future<String?> getToken() async {
    try {
      final token = await _messaging.getToken();
      _lastToken = token;
      return token;
    } catch (e) {
      debugPrint('[FCM] Error getting token: $e');
      return null;
    }
  }

  /// Synchronizes the device FCM token with the backend API.
  Future<void> syncToken({bool force = false}) async {
    try {
      final hasSession = await secureStorage.hasValidSession;
      if (!hasSession && !force) {
        debugPrint('[FCM] Skipping token sync: No active authenticated session.');
        return;
      }

      final token = await getToken();
      if (token == null || token.isEmpty) {
        debugPrint('[FCM] Cannot sync token: token is null or empty.');
        return;
      }

      debugPrint('[FCM] Registering FCM token with backend: $token');
      final result = await notificationRepository.registerPushToken(token);
      result.fold(
        (failure) => debugPrint('[FCM] Failed to register token with backend: ${failure.message}'),
        (_) => debugPrint('[FCM] Successfully registered FCM token with backend.'),
      );
    } catch (e) {
      debugPrint('[FCM] Error syncing token: $e');
    }
  }

  /// Subscribes the device to a specific FCM topic (e.g. 'tips', 'announcements').
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      debugPrint('[FCM] Subscribed to topic: $topic');
    } catch (e) {
      debugPrint('[FCM] Failed to subscribe to topic $topic: $e');
    }
  }

  /// Unsubscribes the device from an FCM topic.
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      debugPrint('[FCM] Unsubscribed from topic: $topic');
    } catch (e) {
      debugPrint('[FCM] Failed to unsubscribe from topic $topic: $e');
    }
  }

  /// Deletes the local FCM registration token (e.g., on logout).
  Future<void> deleteToken() async {
    try {
      await _messaging.deleteToken();
      _lastToken = null;
      debugPrint('[FCM] FCM Token deleted.');
    } catch (e) {
      debugPrint('[FCM] Error deleting token: $e');
    }
  }

  /// Navigates the user to the appropriate screen based on payload data.
  void handleNotificationRouting(Map<String, dynamic> data) {
    if (data.isEmpty) {
      AppRouter.router.push(AppRoutes.notifications);
      return;
    }

    // Direct route override in payload
    final route = data['route'] as String? ?? data['path'] as String?;
    if (route != null && route.isNotEmpty) {
      AppRouter.router.push(route);
      return;
    }

    final type = data['type'] as String?;
    final tipId = data['tip_id'] as String? ??
        data['tipId'] as String? ??
        data['id'] as String?;

    switch (type) {
      case 'new_tip':
      case 'newTip':
      case 'tip':
        if (tipId != null && tipId.isNotEmpty) {
          AppRouter.router.push('/tips/$tipId');
        } else {
          AppRouter.router.push(AppRoutes.tips);
        }
        break;

      case 'withdrawal_completed':
      case 'withdrawalCompleted':
      case 'withdrawal_failed':
      case 'withdrawalFailed':
      case 'withdrawal':
        AppRouter.router.push(AppRoutes.wallet);
        break;

      case 'payment_issue':
      case 'paymentIssue':
      case 'system':
      default:
        AppRouter.router.push(AppRoutes.notifications);
        break;
    }
  }

  /// Converts a [RemoteMessage] into the domain [AppNotification] entity.
  AppNotification parseRemoteMessage(RemoteMessage message) {
    final data = message.data;
    final typeStr = data['type'] as String? ?? '';
    NotificationType type;

    switch (typeStr) {
      case 'new_tip':
      case 'newTip':
      case 'tip':
        type = NotificationType.newTip;
        break;
      case 'withdrawal_completed':
      case 'withdrawalCompleted':
        type = NotificationType.withdrawalCompleted;
        break;
      case 'withdrawal_failed':
      case 'withdrawalFailed':
        type = NotificationType.withdrawalFailed;
        break;
      case 'payment_issue':
      case 'paymentIssue':
        type = NotificationType.paymentIssue;
        break;
      case 'system':
      default:
        type = NotificationType.system;
        break;
    }

    final id = message.messageId ??
        data['id'] as String? ??
        const Uuid().v4();
    final title = message.notification?.title ??
        data['title'] as String? ??
        'amTips Notification';
    final body = message.notification?.body ??
        data['body'] as String? ??
        '';

    return AppNotification(
      id: id,
      type: type,
      title: title,
      body: body,
      isRead: false,
      metadata: data,
      createdAt: message.sentTime ?? DateTime.now(),
    );
  }

  void dispose() {
    _notificationStreamController.close();
    _openedStreamController.close();
  }
}
