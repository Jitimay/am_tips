import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/stat_card.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../tips/presentation/bloc/tips_bloc.dart';
import '../../../tips/presentation/bloc/wallet_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileLoaded());
    context.read<TipsBloc>().add(const TipsLoaded());
    context.read<WalletCubit>().loadWallet();
  }

  Future<void> _refresh() async {
    context.read<ProfileBloc>().add(const ProfileLoaded());
    context.read<TipsBloc>().add(const TipsLoaded());
    context.read<WalletCubit>().refreshWallet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          color: AppColors.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              _buildAppBar(context),
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _WalletCard(),
                    const SizedBox(height: 24),
                    _StatsGrid(),
                    const SizedBox(height: 24),
                    _QuickActions(),
                    const SizedBox(height: 24),
                    _RecentTips(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final name = state is ProfileLoaded
              ? state.profile.fullName.split(' ').first
              : '';
          final avatarUrl =
              state is ProfileLoaded ? state.profile.avatarUrl : null;
          return Row(
            children: [
              AvatarWidget(
                name: name.isEmpty ? 'You' : name,
                imageUrl: avatarUrl,
                radius: 18,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name.isNotEmpty ? 'Hello, $name 👋' : 'Hello 👋',
                    style: AppTextStyles.labelLarge,
                  ),
                  Text(
                    'Here\'s your tip summary',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ],
          );
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () => context.push(AppRoutes.notifications),
          tooltip: 'Notifications',
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => context.push(AppRoutes.settings),
          tooltip: 'Settings',
        ),
      ],
    );
  }
}

// ── Wallet hero card ───────────────────────────────────────────────────────

class _WalletCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        final isLoading = state is WalletLoading;
        final balance = state is WalletLoaded
            ? CurrencyFormatter.formatNumber(
                state.wallet.availableBalance, state.wallet.currency)
            : '—';
        final currency =
            state is WalletLoaded ? state.wallet.currency : AppConstants.defaultCurrency;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: AppColors.walletGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.25),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Balance',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      currency,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (isLoading)
                Container(
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                )
              else
                Text(
                  balance,
                  style: AppTextStyles.amountLarge.copyWith(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => context.go('/wallet/withdraw'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.north_rounded, size: 18),
                      label: const Text('Withdraw'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => context.go(AppRoutes.qr),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(
                            color: Colors.white, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.qr_code_rounded, size: 18),
                      label: const Text('My QR'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Stats grid ─────────────────────────────────────────────────────────────

class _StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TipsBloc, TipsState>(
      builder: (context, state) {
        if (state is TipsError) {
          return ErrorState(
            message: state.message,
            onRetry: () =>
                context.read<TipsBloc>().add(const TipsLoaded()),
          );
        }
        final isLoading = state is TipsLoading;
        final stats = state is TipsLoaded ? state.stats : null;
        final currency = stats?.currency ?? AppConstants.defaultCurrency;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tip Summary', style: AppTextStyles.h3),
            const SizedBox(height: 14),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                StatCard(
                  label: "Today's Tips",
                  amount: stats != null
                      ? CurrencyFormatter.formatNumber(
                          stats.todayTotal, currency)
                      : '—',
                  currency: currency,
                  icon: Icons.today_rounded,
                  accentColor: AppColors.primary,
                  isLoading: isLoading,
                ),
                StatCard(
                  label: 'This Week',
                  amount: stats != null
                      ? CurrencyFormatter.formatNumber(
                          stats.weekTotal, currency)
                      : '—',
                  currency: currency,
                  icon: Icons.date_range_rounded,
                  accentColor: AppColors.accent,
                  isLoading: isLoading,
                ),
                StatCard(
                  label: 'Total Tips',
                  amount: stats != null
                      ? CurrencyFormatter.formatNumber(
                          stats.allTimeTotal, currency)
                      : '—',
                  currency: currency,
                  icon: Icons.bar_chart_rounded,
                  accentColor: AppColors.warning,
                  isLoading: isLoading,
                ),
                StatCard(
                  label: "Today's Count",
                  amount: stats != null ? '${stats.todayCount}' : '—',
                  currency: 'tips',
                  icon: Icons.people_outline_rounded,
                  accentColor: AppColors.info,
                  isLoading: isLoading,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// ── Quick actions ──────────────────────────────────────────────────────────

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: AppTextStyles.h3),
        const SizedBox(height: 14),
        Row(
          children: [
            _ActionButton(
              icon: Icons.qr_code_rounded,
              label: 'My QR Code',
              color: AppColors.primary,
              onTap: () => context.go(AppRoutes.qr),
            ),
            const SizedBox(width: 12),
            _ActionButton(
              icon: Icons.history_rounded,
              label: 'Tip History',
              color: AppColors.accent,
              onTap: () => context.go(AppRoutes.tips),
            ),
            const SizedBox(width: 12),
            _ActionButton(
              icon: Icons.account_balance_wallet_rounded,
              label: 'Wallet',
              color: AppColors.warning,
              onTap: () => context.go(AppRoutes.wallet),
            ),
            const SizedBox(width: 12),
            _ActionButton(
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              color: AppColors.info,
              onTap: () => context.go(AppRoutes.profile),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Recent tips ────────────────────────────────────────────────────────────

class _RecentTips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TipsBloc, TipsState>(
      builder: (context, state) {
        final tips =
            state is TipsLoaded ? state.tips.take(5).toList() : <dynamic>[];
        final isLoading = state is TipsLoading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Tips', style: AppTextStyles.h3),
                TextButton(
                  onPressed: () => context.go(AppRoutes.tips),
                  child: const Text('See all'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (tips.isEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    'No tips yet. Share your QR code to start!',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tips.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final tip = tips[i];
                  return _TipRow(tip: tip);
                },
              ),
          ],
        );
      },
    );
  }
}

class _TipRow extends StatelessWidget {
  final dynamic tip;
  const _TipRow({required this.tip});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.arrow_downward_rounded,
            color: AppColors.accent, size: 18),
      ),
      title: Text(
        CurrencyFormatter.format(tip.amount as int, tip.currency as String),
        style: AppTextStyles.labelLarge.copyWith(color: AppColors.accent),
      ),
      subtitle: Text(
        tip.isAnonymous == true ? 'Anonymous customer' : (tip.customerName ?? 'Customer'),
        style: AppTextStyles.bodySmall,
      ),
      trailing: Text(
        _formatTime(tip.createdAt as DateTime),
        style: AppTextStyles.caption,
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt.toLocal());
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${dt.toLocal().day}/${dt.toLocal().month}';
  }
}
