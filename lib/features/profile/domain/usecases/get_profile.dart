import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/waiter_profile.dart';
import '../repositories/profile_repository.dart';

class GetProfile {
  final ProfileRepository repository;
  GetProfile(this.repository);

  Future<Either<Failure, WaiterProfile>> call() => repository.getProfile();
}
