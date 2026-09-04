import 'package:equatable/equatable.dart';
import '../../domain/entities/campaign.dart';

abstract class CampaignEvent extends Equatable {
  const CampaignEvent();
  @override
  List<Object?> get props => [];
}

class LoadCampaigns extends CampaignEvent {
  const LoadCampaigns();
}

class CreateCampaign extends CampaignEvent {
  final Campaign campaign;
  const CreateCampaign(this.campaign);
  @override
  List<Object?> get props => [campaign];
}

class UpdateCampaign extends CampaignEvent {
  final Campaign campaign;
  const UpdateCampaign(this.campaign);
  @override
  List<Object?> get props => [campaign];
}

class ToggleCampaignStatus extends CampaignEvent {
  final String id;
  final bool isActive;
  const ToggleCampaignStatus(this.id, this.isActive);
  @override
  List<Object?> get props => [id, isActive];
}

class DeleteCampaign extends CampaignEvent {
  final String id;
  const DeleteCampaign(this.id);
  @override
  List<Object?> get props => [id];
}
