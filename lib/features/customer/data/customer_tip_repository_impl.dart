import 'package:dartz/dartz.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/network/network_info.dart';
import '../../payments/data/models/payment_model.dart';
import '../../payments/domain/entities/payment.dart';
import '../../profile/domain/entities/waiter_profile.dart';
import '../../tips/domain/entities/tip.dart';
import '../domain/customer_tip_repository.dart';
import 'customer_tip_datasource.dart';

class CustomerTipRepositoryImpl implements CustomerTipRepository {
  final CustomerTipDataSource dataSource;
  final NetworkInfo networkInfo;

  CustomerTipRepositoryImpl({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PublicWaiterProfile>> getWaiterPublicProfile(
      String waiterId) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await dataSource.getWaiterPublicProfile(waiterId);
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, TipFeeBreakdown>> getFeeBreakdown({
    required String waiterId,
    required int amount,
    required String currency,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await dataSource.getFeeBreakdown(
        waiterId: waiterId,
        amount: amount,
        currency: currency,
      );
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Tip>> initiateTip({
    required String waiterId,
    required int amount,
    required String currency,
    required bool isAnonymous,
    String? idempotencyKey,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await dataSource.initiateTip(
        waiterId: waiterId,
        amount: amount,
        currency: currency,
        isAnonymous: isAnonymous,
        idempotencyKey: idempotencyKey,
      );
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(PaymentFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PaymentResult>> initiatePayment({
    required String tipId,
    required String methodId,
    required String idempotencyKey,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await dataSource.initiatePayment(
        tipId: tipId,
        methodId: methodId,
        idempotencyKey: idempotencyKey,
      );
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(PaymentFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, TipStatus>> checkTipStatus(String tipId) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final statusStr = await dataSource.checkTipStatus(tipId);
      final status = TipStatus.values.firstWhere(
        (e) => e.name == statusStr.toLowerCase(),
        orElse: () => TipStatus.pending,
      );
      return Right(status);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> submitFeedback({
    required String tipId,
    int? rating,
    String? message,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      await dataSource.submitFeedback(
          tipId: tipId, rating: rating, message: message);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods() async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final models = await dataSource.getPaymentMethods();
      return Right(models.map((m) => m.toDomain()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
