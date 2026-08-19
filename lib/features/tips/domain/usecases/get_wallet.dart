import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/wallet.dart';
import '../repositories/tips_repository.dart';

class GetWallet {
  final TipsRepository repository;
  GetWallet(this.repository);

  Future<Either<Failure, Wallet>> call() => repository.getWallet();
}
