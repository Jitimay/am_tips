part of 'qr_cubit.dart';

abstract class QrState extends Equatable {
  const QrState();
  @override
  List<Object?> get props => [];
}

class QrInitial extends QrState {
  const QrInitial();
}

class QrLoading extends QrState {
  const QrLoading();
}

class QrLoaded extends QrState {
  final QrCode qrCode;
  const QrLoaded(this.qrCode);
  @override
  List<Object?> get props => [qrCode];
}

class QrError extends QrState {
  final String message;
  const QrError(this.message);
  @override
  List<Object?> get props => [message];
}

class QrSharing extends QrState {
  final QrCode qrCode;
  const QrSharing(this.qrCode);
  @override
  List<Object?> get props => [qrCode];
}
