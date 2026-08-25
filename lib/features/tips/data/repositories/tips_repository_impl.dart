import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/storage/isar_database_service.dart';
import '../../domain/entities/tip.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/tips_repository.dart';
import '../datasources/tips_remote_datasource.dart';
import '../models/tip_model.dart';
import '../models/wallet_model.dart';

class TipsRepositoryImpl implements TipsRepository {
  final TipsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final IsarDatabaseService isarDb;

  TipsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.isarDb,
  });

  // ── Tips ──────────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, List<Tip>>> getTips({
    TipFilter filter = TipFilter.all,
    int page = 1,
    int pageSize = 20,
  }) async {
    final filterStr = _filterToString(filter);
    final online = await networkInfo.isConnected;

    if (online) {
      try {
        final models = await remoteDataSource.getTips(
          filter: filterStr,
          page: page,
          pageSize: pageSize,
        );
        final domainList = models.map((m) => m.toDomain()).toList();
        // Save to local Isar store
        await isarDb.saveTips(domainList, '');
        return Right(domainList);
      } on AuthenticationException catch (e) {
        return Left(AuthenticationFailure(message: e.message));
      } catch (e) {
        // Fall back to Isar cache
        return _tipsFromIsar(filterStr, page, pageSize);
      }
    }

    // Offline — serve from Isar
    return _tipsFromIsar(filterStr, page, pageSize);
  }

  Future<Either<Failure, List<Tip>>> _tipsFromIsar(
      String? filter, int page, int pageSize) async {
    final tips = await isarDb.getTips(
      filter: filter,
      page: page,
      pageSize: pageSize,
    );
    if (tips.isEmpty) {
      return const Left(NetworkFailure(
        message: 'No internet connection and no cached tips available.',
      ));
    }
    return Right(tips);
  }

  // ── Single tip ────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, Tip>> getTip(String id) async {
    final online = await networkInfo.isConnected;

    if (online) {
      try {
        final model = await remoteDataSource.getTip(id);
        final domain = model.toDomain();
        await isarDb.saveTip(domain);
        return Right(domain);
      } catch (_) {
        final cached = await isarDb.getTip(id);
        if (cached != null) return Right(cached);
        return const Left(ServerFailure(message: 'Tip not found'));
      }
    }

    final cached = await isarDb.getTip(id);
    if (cached != null) return Right(cached);
    return const Left(NetworkFailure(
      message: 'No internet connection and tip is not cached.',
    ));
  }

  // ── Stats ─────────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, TipStats>> getTipStats() async {
    final online = await networkInfo.isConnected;

    if (online) {
      try {
        final model = await remoteDataSource.getTipStats();
        final domain = model.toDomain();
        await isarDb.saveTipStats(domain, '');
        return Right(domain);
      } on AuthenticationException catch (e) {
        return Left(AuthenticationFailure(message: e.message));
      } catch (_) {
        return _statsFromIsar();
      }
    }

    return _statsFromIsar();
  }

  Future<Either<Failure, TipStats>> _statsFromIsar() async {
    final cached = await isarDb.getTipStats();
    if (cached != null) return Right(cached);
    return const Left(NetworkFailure(
      message: 'No internet connection and no cached stats available.',
    ));
  }

  // ── Wallet ────────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, Wallet>> getWallet() async {
    final online = await networkInfo.isConnected;

    if (online) {
      try {
        final model = await remoteDataSource.getWallet();
        final domain = model.toDomain();
        await isarDb.saveWallet(domain, domain.waiterId);
        return Right(domain);
      } on AuthenticationException catch (e) {
        return Left(AuthenticationFailure(message: e.message));
      } catch (_) {
        return _walletFromIsar();
      }
    }

    return _walletFromIsar();
  }

  Future<Either<Failure, Wallet>> _walletFromIsar() async {
    final cached = await isarDb.getWallet();
    if (cached != null) return Right(cached);
    // Return zero wallet rather than an error for seamless offline UX
    return const Right(Wallet(
      waiterId: '',
      availableBalance: 0,
      pendingBalance: 0,
      currency: 'BIF',
    ));
  }

  // ── Transactions ──────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, List<WalletTransaction>>> getTransactions({
    int page = 1,
    int pageSize = 20,
  }) async {
    final online = await networkInfo.isConnected;

    if (online) {
      try {
        final models = await remoteDataSource.getTransactions(
          page: page,
          pageSize: pageSize,
        );
        final domainList = models.map((m) => m.toDomain()).toList();
        await isarDb.saveTransactions(domainList, '');
        return Right(domainList);
      } on AuthenticationException catch (e) {
        return Left(AuthenticationFailure(message: e.message));
      } catch (_) {
        return _transactionsFromIsar(page, pageSize);
      }
    }

    return _transactionsFromIsar(page, pageSize);
  }

  Future<Either<Failure, List<WalletTransaction>>> _transactionsFromIsar(
      int page, int pageSize) async {
    final list = await isarDb.getTransactions(page: page, pageSize: pageSize);
    return Right(list);
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String? _filterToString(TipFilter filter) {
    switch (filter) {
      case TipFilter.today:
        return 'today';
      case TipFilter.thisWeek:
        return 'week';
      case TipFilter.thisMonth:
        return 'month';
      case TipFilter.all:
        return null;
    }
  }
}
