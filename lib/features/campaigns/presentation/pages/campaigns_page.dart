import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../domain/entities/campaign.dart';
import '../bloc/campaign_bloc.dart';
import '../bloc/campaign_event.dart';
import '../bloc/campaign_state.dart';

class CampaignsPage extends StatefulWidget {
  const CampaignsPage({super.key});

  @override
  State<CampaignsPage> createState() => _CampaignsPageState();
}

class _CampaignsPageState extends State<CampaignsPage> {
  @override
  void initState() {
    super.initState();
    context.read<CampaignBloc>().add(const LoadCampaigns());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campaigns'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () => _openForm(context),
          ),
        ],
      ),
      body: BlocConsumer<CampaignBloc, CampaignState>(
        listener: (context, state) {
          if (state is CampaignSaved || state is CampaignDeleted) {
            context.read<CampaignBloc>().add(const LoadCampaigns());
          }
          if (state is CampaignError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          }
        },
        builder: (context, state) {
          if (state is CampaignLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CampaignError) {
            return ErrorState(
              message: state.message,
              onRetry: () => context.read<CampaignBloc>().add(const LoadCampaigns()),
            );
          }
          final campaigns = state is CampaignLoaded ? state.campaigns : <Campaign>[];
          if (campaigns.isEmpty) {
            return EmptyState(
              icon: Icons.campaign_outlined,
              title: 'No campaigns yet',
              subtitle: 'Create a campaign to collect tips for a special occasion.',
              actionLabel: 'Create Campaign',
              onAction: () => _openForm(context),
            );
          }
          return RefreshIndicator(
            onRefresh: () async =>
                context.read<CampaignBloc>().add(const LoadCampaigns()),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: campaigns.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _CampaignCard(
                campaign: campaigns[i],
                onEdit: () => _openForm(context, campaign: campaigns[i]),
                onShareCard: () => _openCard(context, campaigns[i]),
                onToggle: () => context.read<CampaignBloc>().add(
                      ToggleCampaignStatus(campaigns[i].id, !campaigns[i].isActive),
                    ),
                onDelete: () => _confirmDelete(context, campaigns[i]),
                onShare: () => _share(context, campaigns[i]),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Campaign'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _openForm(BuildContext context, {Campaign? campaign}) {
    context.push(AppRoutes.campaignForm, extra: campaign);
  }

  void _openCard(BuildContext context, Campaign campaign) {
    context.push(AppRoutes.campaignCard, extra: campaign);
  }

  void _share(BuildContext context, Campaign campaign) {
    final profileState = context.read<ProfileBloc>().state;
    final name = profileState is ProfileLoaded ? profileState.profile.fullName : '';
    SharePlus.instance.share(ShareParams(
      text: campaign.getShareText(waiterName: name),
      subject: campaign.title,
    ));
  }

  void _confirmDelete(BuildContext context, Campaign campaign) {
    final bloc = context.read<CampaignBloc>();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Campaign'),
        content: Text('Delete "${campaign.title}"? This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(DeleteCampaign(campaign.id));
            },
            child: const Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  final Campaign campaign;
  final VoidCallback onEdit;
  final VoidCallback onShareCard;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onShare;

  const _CampaignCard({
    required this.campaign,
    required this.onEdit,
    required this.onShareCard,
    required this.onToggle,
    required this.onDelete,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final colors = campaign.category.gradientColors;
    final hasTarget = campaign.targetAmount != null && campaign.targetAmount! > 0;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Gradient header ──────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Text(campaign.emoji, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign.title,
                        style: AppTextStyles.labelMedium.copyWith(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        campaign.category.label,
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white.withValues(alpha: 0.75),
                        ),
                      ),
                    ],
                  ),
                ),
                _StatusChip(isActive: campaign.isActive),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert_rounded, color: Colors.white, size: 20),
                  onSelected: (v) {
                    if (v == 'edit') onEdit();
                    if (v == 'card') onShareCard();
                    if (v == 'toggle') onToggle();
                    if (v == 'share') onShare();
                    if (v == 'delete') onDelete();
                  },
                  itemBuilder: (_) => [
                    const PopupMenuItem(value: 'edit', child: Text('Edit')),
                    const PopupMenuItem(value: 'card', child: Text('Share Card 🖼️')),
                    PopupMenuItem(
                      value: 'toggle',
                      child: Text(campaign.isActive ? 'Deactivate' : 'Activate'),
                    ),
                    const PopupMenuItem(value: 'share', child: Text('Share Link')),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete', style: TextStyle(color: AppColors.error)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Stats ────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (campaign.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      campaign.description,
                      style: AppTextStyles.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                Row(
                  children: [
                    _Stat(
                      label: 'Raised',
                      value: CurrencyFormatter.format(campaign.currentAmount, campaign.currency),
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 20),
                    _Stat(
                      label: 'Tips',
                      value: '${campaign.tipsCount}',
                    ),
                    if (campaign.daysRemaining != null) ...[
                      const SizedBox(width: 20),
                      _Stat(
                        label: 'Days left',
                        value: '${campaign.daysRemaining}',
                        color: campaign.daysRemaining! <= 3 ? AppColors.warning : null,
                      ),
                    ],
                  ],
                ),
                if (hasTarget) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: campaign.progress,
                            backgroundColor: AppColors.divider,
                            valueColor: AlwaysStoppedAnimation(colors.last),
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${campaign.progressPercentage}%',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${campaign.formattedRaised} of ${campaign.formattedTarget}',
                    style: AppTextStyles.caption,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _Stat({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: AppTextStyles.labelMedium.copyWith(color: color ?? AppColors.textPrimary),
        ),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final bool isActive;
  const _StatusChip({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.white.withValues(alpha: 0.25)
            : Colors.black.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: AppTextStyles.caption.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
