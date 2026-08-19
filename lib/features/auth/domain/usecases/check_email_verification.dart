import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class CheckEmailVerification {
  final AuthRepository repository;
  CheckEmailVerification(this.repository);

  Future<Either<Failure, bool>> call() => repository.checkEmailVerification();
}
