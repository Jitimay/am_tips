import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/storage/isar_database_service.dart';
import '../../domain/entities/qr_code.dart';
import '../../domain/repositories/qr_repository.dart';
import '../datasources/qr_remote_datasource.dart';
import '../models/qr_code_model.dart';

class QrRepositoryImpl implements QrRepository {
  final QrRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final IsarDatabaseService isarDb;

  QrRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.isarDb,
  });

  @override
  Future<Either<Failure, QrCode>> getMyQrCode() async {
    final online = await networkInfo.isConnected;
    if (online) {
      try {
        final model = await remoteDataSource.getMyQrCode();
        final domain = model.toDomain();
        await isarDb.saveQrCode(domain, domain.waiterId);
        return Right(domain);
      } catch (_) {
        final cached = await isarDb.getQrCode();
        if (cached != null) return Right(cached);
        return const Left(ServerFailure(message: 'Could not load QR code'));
      }
    }

    final cached = await isarDb.getQrCode();
    if (cached != null) return Right(cached);
    return const Left(NetworkFailure(
      message: 'No internet connection and no cached QR code available.',
    ));
  }

  @override
  Future<Either<Failure, QrCode>> regenerateQrCode() async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.regenerateQrCode();
      final domain = model.toDomain();
      await isarDb.saveQrCode(domain, domain.waiterId);
      return Right(domain);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
