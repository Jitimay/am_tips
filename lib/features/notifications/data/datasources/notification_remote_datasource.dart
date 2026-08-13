import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications({int page, int pageSize});
  Future<void> markAsRead(String id);
  Future<void> markAllAsRead();
  Future<int> getUnreadCount();
  Future<void> registerPushToken(String token);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiClient apiClient;
  NotificationRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<NotificationModel>> getNotifications(
      {int page = 1, int pageSize = 20}) async {
    final res = await apiClient.get(
      ApiEndpoints.notifications,
      queryParameters: {'page': page, 'page_size': pageSize},
    );
    final list = res.data['data'] as List;
    return list
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> markAsRead(String id) async {
    await apiClient.patch(ApiEndpoints.markNotificationRead(id));
  }

  @override
  Future<void> markAllAsRead() async {
    await apiClient.patch(ApiEndpoints.markAllNotificationsRead);
  }

  @override
  Future<int> getUnreadCount() async {
    final res = await apiClient.get('/notifications/unread-count');
    return (res.data as Map<String, dynamic>)['count'] as int;
  }

  @override
  Future<void> registerPushToken(String token) async {
    await apiClient.post(
      ApiEndpoints.registerPushToken,
      data: {'token': token},
    );
  }
}
