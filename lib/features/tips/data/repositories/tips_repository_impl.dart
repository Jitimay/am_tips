import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/tip.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/tips_repository.dart';
import '../datasources/tips_remote_datasource.dart';
import '../models/tip_model.dart';
import '../models/wallet_model.dart';

class TipsRepositoryImpl implements TipsRepository {
  final TipsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TipsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Tip>>> getTips({
    TipFilter filter = TipFilter.all,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final filterStr = _filterToString(filter);
      final models = await remoteDataSource.getTips(
          filter: filterStr, page: page, pageSize: pageSize);
      return Right(models.map((m) => m.toDomain()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Tip>> getTip(String id) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.getTip(id);
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, TipStats>> getTipStats() async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.getTipStats();
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Wallet>> getWallet() async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.getWallet();
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<WalletTransaction>>> getTransactions({
    int page = 1,
    int pageSize = 20,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final models = await remoteDataSource.getTransactions(
          page: page, pageSize: pageSize);
      return Right(models.map((m) => m.toDomain()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  String? _filterToString(TipFilter filter) {
    switch (filter) {
      case TipFilter.today:
        return 'today';
      case TipFilter.thisWeek:
        return 'week';
      case TipFilter.thisMonth:
        return 'month';
      case TipFilter.all:
        return null;
    }
  }
}
