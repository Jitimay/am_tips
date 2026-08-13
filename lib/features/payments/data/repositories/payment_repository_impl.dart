import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_datasource.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PaymentRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods() async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final models = await remoteDataSource.getPaymentMethods();
      return Right(models.map((m) => m.toDomain()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
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
      final model = await remoteDataSource.initiatePayment(
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
  Future<Either<Failure, PaymentStatus>> checkPaymentStatus(
      String paymentId) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final statusStr = await remoteDataSource.checkPaymentStatus(paymentId);
      final status = PaymentStatus.values.firstWhere(
        (e) => e.name == statusStr.toLowerCase(),
        orElse: () => PaymentStatus.pending,
      );
      return Right(status);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, TipFeeBreakdown>> getFeeBreakdown({
    required int amount,
    required String currency,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.getFeeBreakdown(
          amount: amount, currency: currency);
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
