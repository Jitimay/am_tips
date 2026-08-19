import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/waiter_profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfile {
  final ProfileRepository repository;
  UpdateProfile(this.repository);

  Future<Either<Failure, WaiterProfile>> call({
    String? fullName,
    String? restaurantName,
    String? city,
    String? country,
    String? personalMessage,
  }) =>
      repository.updateProfile(
        fullName: fullName,
        restaurantName: restaurantName,
        city: city,
        country: country,
        personalMessage: personalMessage,
      );
}
