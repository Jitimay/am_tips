import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/tip.dart';
import '../repositories/tips_repository.dart';

class GetTipStats {
  final TipsRepository repository;
  GetTipStats(this.repository);

  Future<Either<Failure, TipStats>> call() => repository.getTipStats();
}
