import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

abstract class SettingsRepository {
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<Either<Failure, void>> deleteAccount();

  Future<Either<Failure, void>> updateNotificationPreferences({
    required bool tipReceived,
    required bool withdrawalUpdate,
  });
}
