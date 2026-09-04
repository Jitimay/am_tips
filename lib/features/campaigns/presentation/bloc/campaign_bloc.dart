import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/campaign.dart';
import '../../domain/repositories/campaign_repository.dart';
import 'campaign_event.dart';
import 'campaign_state.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final CampaignRepository campaignRepository;

  CampaignBloc({required this.campaignRepository}) : super(const CampaignInitial()) {
    on<LoadCampaigns>(_onLoad);
    on<CreateCampaign>(_onCreate);
    on<UpdateCampaign>(_onUpdate);
    on<ToggleCampaignStatus>(_onToggle);
    on<DeleteCampaign>(_onDelete);
  }

  Future<void> _onLoad(LoadCampaigns event, Emitter<CampaignState> emit) async {
    emit(const CampaignLoading());
    final result = await campaignRepository.getCampaigns();
    result.fold(
      (f) => emit(CampaignError(f.message)),
      (list) => emit(CampaignLoaded(list)),
    );
  }

  Future<void> _onCreate(CreateCampaign event, Emitter<CampaignState> emit) async {
    emit(const CampaignSaving());
    final result = await campaignRepository.createCampaign(event.campaign);
    result.fold(
      (f) => emit(CampaignError(f.message)),
      (c) => emit(CampaignSaved(c)),
    );
  }

  Future<void> _onUpdate(UpdateCampaign event, Emitter<CampaignState> emit) async {
    emit(const CampaignSaving());
    final result = await campaignRepository.updateCampaign(event.campaign);
    result.fold(
      (f) => emit(CampaignError(f.message)),
      (c) => emit(CampaignSaved(c)),
    );
  }

  Future<void> _onToggle(ToggleCampaignStatus event, Emitter<CampaignState> emit) async {
    final current = state is CampaignLoaded ? (state as CampaignLoaded).campaigns : <Campaign>[];
    final result = await campaignRepository.toggleCampaignStatus(event.id, event.isActive);
    result.fold(
      (f) => emit(CampaignError(f.message)),
      (updated) {
        if (current.isNotEmpty) {
          final newList = current.map((c) => c.id == updated.id ? updated : c).toList();
          emit(CampaignLoaded(newList));
        } else {
          emit(CampaignSaved(updated));
        }
      },
    );
  }

  Future<void> _onDelete(DeleteCampaign event, Emitter<CampaignState> emit) async {
    final result = await campaignRepository.deleteCampaign(event.id);
    result.fold(
      (f) => emit(CampaignError(f.message)),
      (_) => emit(const CampaignDeleted()),
    );
  }
}
