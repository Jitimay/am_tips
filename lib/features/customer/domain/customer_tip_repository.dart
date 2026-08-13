import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../profile/domain/entities/waiter_profile.dart';
import '../../payments/domain/entities/payment.dart';
import '../../tips/domain/entities/tip.dart';

abstract class CustomerTipRepository {
  Future<Either<Failure, PublicWaiterProfile>> getWaiterPublicProfile(
      String waiterId);

  Future<Either<Failure, TipFeeBreakdown>> getFeeBreakdown({
    required String waiterId,
    required int amount,
    required String currency,
  });

  Future<Either<Failure, Tip>> initiateTip({
    required String waiterId,
    required int amount,
    required String currency,
    required bool isAnonymous,
    String? idempotencyKey,
  });

  Future<Either<Failure, PaymentResult>> initiatePayment({
    required String tipId,
    required String methodId,
    required String idempotencyKey,
  });

  Future<Either<Failure, TipStatus>> checkTipStatus(String tipId);

  Future<Either<Failure, void>> submitFeedback({
    required String tipId,
    int? rating,
    String? message,
  });

  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods();
}
