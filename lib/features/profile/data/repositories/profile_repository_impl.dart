import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/storage/isar_database_service.dart';
import '../../domain/entities/waiter_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';
import '../models/waiter_profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final IsarDatabaseService isarDb;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.isarDb,
  });

  @override
  Future<Either<Failure, WaiterProfile>> getProfile() async {
    final online = await networkInfo.isConnected;
    if (online) {
      try {
        final model = await remoteDataSource.getProfile();
        final domain = model.toDomain();
        await isarDb.saveProfile(domain);
        return Right(domain);
      } on AuthenticationException catch (e) {
        return Left(AuthenticationFailure(message: e.message));
      } catch (e) {
        // Fall back to local Isar store if network error occurred despite being connected
        final cached = await isarDb.getProfile();
        if (cached != null) return Right(cached);
        return Left(ServerFailure(message: e.toString()));
      }
    }

    // Offline — serve from Isar
    final cached = await isarDb.getProfile();
    if (cached != null) return Right(cached);
    return const Left(NetworkFailure(
      message: 'No internet connection and no cached profile available.',
    ));
  }

  @override
  Future<Either<Failure, WaiterProfile>> updateProfile({
    String? fullName,
    String? restaurantName,
    String? city,
    String? country,
    String? personalMessage,
    List<String>? professions,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final data = <String, dynamic>{
        if (fullName != null) 'full_name': fullName,
        if (restaurantName != null) 'restaurant_name': restaurantName,
        if (city != null) 'city': city,
        if (country != null) 'country': country,
        if (personalMessage != null) 'personal_message': personalMessage,
        if (professions != null) 'professions': professions,
      };
      final model = await remoteDataSource.updateProfile(data);
      final domain = model.toDomain();
      await isarDb.saveProfile(domain);
      return Right(domain);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadAvatar(String filePath) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final url = await remoteDataSource.uploadAvatar(filePath);
      return Right(url);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, WaiterProfile>> completeOnboardingStep1({
    required String fullName,
    String? avatarPath,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      String? avatarUrl;
      if (avatarPath != null && avatarPath.isNotEmpty) {
        avatarUrl = await remoteDataSource.uploadAvatar(avatarPath);
      }
      final data = <String, dynamic>{'full_name': fullName};
      if (avatarUrl != null) {
        data['avatar_url'] = avatarUrl;
      }
      final model = await remoteDataSource.updateProfile(data);
      final domain = model.toDomain();
      await isarDb.saveProfile(domain);
      return Right(domain);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, WaiterProfile>> completeOnboardingStep2({
    required String restaurantName,
    required String city,
    required String country,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.updateProfile({
        'restaurant_name': restaurantName,
        'city': city,
        'country': country,
      });
      final domain = model.toDomain();
      await isarDb.saveProfile(domain);
      return Right(domain);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, WaiterProfile>> completeOnboardingProfessions({
    required List<String> professions,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model =
          await remoteDataSource.updateProfile({'professions': professions});
      final domain = model.toDomain();
      await isarDb.saveProfile(domain);
      return Right(domain);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaymentAccountInfo>> connectPaymentAccount({
    required String type,
    required String provider,
    required String accountIdentifier,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.connectPaymentAccount({
        'type': type,
        'provider': provider,
        'account_identifier': accountIdentifier,
      });
      final domain = model.toDomain();
      // Reload profile into Isar
      final profile = await remoteDataSource.getProfile();
      await isarDb.saveProfile(profile.toDomain());
      return Right(domain);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PublicWaiterProfile>> getPublicProfile(
      String waiterId) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.getPublicProfile(waiterId);
      return Right(model.toDomain());
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
