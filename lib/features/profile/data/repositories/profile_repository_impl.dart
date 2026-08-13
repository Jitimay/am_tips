import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/waiter_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, WaiterProfile>> getProfile() async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.getProfile();
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, WaiterProfile>> updateProfile({
    String? fullName,
    String? restaurantName,
    String? city,
    String? country,
    String? personalMessage,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final data = <String, dynamic>{
        if (fullName != null) 'full_name': fullName,
        if (restaurantName != null) 'restaurant_name': restaurantName,
        if (city != null) 'city': city,
        if (country != null) 'country': country,
        if (personalMessage != null) 'personal_message': personalMessage,
      };
      final model = await remoteDataSource.updateProfile(data);
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> uploadAvatar(String filePath) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final url = await remoteDataSource.uploadAvatar(filePath);
      return Right(url);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, WaiterProfile>> completeOnboardingStep1({
    required String fullName,
    String? avatarPath,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      if (avatarPath != null) {
        await remoteDataSource.uploadAvatar(avatarPath);
      }
      final model = await remoteDataSource.updateProfile({'full_name': fullName});
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
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
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
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
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PublicWaiterProfile>> getPublicProfile(
      String waiterId) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await remoteDataSource.getPublicProfile(waiterId);
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
