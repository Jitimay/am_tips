import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/profile_repository.dart';

class UploadAvatar {
  final ProfileRepository repository;
  UploadAvatar(this.repository);

  Future<Either<Failure, String>> call(String filePath) =>
      repository.uploadAvatar(filePath);
}
