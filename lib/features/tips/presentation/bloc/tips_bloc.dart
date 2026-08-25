import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/tip.dart';
import '../../domain/repositories/tips_repository.dart';

part 'tips_event.dart';
part 'tips_state.dart';

class TipsBloc extends Bloc<TipsEvent, TipsState> {
  final TipsRepository tipsRepository;

  TipsBloc({required this.tipsRepository}) : super(const TipsInitial()) {
    on<LoadTips>(_onTipsLoaded);
    on<TipsFilterChanged>(_onFilterChanged);
    on<TipDetailRequested>(_onDetailRequested);
    on<TipStatsRequested>(_onStatsRequested);
  }

  Future<void> _onTipsLoaded(LoadTips event, Emitter<TipsState> emit) async {
    // Show loading indicator but keep existing tips visible if we have them
    final existing = state.tips;
    if (existing.isEmpty) {
      emit(const TipsLoading());
    }

    final tipsResult = await tipsRepository.getTips(filter: event.filter);
    final statsResult = await tipsRepository.getTipStats();

    tipsResult.fold(
      (failure) {
        // Only show error if we have nothing to show
        if (existing.isEmpty) {
          emit(TipsError(failure.message));
        } else {
          emit(TipsLoaded(
            tips: existing,
            stats: state.stats,
            activeFilter: event.filter,
          ));
        }
      },
      (tips) {
        final stats = statsResult.fold((_) => state.stats, (s) => s);
        emit(TipsLoaded(
          tips: tips,
          stats: stats,
          activeFilter: event.filter,
        ));
      },
    );
  }

  Future<void> _onFilterChanged(
      TipsFilterChanged event, Emitter<TipsState> emit) async {
    // Keep existing tips visible while loading the filtered results
    final currentStats =
        state is TipsLoaded ? (state as TipsLoaded).stats : null;
    final existing = state.tips;

    // Only blank the screen if we have nothing cached
    if (existing.isEmpty) {
      emit(TipsLoading());
    }

    final result = await tipsRepository.getTips(filter: event.filter);
    result.fold(
      (failure) {
        if (existing.isEmpty) {
          emit(TipsError(failure.message));
        } else {
          emit(TipsLoaded(
            tips: existing,
            stats: currentStats,
            activeFilter: event.filter,
          ));
        }
      },
      (tips) => emit(TipsLoaded(
        tips: tips,
        stats: currentStats,
        activeFilter: event.filter,
      )),
    );
  }

  Future<void> _onDetailRequested(
      TipDetailRequested event, Emitter<TipsState> emit) async {
    final currentTips = state.tips;
    final currentStats = state.stats;
    final currentFilter = state is TipsLoaded
        ? (state as TipsLoaded).activeFilter
        : state is TipDetailLoaded
            ? (state as TipDetailLoaded).activeFilter
            : TipFilter.all;

    final existingTip = currentTips.where((t) => t.id == event.tipId).firstOrNull;
    if (existingTip != null) {
      emit(TipDetailLoaded(
        existingTip,
        tips: currentTips,
        stats: currentStats,
        activeFilter: currentFilter,
      ));
    }

    final result = await tipsRepository.getTip(event.tipId);
    result.fold(
      (failure) {
        if (existingTip == null) {
          emit(TipsError(failure.message));
        }
      },
      (tip) => emit(TipDetailLoaded(
        tip,
        tips: currentTips,
        stats: currentStats,
        activeFilter: currentFilter,
      )),
    );
  }

  Future<void> _onStatsRequested(
      TipStatsRequested event, Emitter<TipsState> emit) async {
    final result = await tipsRepository.getTipStats();
    result.fold(
      (_) {},
      (stats) {
        if (state is TipsLoaded) {
          emit((state as TipsLoaded).copyWith(stats: stats));
        }
      },
    );
  }
}
