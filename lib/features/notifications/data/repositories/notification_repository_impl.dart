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
    final online = await networkInfo.isConnected;
    if (online) {
      try {
        final models = await remoteDataSource.getNotifications(
            page: page, pageSize: pageSize);
        final domainList = models.map((m) => m.toDomain()).toList();
        await isarDb.saveNotifications(domainList);
        return Right(domainList);
      } catch (_) {
        final cached = await isarDb.getNotifications(page: page, pageSize: pageSize);
        return Right(cached);
      }
    }

    final cached = await isarDb.getNotifications(page: page, pageSize: pageSize);
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
    final online = await networkInfo.isConnected;
    if (online) {
      try {
        final count = await remoteDataSource.getUnreadCount();
        return Right(count);
      } catch (_) {
        final count = await isarDb.getUnreadNotificationCount();
        return Right(count);
      }
    }

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
}
