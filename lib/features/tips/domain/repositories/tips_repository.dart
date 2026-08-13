import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/tip.dart';
import '../entities/wallet.dart';

enum TipFilter { today, thisWeek, thisMonth, all }

abstract class TipsRepository {
  Future<Either<Failure, List<Tip>>> getTips({
    TipFilter filter = TipFilter.all,
    int page = 1,
    int pageSize = 20,
  });

  Future<Either<Failure, Tip>> getTip(String id);

  Future<Either<Failure, TipStats>> getTipStats();

  Future<Either<Failure, Wallet>> getWallet();

  Future<Either<Failure, List<WalletTransaction>>> getTransactions({
    int page = 1,
    int pageSize = 20,
  });
}
