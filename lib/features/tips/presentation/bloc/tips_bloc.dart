import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/tip.dart';
import '../../domain/repositories/tips_repository.dart';

part 'tips_event.dart';
part 'tips_state.dart';

class TipsBloc extends Bloc<TipsEvent, TipsState> {
  final TipsRepository tipsRepository;

  TipsBloc({required this.tipsRepository}) : super(const TipsInitial()) {
    on<TipsLoaded>(_onTipsLoaded);
    on<TipsFilterChanged>(_onFilterChanged);
    on<TipDetailRequested>(_onDetailRequested);
    on<TipStatsRequested>(_onStatsRequested);
  }

  Future<void> _onTipsLoaded(TipsLoaded event, Emitter<TipsState> emit) async {
    emit(const TipsLoading());
    final tipsResult = await tipsRepository.getTips(filter: event.filter);
    final statsResult = await tipsRepository.getTipStats();

    tipsResult.fold(
      (failure) => emit(TipsError(failure.message)),
      (tips) {
        final stats = statsResult.fold((_) => null, (s) => s);
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
    final currentStats =
        state is TipsLoaded ? (state as TipsLoaded).stats : null;
    emit(TipsLoading());
    final result = await tipsRepository.getTips(filter: event.filter);
    result.fold(
      (failure) => emit(TipsError(failure.message)),
      (tips) => emit(TipsLoaded(
        tips: tips,
        stats: currentStats,
        activeFilter: event.filter,
      )),
    );
  }

  Future<void> _onDetailRequested(
      TipDetailRequested event, Emitter<TipsState> emit) async {
    final result = await tipsRepository.getTip(event.tipId);
    result.fold(
      (failure) => emit(TipsError(failure.message)),
      (tip) => emit(TipDetailLoaded(tip)),
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
