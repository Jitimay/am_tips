import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../payments/data/datasources/payment_remote_datasource.dart';
import '../../profile/domain/entities/waiter_profile.dart';
import '../../tips/domain/entities/tip.dart';

abstract class CustomerTipRepository {
  Future<Either<Failure, PublicWaiterProfile>> getWaiterPublicProfile(
      String waiterId);

  /// Pure local calculation — no network call.
  Either<Failure, AfriPayFeeDto> getFeeBreakdown({
    required int tipAmount,
    required String currency,
  });

  /// Inserts a pending tip row in Supabase.
  Future<Either<Failure, Tip>> insertTip({
    required String waiterId,
    required int amount,
    required String currency,
    required bool isAnonymous,
  });

  /// Creates a pending payment row in Supabase.
  Future<Either<Failure, AfriPayCheckoutDto>> initiateAfriPayCheckout({
    required String tipId,
    required String waiterId,
    required String waiterName,
    required int tipAmount,
    required String currency,
  });

  /// Calls AfriPay C2B API — sends USSD push to [phone].
  Future<Either<Failure, Map<String, dynamic>>> sendC2BRequest({
    required String clientToken,
    required int amount,
    required String currency,
    required String paymentMethod,
    required String phone,
    required String waiterName,
    String? otp,
  });

  /// Requests OTP for methods that require it (e.g. lumicash).
  Future<Either<Failure, Map<String, dynamic>>> requestOtp({
    required String phone,
    required String paymentMethod,
  });

  /// Polls Supabase payments table for current status of [clientToken].
  Future<Either<Failure, String>> pollPaymentStatus(String clientToken);

  /// Returns the completed payment row once AfriPay callback has confirmed.
  Future<Either<Failure, Map<String, dynamic>?>> getCompletedPayment(
      String clientToken);

  Future<Either<Failure, void>> submitFeedback({
    required String tipId,
    int? rating,
    String? message,
  });

  /// Fetches available payment methods from AfriPay API.
  Future<List<AfriPayMethodDto>> getPaymentMethods(String currency);
}
