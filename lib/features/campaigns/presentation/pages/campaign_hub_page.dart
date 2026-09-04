import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../bloc/campaign_bloc.dart';
import '../bloc/campaign_event.dart';
import '../bloc/campaign_state.dart';

/// The campaign tab landing page.
///
/// Clearly separates two distinct actions:
///   🖼️  New Card   — personal shareable image (WhatsApp, Instagram story, etc.)
///   🎯  New Campaign — public goal shown to customers on the tip page
class CampaignHubPage extends StatefulWidget {
  const CampaignHubPage({super.key});

  @override
  State<CampaignHubPage> createState() => _CampaignHubPageState();
}

class _CampaignHubPageState extends State<CampaignHubPage> {
  @override
  void initState() {
    super.initState();
    context.read<CampaignBloc>().add(const LoadCampaigns());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
        centerTitle: true,
        actions: [
          // Shortcut to view existing campaigns
          TextButton(
            onPressed: () => context.push(AppRoutes.campaignList),
            child: Text(
              'My Campaigns',
              style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Header ───────────────────────────────────────────────────
              Text(
                'What do you want to create?',
                style: AppTextStyles.h2,
              ),
              const SizedBox(height: 6),
              Text(
                'Choose one option below.',
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
              ),

              const SizedBox(height: 28),

              // ── New Card (personal) ───────────────────────────────────────
              _OptionCard(
                imagePath: 'assets/images/card.png',
                badge: 'PERSONAL',
                badgeColor: AppColors.primary,
                title: 'New Card',
                subtitle:
                    'A beautiful shareable image for your WhatsApp status, '
                    'Instagram story, or social media. Only you decide who sees it.',
                bulletPoints: const [
                  'Custom occasion (Birthday, Christmas, Anniversary…)',
                  'Your photo + personal message',
                  'QR code embedded — people can scan to tip',
                  'Download or share as image',
                ],
                gradientColors: const [Color(0xFF8B72F0), Color(0xFF5E3DD0)],
                onTap: () => context.push(AppRoutes.campaignCard),
              ),

              const SizedBox(height: 16),

              // ── New Campaign (public) ─────────────────────────────────────
              _OptionCard(
                imagePath: 'assets/images/campain.png',
                badge: 'PUBLIC',
                badgeColor: const Color(0xFF2ECC71),
                title: 'New Campaign',
                subtitle:
                    'A public tip goal that customers see when they scan '
                    'your QR code. Track progress and motivate supporters.',
                bulletPoints: const [
                  'Set a goal (e.g. 100,000 BIF for new equipment)',
                  'Shows progress bar on your tip page',
                  'Customers see your goal when they tip you',
                  'Activate / deactivate anytime',
                ],
                gradientColors: const [Color(0xFF2ECC71), Color(0xFF1A8A4A)],
                onTap: () => context.push(AppRoutes.campaignForm),
              ),

              const SizedBox(height: 20),

              // ── Active campaign badge ────────────────────────────────────
              BlocBuilder<CampaignBloc, CampaignState>(
                builder: (context, state) {
                  if (state is! CampaignLoaded) return const SizedBox.shrink();
                  final active =
                      state.campaigns.where((c) => c.isActive).length;
                  if (active == 0) return const SizedBox.shrink();
                  return GestureDetector(
                    onTap: () => context.push(AppRoutes.campaignList),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.25)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.accent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '$active active campaign${active > 1 ? 's' : ''} running',
                              style: AppTextStyles.labelSmall
                                  .copyWith(color: AppColors.primary),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded,
                              size: 12, color: AppColors.primary),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Option card
// ─────────────────────────────────────────────────────────────────────────────

class _OptionCard extends StatelessWidget {
  final String imagePath;
  final String badge;
  final Color badgeColor;
  final String title;
  final String subtitle;
  final List<String> bulletPoints;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const _OptionCard({
    required this.imagePath,
    required this.badge,
    required this.badgeColor,
    required this.title,
    required this.subtitle,
    required this.bulletPoints,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Gradient header ──────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image replacing emoji
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imagePath,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox(
                        width: 56,
                        height: 56,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Title + badge
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 6,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              title,
                              style: AppTextStyles.h3
                                  .copyWith(color: Colors.white),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.22),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                badge,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white.withValues(alpha: 0.88),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      size: 16, color: Colors.white70),
                ],
              ),
            ),

            // ── Bullet points ────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
              child: Column(
                children: bulletPoints
                    .map(
                      (point) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: badgeColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                point,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
