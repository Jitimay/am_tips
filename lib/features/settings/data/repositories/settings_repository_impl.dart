import 'package:dartz/dartz.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final ApiClient apiClient;
  SettingsRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await apiClient.post(ApiEndpoints.changePassword, data: {
        'current_password': currentPassword,
        'new_password': newPassword,
      });
      return const Right(null);
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await apiClient.delete(ApiEndpoints.deleteAccount);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> updateNotificationPreferences({
    required bool tipReceived,
    required bool withdrawalUpdate,
  }) async {
    try {
      await apiClient.patch(ApiEndpoints.settings, data: {
        'notifications': {
          'tip_received': tipReceived,
          'withdrawal_update': withdrawalUpdate,
        }
      });
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
