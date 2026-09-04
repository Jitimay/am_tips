import 'package:dartz/dartz.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/network/network_info.dart';
import '../../payments/data/datasources/payment_remote_datasource.dart';
import '../../payments/data/services/afripay_service.dart';
import '../../profile/data/models/waiter_profile_model.dart';
import '../../profile/domain/entities/waiter_profile.dart';
import '../../tips/data/models/tip_model.dart';
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
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Either<Failure, AfriPayFeeDto> getFeeBreakdown({
    required int tipAmount,
    required String currency,
  }) {
    try {
      final fee = dataSource.getFeeBreakdown(
        tipAmount: tipAmount,
        currency: currency,
      );
      return Right(fee);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Tip>> insertTip({
    required String waiterId,
    required int amount,
    required String currency,
    required bool isAnonymous,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final model = await dataSource.insertTip(
        waiterId: waiterId,
        amount: amount,
        currency: currency,
        isAnonymous: isAnonymous,
      );
      return Right(model.toDomain());
    } on ServerException catch (e) {
      return Left(PaymentFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(PaymentFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AfriPayCheckoutDto>> initiateAfriPayCheckout({
    required String tipId,
    required String waiterId,
    required String waiterName,
    required int tipAmount,
    required String currency,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final dto = await dataSource.initiateAfriPayCheckout(
        tipId: tipId,
        waiterId: waiterId,
        waiterName: waiterName,
        tipAmount: tipAmount,
        currency: currency,
      );
      return Right(dto);
    } on PaymentException catch (e) {
      return Left(PaymentFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(PaymentFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> sendC2BRequest({
    required String clientToken,
    required int amount,
    required String currency,
    required String paymentMethod,
    required String phone,
    required String waiterName,
    String? otp,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final result = await dataSource.sendC2BRequest(
        clientToken: clientToken,
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
        phone: phone,
        waiterName: waiterName,
        otp: otp,
      );
      return Right(result);
    } on PaymentException catch (e) {
      return Left(PaymentFailure(message: e.message));
    } catch (e) {
      return Left(PaymentFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> requestOtp({
    required String phone,
    required String paymentMethod,
  }) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());
    try {
      final result = await dataSource.requestOtp(
        phone: phone,
        paymentMethod: paymentMethod,
      );
      return Right(result);
    } on PaymentException catch (e) {
      return Left(PaymentFailure(message: e.message));
    } catch (e) {
      return Left(PaymentFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> pollPaymentStatus(
      String clientToken) async {
    try {
      final status = await dataSource.pollPaymentStatus(clientToken);
      return Right(status);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> getCompletedPayment(
      String clientToken) async {
    try {
      final row = await dataSource.getCompletedPayment(clientToken);
      return Right(row);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> submitFeedback({
    required String tipId,
    int? rating,
    String? message,
  }) async {
    try {
      await dataSource.submitFeedback(
          tipId: tipId, rating: rating, message: message);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<List<AfriPayMethodDto>> getPaymentMethods(String currency) async {
    try {
      return await dataSource.getPaymentMethods(currency);
    } catch (e) {
      return AfriPayService.fallbackMethods();
    }
  }

  @override
  Future<Map<String, dynamic>?> getActiveCampaign(String waiterId) =>
      dataSource.getActiveCampaign(waiterId);
}
