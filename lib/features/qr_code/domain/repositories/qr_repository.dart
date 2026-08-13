import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/qr_code.dart';

abstract class QrRepository {
  Future<Either<Failure, QrCode>> getMyQrCode();
  Future<Either<Failure, QrCode>> regenerateQrCode();
}
