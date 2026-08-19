import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/tip.dart';
import '../repositories/tips_repository.dart';

class GetTip {
  final TipsRepository repository;
  GetTip(this.repository);

  Future<Either<Failure, Tip>> call(String id) => repository.getTip(id);
}
