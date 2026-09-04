import 'package:equatable/equatable.dart';
import '../../domain/entities/campaign.dart';

abstract class CampaignState extends Equatable {
  const CampaignState();
  @override
  List<Object?> get props => [];
}

class CampaignInitial extends CampaignState {
  const CampaignInitial();
}

class CampaignLoading extends CampaignState {
  const CampaignLoading();
}

class CampaignLoaded extends CampaignState {
  final List<Campaign> campaigns;
  const CampaignLoaded(this.campaigns);
  @override
  List<Object?> get props => [campaigns];
}

class CampaignSaving extends CampaignState {
  const CampaignSaving();
}

class CampaignSaved extends CampaignState {
  final Campaign campaign;
  const CampaignSaved(this.campaign);
  @override
  List<Object?> get props => [campaign];
}

class CampaignDeleted extends CampaignState {
  const CampaignDeleted();
}

class CampaignError extends CampaignState {
  final String message;
  const CampaignError(this.message);
  @override
  List<Object?> get props => [message];
}
