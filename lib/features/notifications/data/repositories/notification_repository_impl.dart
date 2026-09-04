import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/storage/isar_database_service.dart';
import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_datasource.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final IsarDatabaseService isarDb;

  NotificationRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.isarDb,
  });

  @override
  Future<Either<Failure, List<AppNotification>>> getNotifications({
    int page = 1,
    int pageSize = 20,
  }) async {
    // Always load from Isar first — it holds both FCM-received notifications
    // (saved by the foreground handler) and previously fetched remote ones.
    final cached = await isarDb.getNotifications(page: 1, pageSize: 200);

    final online = await networkInfo.isConnected;
    if (online) {
      try {
        final models = await remoteDataSource.getNotifications(
            page: page, pageSize: pageSize);
        final remote = models.map((m) => m.toDomain()).toList();

        // Persist remote rows to Isar so they survive offline
        if (remote.isNotEmpty) {
          await isarDb.saveNotifications(remote);
        }

        // Merge: remote rows + Isar-only rows (e.g. FCM-received),
        // dedup by id, sort newest-first.
        final remoteIds = remote.map((n) => n.id).toSet();
        final isarOnly = cached.where((n) => !remoteIds.contains(n.id)).toList();
        final merged = [...remote, ...isarOnly]
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

        final start = (page - 1) * pageSize;
        final end   = (start + pageSize).clamp(0, merged.length);
        return Right(start < merged.length ? merged.sublist(start, end) : []);
      } catch (_) {
        // Network or parse error — fall through to pure Isar
      }
    }

    // Offline or remote failed: return from Isar cache directly
    return Right(cached);
  }

  @override
  Future<Either<Failure, void>> markAsRead(String id) async {
    // Always mark locally first for instant UI response
    await isarDb.markNotificationAsRead(id);

    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.markAsRead(id);
      } catch (_) {}
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    // Always mark locally first
    await isarDb.markAllNotificationsAsRead();

    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.markAllAsRead();
      } catch (_) {}
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    // Isar is always the source of truth for unread count because
    // it holds both remote-fetched and FCM-received notifications.
    final count = await isarDb.getUnreadNotificationCount();
    return Right(count);
  }

  @override
  Future<Either<Failure, void>> registerPushToken(String token) async {
    try {
      await remoteDataSource.registerPushToken(token);
      return const Right(null);
    } catch (_) {
      return const Right(null); // Non-critical
    }
  }

  @override
  Future<Either<Failure, void>> deletePushToken(String token) async {
    try {
      await remoteDataSource.deletePushToken(token);
      return const Right(null);
    } catch (_) {
      return const Right(null);
    }
  }
}
