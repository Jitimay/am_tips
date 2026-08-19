import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/wallet.dart';
import '../repositories/tips_repository.dart';

class GetTransactions {
  final TipsRepository repository;
  GetTransactions(this.repository);

  Future<Either<Failure, List<WalletTransaction>>> call({
    int page = 1,
    int pageSize = 20,
  }) =>
      repository.getTransactions(page: page, pageSize: pageSize);
}
