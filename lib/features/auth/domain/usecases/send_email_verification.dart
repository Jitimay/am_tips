import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class SendEmailVerification {
  final AuthRepository repository;
  SendEmailVerification(this.repository);

  Future<Either<Failure, void>> call() => repository.sendEmailVerification();
}
