import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Login {
  final AuthRepository repository;
  Login(this.repository);

  Future<Either<Failure, User>> call({
    required String identifier,
    required String password,
  }) =>
      repository.login(identifier: identifier, password: password);
}
