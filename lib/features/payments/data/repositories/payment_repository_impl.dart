import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_datasource.dart';

/// PaymentRepositoryImpl wraps the AfriPay-backed datasource.
/// The old Dio-based methods (initiatePayment, checkPaymentStatus, getFeeBreakdown)
/// are replaced by the AfriPay flow in CustomerTipBloc.
/// This repository now only exposes getPaymentMethods() for the BLoC.
class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PaymentRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods() async {
    try {
      final dtos = remoteDataSource.getPaymentMethods();
      final methods = dtos
          .map((d) => PaymentMethod(
                id: d.id,
                name: d.name,
                provider: d.provider,
                type: _parseType(d.type),
                isAvailable: d.isAvailable,
                description: d.description,
              ))
          .toList();
      return Right(methods);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaymentResult>> initiatePayment({
    required String tipId,
    required String methodId,
    required String idempotencyKey,
  }) async {
    // Payment initiation is handled by CustomerTipBloc via AfriPayService.
    // This method is kept for interface compliance only.
    return const Left(ServerFailure(
      message: 'Use CustomerTipBloc.AfriPayCheckoutStarted to initiate payments.',
    ));
  }

  @override
  Future<Either<Failure, PaymentStatus>> checkPaymentStatus(
      String paymentId) async {
    return const Left(ServerFailure(
      message: 'Use CustomerTipBloc.PaymentStatusPolled to check status.',
    ));
  }

  @override
  Future<Either<Failure, TipFeeBreakdown>> getFeeBreakdown({
    required int amount,
    required String currency,
  }) async {
    try {
      final dto = remoteDataSource.getFeeBreakdown(
        tipAmount: amount,
        currency: currency,
      );
      return Right(TipFeeBreakdown(
        tipAmount: dto.tipAmount,
        platformFee: dto.platformFee,
        waiterReceives: dto.waiterReceives,
        currency: dto.currency,
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  PaymentMethodType _parseType(String t) {
    switch (t.toLowerCase()) {
      case 'mobile_money':
        return PaymentMethodType.mobileMoney;
      case 'card':
        return PaymentMethodType.card;
      case 'bank':
        return PaymentMethodType.bank;
      default:
        return PaymentMethodType.mobileMoney;
    }
  }
}
