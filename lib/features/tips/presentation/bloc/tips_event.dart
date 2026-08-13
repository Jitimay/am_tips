part of 'tips_bloc.dart';

abstract class TipsEvent extends Equatable {
  const TipsEvent();
  @override
  List<Object?> get props => [];
}

class TipsLoaded extends TipsEvent {
  final TipFilter filter;
  const TipsLoaded({this.filter = TipFilter.all});
  @override
  List<Object?> get props => [filter];
}

class TipsFilterChanged extends TipsEvent {
  final TipFilter filter;
  const TipsFilterChanged(this.filter);
  @override
  List<Object?> get props => [filter];
}

class TipDetailRequested extends TipsEvent {
  final String tipId;
  const TipDetailRequested(this.tipId);
  @override
  List<Object?> get props => [tipId];
}

class TipStatsRequested extends TipsEvent {
  const TipStatsRequested();
}
