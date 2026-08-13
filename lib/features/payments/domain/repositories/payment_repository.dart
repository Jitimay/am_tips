import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/payment.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods();

  Future<Either<Failure, PaymentResult>> initiatePayment({
    required String tipId,
    required String methodId,
    required String idempotencyKey,
  });

  Future<Either<Failure, PaymentStatus>> checkPaymentStatus(String paymentId);

  Future<Either<Failure, TipFeeBreakdown>> getFeeBreakdown({
    required int amount,
    required String currency,
  });
}
