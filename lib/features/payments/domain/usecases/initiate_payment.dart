import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/payment.dart';
import '../repositories/payment_repository.dart';

class InitiatePayment {
  final PaymentRepository repository;
  InitiatePayment(this.repository);

  Future<Either<Failure, PaymentResult>> call({
    required String tipId,
    required String methodId,
    required String idempotencyKey,
  }) =>
      repository.initiatePayment(
        tipId: tipId,
        methodId: methodId,
        idempotencyKey: idempotencyKey,
      );
}
