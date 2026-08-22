import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/campaign.dart';

abstract class CampaignRepository {
  /// Fetches all campaigns created by the current user.
  Future<Either<Failure, List<Campaign>>> getCampaigns({bool? activeOnly});

  /// Fetches a single campaign by its ID.
  Future<Either<Failure, Campaign>> getCampaign(String id);

  /// Fetches a public campaign for customer display.
  Future<Either<Failure, Campaign>> getPublicCampaign(String id);

  /// Creates a new tip campaign.
  Future<Either<Failure, Campaign>> createCampaign(Campaign campaign);

  /// Updates an existing campaign.
  Future<Either<Failure, Campaign>> updateCampaign(Campaign campaign);

  /// Toggles active status of a campaign.
  Future<Either<Failure, Campaign>> toggleCampaignStatus(String id, bool isActive);

  /// Deletes a campaign.
  Future<Either<Failure, void>> deleteCampaign(String id);
}
