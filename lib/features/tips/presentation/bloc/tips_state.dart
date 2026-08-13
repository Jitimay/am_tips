part of 'tips_bloc.dart';

abstract class TipsState extends Equatable {
  const TipsState();
  @override
  List<Object?> get props => [];
}

class TipsInitial extends TipsState {
  const TipsInitial();
}

class TipsLoading extends TipsState {
  const TipsLoading();
}

class TipsLoaded extends TipsState {
  final List<Tip> tips;
  final TipStats? stats;
  final TipFilter activeFilter;

  const TipsLoaded({
    required this.tips,
    this.stats,
    this.activeFilter = TipFilter.all,
  });

  TipsLoaded copyWith({
    List<Tip>? tips,
    TipStats? stats,
    TipFilter? activeFilter,
  }) =>
      TipsLoaded(
        tips: tips ?? this.tips,
        stats: stats ?? this.stats,
        activeFilter: activeFilter ?? this.activeFilter,
      );

  @override
  List<Object?> get props => [tips, stats, activeFilter];
}

class TipDetailLoaded extends TipsState {
  final Tip tip;
  const TipDetailLoaded(this.tip);
  @override
  List<Object?> get props => [tip];
}

class TipsError extends TipsState {
  final String message;
  const TipsError(this.message);
  @override
  List<Object?> get props => [message];
}
