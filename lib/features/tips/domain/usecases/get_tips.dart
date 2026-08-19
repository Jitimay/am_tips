import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/tip.dart';
import '../repositories/tips_repository.dart';

class GetTips {
  final TipsRepository repository;
  GetTips(this.repository);

  Future<Either<Failure, List<Tip>>> call({
    TipFilter filter = TipFilter.all,
    int page = 1,
    int pageSize = 20,
  }) =>
      repository.getTips(filter: filter, page: page, pageSize: pageSize);
}
