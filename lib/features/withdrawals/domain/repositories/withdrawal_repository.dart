import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/withdrawal.dart';

abstract class WithdrawalRepository {
  Future<Either<Failure, Withdrawal>> requestWithdrawal({
    required int amount,
    required String currency,
    required String paymentAccountId,
  });

  Future<Either<Failure, List<Withdrawal>>> getWithdrawals({
    int page = 1,
    int pageSize = 20,
  });

  Future<Either<Failure, Withdrawal>> getWithdrawal(String id);
}
