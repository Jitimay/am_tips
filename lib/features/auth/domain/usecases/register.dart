import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;
  Register(this.repository);

  Future<Either<Failure, User>> call({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) =>
      repository.register(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
      );
}
