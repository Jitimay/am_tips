part of 'tips_bloc.dart';

abstract class TipsState extends Equatable {
  const TipsState();
  List<Tip> get tips => const [];
  TipStats? get stats => null;
  Tip? get selectedTip => null;
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
  @override
  final List<Tip> tips;
  @override
  final TipStats? stats;
  final TipFilter activeFilter;
  @override
  final Tip? selectedTip;

  const TipsLoaded({
    required this.tips,
    this.stats,
    this.activeFilter = TipFilter.all,
    this.selectedTip,
  });

  TipsLoaded copyWith({
    List<Tip>? tips,
    TipStats? stats,
    TipFilter? activeFilter,
    Tip? selectedTip,
  }) =>
      TipsLoaded(
        tips: tips ?? this.tips,
        stats: stats ?? this.stats,
        activeFilter: activeFilter ?? this.activeFilter,
        selectedTip: selectedTip ?? this.selectedTip,
      );

  @override
  List<Object?> get props => [tips, stats, activeFilter, selectedTip];
}

class TipDetailLoaded extends TipsState {
  final Tip tip;
  @override
  final List<Tip> tips;
  @override
  final TipStats? stats;
  final TipFilter activeFilter;

  const TipDetailLoaded(
    this.tip, {
    this.tips = const [],
    this.stats,
    this.activeFilter = TipFilter.all,
  });

  @override
  Tip? get selectedTip => tip;

  @override
  List<Object?> get props => [tip, tips, stats, activeFilter];
}

class TipsError extends TipsState {
  final String message;
  const TipsError(this.message);
  @override
  List<Object?> get props => [message];
}
