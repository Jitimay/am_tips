import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/waiter_profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, WaiterProfile>> getProfile();

  Future<Either<Failure, WaiterProfile>> updateProfile({
    String? fullName,
    String? restaurantName,
    String? city,
    String? country,
    String? personalMessage,
    List<String>? professions,
  });

  Future<Either<Failure, String>> uploadAvatar(String filePath);

  Future<Either<Failure, WaiterProfile>> completeOnboardingStep1({
    required String fullName,
    String? avatarPath,
  });

  Future<Either<Failure, WaiterProfile>> completeOnboardingStep2({
    required String restaurantName,
    required String city,
    required String country,
  });

  Future<Either<Failure, WaiterProfile>> completeOnboardingProfessions({
    required List<String> professions,
  });

  Future<Either<Failure, PaymentAccountInfo>> connectPaymentAccount({
    required String type,
    required String provider,
    required String accountIdentifier,
  });

  Future<Either<Failure, PublicWaiterProfile>> getPublicProfile(String waiterId);
}
