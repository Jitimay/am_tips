import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/storage/isar_database_service.dart';
import '../../domain/entities/withdrawal.dart';
import '../../domain/repositories/withdrawal_repository.dart';
import '../datasources/withdrawal_remote_datasource.dart';
import '../models/withdrawal_model.dart';

class WithdrawalRepositoryImpl implements WithdrawalRepository {
  final WithdrawalRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final IsarDatabaseService isarDb;

  WithdrawalRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.isarDb,
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
      final domain = model.toDomain();
      await isarDb.saveWithdrawal(domain);
      return Right(domain);
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Withdrawal>>> getWithdrawals({
    int page = 1,
    int pageSize = 20,
  }) async {
    final online = await networkInfo.isConnected;
    if (online) {
      try {
        final models = await remoteDataSource.getWithdrawals(
            page: page, pageSize: pageSize);
        final domainList = models.map((m) => m.toDomain()).toList();
        await isarDb.saveWithdrawals(domainList);
        return Right(domainList);
      } catch (_) {
        final cached = await isarDb.getWithdrawals(page: page, pageSize: pageSize);
        return Right(cached);
      }
    }

    final cached = await isarDb.getWithdrawals(page: page, pageSize: pageSize);
    return Right(cached);
  }

  @override
  Future<Either<Failure, Withdrawal>> getWithdrawal(String id) async {
    final online = await networkInfo.isConnected;
    if (online) {
      try {
        final model = await remoteDataSource.getWithdrawal(id);
        final domain = model.toDomain();
        await isarDb.saveWithdrawal(domain);
        return Right(domain);
      } catch (_) {
        final cached = await isarDb.getWithdrawal(id);
        if (cached != null) return Right(cached);
        return const Left(ServerFailure(message: 'Withdrawal not found'));
      }
    }

    final cached = await isarDb.getWithdrawal(id);
    if (cached != null) return Right(cached);
    return const Left(NetworkFailure(
      message: 'No internet connection and withdrawal is not cached.',
    ));
  }
}
