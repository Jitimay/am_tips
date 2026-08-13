import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/withdrawal.dart';
import '../../domain/repositories/withdrawal_repository.dart';
import '../datasources/withdrawal_remote_datasource.dart';

class WithdrawalRepositoryImpl implements WithdrawalRepository {
  final WithdrawalRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WithdrawalRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Withdrawal>> requestWithdrawal({
    required int amount,
    required String currency,
    required String paymentAccountId,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.requestWithdrawal({
        'amount': amount,
        'currency': currency,
        'payment_account_id': paymentAccountId,
      });
      return Right(model.toDomain());
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<Withdrawal>>> getWithdrawals({
    int page = 1,
    int pageSize = 20,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final models = await remoteDataSource.getWithdrawals(
          page: page, pageSize: pageSize);
      return Right(models.map((m) => m.toDomain()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Withdrawal>> getWithdrawal(String id) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.getWithdrawal(id);
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
