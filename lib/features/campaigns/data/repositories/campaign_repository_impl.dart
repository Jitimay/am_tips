import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/storage/isar_database_service.dart';
import '../../domain/entities/campaign.dart';
import '../../domain/repositories/campaign_repository.dart';
import '../datasources/campaign_remote_datasource.dart';
import '../models/campaign_model.dart';

class CampaignRepositoryImpl implements CampaignRepository {
  final CampaignRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final IsarDatabaseService isarDb;

  CampaignRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.isarDb,
  });

  @override
  Future<Either<Failure, List<Campaign>>> getCampaigns({bool? activeOnly}) async {
    if (await networkInfo.isConnected) {
      try {
        final models = await remoteDataSource.getCampaigns(activeOnly: activeOnly);
        final list = models.map((m) => m.toDomain()).toList();
        await isarDb.saveCampaigns(list);
        return Right(list);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (_) {}
    }
    return Right(await isarDb.getCampaigns(activeOnly: activeOnly));
  }

  @override
  Future<Either<Failure, Campaign>> getCampaign(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final model = await remoteDataSource.getCampaign(id);
        final domain = model.toDomain();
        await isarDb.saveCampaign(domain);
        return Right(domain);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (_) {}
    }
    final cached = await isarDb.getCampaign(id);
    if (cached != null) return Right(cached);
    return const Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, Campaign>> getPublicCampaign(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final model = await remoteDataSource.getPublicCampaign(id);
        final domain = model.toDomain();
        await isarDb.saveCampaign(domain);
        return Right(domain);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (_) {}
    }
    final cached = await isarDb.getCampaign(id);
    if (cached != null) return Right(cached);
    return const Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, Campaign>> createCampaign(Campaign campaign) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.createCampaign(CampaignModel.fromDomain(campaign));
      final domain = model.toDomain();
      await isarDb.saveCampaign(domain);
      return Right(domain);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Campaign>> updateCampaign(Campaign campaign) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.updateCampaign(CampaignModel.fromDomain(campaign));
      final domain = model.toDomain();
      await isarDb.saveCampaign(domain);
      return Right(domain);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Campaign>> toggleCampaignStatus(String id, bool isActive) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.toggleCampaignStatus(id, isActive);
      final domain = model.toDomain();
      await isarDb.saveCampaign(domain);
      return Right(domain);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCampaign(String id) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      await remoteDataSource.deleteCampaign(id);
      await isarDb.deleteCachedCampaign(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
