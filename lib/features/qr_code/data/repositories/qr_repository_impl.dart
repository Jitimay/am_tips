import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/qr_code.dart';
import '../../domain/repositories/qr_repository.dart';
import '../datasources/qr_remote_datasource.dart';
import '../models/qr_code_model.dart';

class QrRepositoryImpl implements QrRepository {
  final QrRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  QrRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, QrCode>> getMyQrCode() async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.getMyQrCode();
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, QrCode>> regenerateQrCode() async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.regenerateQrCode();
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
