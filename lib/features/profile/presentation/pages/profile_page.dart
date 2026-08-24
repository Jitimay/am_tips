import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/star_rating.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push(AppRoutes.editProfile),
            tooltip: 'Edit profile',
          ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileError) {
            return ErrorState(
              message: state.message,
              onRetry: () =>
                  context.read<ProfileBloc>().add(const LoadProfile()),
            );
          }

          final profile = state is ProfileLoaded
              ? state.profile
              : state is ProfileUpdateSuccess
                  ? state.profile
                  : null;
          if (profile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final hasProfessions = profile.professions.isNotEmpty;
          final hasWorkplace = profile.restaurantName.isNotEmpty;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // ── Avatar + name ────────────────────────────────────────
                Center(
                  child: Column(
                    children: [
                      AvatarWidget(
                        name: profile.fullName,
                        imageUrl: profile.avatarUrl,
                        radius: 48,
                      ),
                      const SizedBox(height: 14),
                      Text(profile.fullName, style: AppTextStyles.h2),
                      const SizedBox(height: 8),

                      // ── Profession chips ─────────────────────────────
                      if (hasProfessions)
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 6,
                          runSpacing: 6,
                          children: profile.professions.map((p) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primarySurface,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.primary
                                      .withValues(alpha: 0.25),
                                ),
                              ),
                              child: Text(
                                p,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                      // ── Workplace (if set) ───────────────────────────
                      if (hasWorkplace) ...[
                        const SizedBox(height: 8),
                        Text(
                          profile.restaurantName,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],

                      const SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 14,
                              color: AppColors.textSecondary),
                          const SizedBox(width: 3),
                          Text(
                            '${profile.city}, ${profile.country}',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),

                      // ── Rating ───────────────────────────────────────
                      if (profile.totalRatings > 0) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            StarRating(
                                rating: profile.averageRating.round(),
                                size: 18),
                            const SizedBox(width: 6),
                            Text(
                              '${profile.averageRating.toStringAsFixed(1)} (${profile.totalRatings} ratings)',
                              style: AppTextStyles.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Personal message ─────────────────────────────────────
                if (profile.personalMessage != null &&
                    profile.personalMessage!.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          AppColors.primary.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: AppColors.primary
                              .withValues(alpha: 0.15)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.format_quote_rounded,
                            color: AppColors.primary, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            profile.personalMessage!,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),

                // ── Info cards ────────────────────────────────────────────
                // Professions card — shown when set
                if (hasProfessions)
                  _InfoCard(
                    icon: Icons.work_outline_rounded,
                    label: 'What I do',
                    value: profile.professions
                        .map((p) =>
                            p.split(' ').skip(1).join(' '))
                        .join(' · '),
                  ),
                if (hasProfessions) const SizedBox(height: 10),

                // Workplace — only shown when not empty, with adaptive label
                if (hasWorkplace)
                  _InfoCard(
                    icon: Icons.business_outlined,
                    label: _workplaceLabel(profile.professions),
                    value: profile.restaurantName,
                  ),
                if (hasWorkplace) const SizedBox(height: 10),

                _InfoCard(
                  icon: Icons.location_on_outlined,
                  label: 'Location',
                  value: '${profile.city}, ${profile.country}',
                ),

                if (profile.connectedPaymentAccount != null) ...[
                  const SizedBox(height: 10),
                  _InfoCard(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Payment account',
                    value:
                        '${profile.connectedPaymentAccount!.provider} · ${profile.connectedPaymentAccount!.accountIdentifier}',
                  ),
                ],
                const SizedBox(height: 32),

                AppButton(
                  label: 'Edit Profile',
                  onPressed: () => context.push(AppRoutes.editProfile),
                  variant: AppButtonVariant.outline,
                ),
                const SizedBox(height: 12),
                AppButton(
                  label: 'Log Out',
                  onPressed: () => _confirmLogout(context),
                  variant: AppButtonVariant.danger,
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Returns a label for the workplace card that fits the person's professions.
  String _workplaceLabel(List<String> professions) {
    if (professions.any((p) =>
        p.contains('Waiter') ||
        p.contains('Chef') ||
        p.contains('Barista') ||
        p.contains('Hotel'))) {
      return 'Restaurant / Venue';
    }
    if (professions.any((p) =>
        p.contains('Musician') ||
        p.contains('Theater') ||
        p.contains('Dancer') ||
        p.contains('Band'))) {
      return 'Club / Stage';
    }
    if (professions.any((p) =>
        p.contains('YouTuber') ||
        p.contains('Streamer') ||
        p.contains('Content') ||
        p.contains('Podcaster'))) {
      return 'Channel / Platform';
    }
    if (professions.any(
        (p) => p.contains('Taxi') || p.contains('Moto'))) {
      return 'Operator';
    }
    return 'Workplace / Venue';
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<AuthBloc>().add(const LogoutRequested());
              context.go(AppRoutes.login);
            },
            child: Text('Log out', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: Theme.of(context).colorScheme.outline),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color:
                  AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                Icon(icon, size: 18, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.caption),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTextStyles.labelMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
