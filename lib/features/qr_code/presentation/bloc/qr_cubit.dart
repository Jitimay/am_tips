import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/qr_code.dart';
import '../../domain/repositories/qr_repository.dart';

part 'qr_state.dart';

class QrCubit extends Cubit<QrState> {
  final QrRepository qrRepository;

  QrCubit({required this.qrRepository}) : super(const QrInitial());

  Future<void> loadQrCode() async {
    emit(const QrLoading());
    final result = await qrRepository.getMyQrCode();
    result.fold(
      (failure) => emit(QrError(failure.message)),
      (qr) => emit(QrLoaded(qr)),
    );
  }

  Future<void> regenerate() async {
    emit(const QrLoading());
    final result = await qrRepository.regenerateQrCode();
    result.fold(
      (failure) => emit(QrError(failure.message)),
      (qr) => emit(QrLoaded(qr)),
    );
  }

  void startSharing(QrCode qr) => emit(QrSharing(qr));
  void stopSharing(QrCode qr) => emit(QrLoaded(qr));
}
