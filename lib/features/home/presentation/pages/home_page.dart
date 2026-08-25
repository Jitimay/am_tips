import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/shimmer_widgets.dart';
import '../../../notifications/presentation/bloc/notification_bloc.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../tips/presentation/bloc/tips_bloc.dart';
import '../../../tips/presentation/bloc/wallet_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _balanceVisible = true;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const LoadProfile());
    context.read<TipsBloc>().add(const LoadTips());
    context.read<WalletCubit>().loadWallet();
    context.read<NotificationBloc>().add(const NotificationsLoaded());
    _loadBalanceVisibility();
  }

  Future<void> _loadBalanceVisibility() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _balanceVisible = prefs.getBool(AppConstants.balanceVisibleKey) ?? true;
    });
  }

  Future<void> _toggleBalanceVisibility() async {
    final next = !_balanceVisible;
    setState(() => _balanceVisible = next);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.balanceVisibleKey, next);
  }

  Future<void> _refresh() async {
    context.read<ProfileBloc>().add(const LoadProfile());
    context.read<TipsBloc>().add(const LoadTips());
    context.read<WalletCubit>().refreshWallet();
    context.read<NotificationBloc>().add(const NotificationsLoaded());
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          color: AppColors.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // ── Top App Bar ─────────────────────────────────────────────
              SliverToBoxAdapter(child: _buildTopBar(context)),

              // ── Search bar ──────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: GestureDetector(
                    onTap: () => context.push(AppRoutes.search),
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search_rounded,
                              color: AppColors.textHint, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            'Search for someone to tip…',
                            style: AppTextStyles.bodyMedium
                                .copyWith(color: AppColors.textHint),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ── Body ────────────────────────────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildGreetingCard(context),
                    const SizedBox(height: 16),
                    _buildStatsCard(context),
                    const SizedBox(height: 16),
                    _buildActionButtons(context),
                    const SizedBox(height: 16),
                    _buildShortcuts(context),
                    const SizedBox(height: 16),
                    _buildRecentTips(context),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── TOP APP BAR ──────────────────────────────────────────────────────────

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          // Logo
          Image.asset(
            'assets/images/logo.png',
            width: 110,
            height: 60,
          ),
          const Spacer(),
          // Notification bell with real unread count
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              final unread = state is NotificationLoaded ? state.unreadCount : 0;
              return GestureDetector(
                onTap: () => context.push(AppRoutes.notifications),
                child: Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: const Icon(Icons.notifications_outlined,
                          color: AppColors.textPrimary, size: 20),
                    ),
                    if (unread > 0)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              unread > 9 ? '9+' : '$unread',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          // Scan QR button
          GestureDetector(
            onTap: () => context.push(AppRoutes.scanner),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                shape: BoxShape.circle,
                border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3)),
              ),
              child: const Icon(Icons.qr_code_scanner_rounded,
                  color: AppColors.primary, size: 20),
            ),
          ),
          const SizedBox(width: 8),
          // Profile icon
          GestureDetector(
            onTap: () => context.go(AppRoutes.profile),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.divider),
              ),
              child: const Icon(Icons.person_outline_rounded,
                  color: AppColors.textPrimary, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  // ── GREETING CARD ────────────────────────────────────────────────────────

  Widget _buildGreetingCard(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final profile = state.profile;
        final firstName = (profile != null && profile.fullName.trim().isNotEmpty)
            ? profile.fullName.trim().split(' ').first
            : 'there';
        final restaurant = profile?.restaurantName ?? '';
        final city = profile?.city ?? '';
        final rating = profile?.averageRating ?? 0.0;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            children: [
              // Avatar
              AvatarWidget(
                name: profile?.fullName ?? 'User',
                imageUrl: profile?.avatarUrl,
                radius: 28,
              ),
              const SizedBox(width: 12),
              // Name + location
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_greeting()}, $firstName',
                      style: AppTextStyles.labelLarge.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Ready to receive more tips today?',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    if (restaurant.isNotEmpty || city.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_rounded,
                              size: 12, color: AppColors.textSecondary),
                          const SizedBox(width: 2),
                          Flexible(
                            child: Text(
                              [restaurant, city]
                                  .where((s) => s.isNotEmpty)
                                  .join(' • '),
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              // Rating box
              if (rating > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              color: AppColors.star, size: 16),
                          const SizedBox(width: 3),
                          Text(
                            rating.toStringAsFixed(1),
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Your rating',
                        style: AppTextStyles.caption
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // ── STATS CARD ───────────────────────────────────────────────────────────

  Widget _buildStatsCard(BuildContext context) {
    return BlocBuilder<TipsBloc, TipsState>(
      builder: (context, tipsState) {
        return BlocBuilder<WalletCubit, WalletState>(
          builder: (context, walletState) {
            final stats = tipsState.stats;
            final wallet =
                walletState is WalletLoaded ? walletState.wallet : null;
            final currency = stats?.currency ?? wallet?.currency ?? AppConstants.defaultCurrency;
            final isLoading =
                (tipsState is TipsLoading && stats == null) || (walletState is WalletLoading && wallet == null);

            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.statsCardGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // Decorative watermark icon
                  Positioned(
                    right: -10,
                    bottom: -10,
                    child: Opacity(
                      opacity: 0.08,
                      child: Icon(
                        Icons.waving_hand_rounded,
                        size: 120,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      // Row 1: Today's tips + Available balance
                      Row(
                        children: [
                          Expanded(
                            child: _StatCell(
                              label: "Today's tips",
                              value: stats != null
                                  ? CurrencyFormatter.format(
                                      stats.todayTotal, currency)
                                  : '— BIF',
                              isLoading: isLoading,
                              hidden: !_balanceVisible,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _StatCell(
                                    label: 'Available balance',
                                    value: wallet != null
                                        ? CurrencyFormatter.format(
                                            wallet.availableBalance,
                                            wallet.currency)
                                        : '— BIF',
                                    isLoading: isLoading,
                                    hidden: !_balanceVisible,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _toggleBalanceVisibility,
                                  child: Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      color: Colors.white
                                          .withValues(alpha: 0.15),
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      _balanceVisible
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Divider(
                          color: Colors.white.withValues(alpha: 0.2),
                          thickness: 1),
                      const SizedBox(height: 4),
                      // Row 2: This week + Total tips
                      Row(
                        children: [
                          Expanded(
                            child: _StatCell(
                              label: 'This week',
                              value: stats != null
                                  ? CurrencyFormatter.format(
                                      stats.weekTotal, currency)
                                  : '— BIF',
                              isLoading: isLoading,
                              hidden: !_balanceVisible,
                            ),
                          ),
                          Expanded(
                            child: _StatCell(
                              label: 'Total tips',
                              value: stats != null
                                  ? CurrencyFormatter.format(
                                      stats.allTimeTotal, currency)
                                  : '— BIF',
                              isLoading: isLoading,
                              hidden: !_balanceVisible,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ── ACTION BUTTONS ───────────────────────────────────────────────────────

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionCard(
            icon: Icons.qr_code_2_rounded,
            title: 'View My QR',
            subtitle: 'Show your QR code',
            iconBg: AppColors.primarySurface,
            iconColor: AppColors.primary,
            onTap: () => context.push(AppRoutes.qr),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionCard(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Withdraw',
            subtitle: 'Transfer to your account',
            iconBg: AppColors.accentSurface,
            iconColor: AppColors.accent,
            onTap: () => context.push('/wallet/withdraw'),
          ),
        ),
      ],
    );
  }

  // ── SHORTCUTS ────────────────────────────────────────────────────────────

  Widget _buildShortcuts(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shortcuts',
                  style: AppTextStyles.labelLarge
                      .copyWith(fontWeight: FontWeight.w700)),
              Text(
                'Edit',
                style: AppTextStyles.labelSmall
                    .copyWith(color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ShortcutItem(
                icon: HugeIcons.strokeRoundedFolderClock,
                label: 'Tips history',
                onTap: () => context.go(AppRoutes.tips),
              ),
              _ShortcutItem(
                icon: HugeIcons.strokeRoundedWallet03,
                label: 'Wallet',
                onTap: () => context.go(AppRoutes.wallet),
              ),
              _ShortcutItem(
                icon: HugeIcons.strokeRoundedQrCode,
                label: 'Share QR',
                onTap: () => context.push(AppRoutes.qr),
              ),
              _ShortcutItem(
                icon: HugeIcons.strokeRoundedAutoConversations,
                label: 'Analytics',
                onTap: () => context.push(AppRoutes.analytics),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── RECENT TIPS ──────────────────────────────────────────────────────────

  Widget _buildRecentTips(BuildContext context) {
    return BlocBuilder<TipsBloc, TipsState>(
      builder: (context, state) {
        if (state is TipsError && state.tips.isEmpty) {
          return ErrorState(
            message: state.message,
            onRetry: () =>
                context.read<TipsBloc>().add(const LoadTips()),
          );
        }

        final tips = state.tips.take(5).toList();
        final isLoading = state is TipsLoading && state.tips.isEmpty;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent tips',
                    style: AppTextStyles.labelLarge
                        .copyWith(fontWeight: FontWeight.w700)),
                GestureDetector(
                  onTap: () => context.go(AppRoutes.tips),
                  child: Text(
                    'See all',
                    style: AppTextStyles.labelSmall
                        .copyWith(color: AppColors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (isLoading)
              RecentTipsShimmer()
            else if (tips.isEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const Icon(Icons.payments_outlined,
                          size: 40, color: AppColors.textHint),
                      const SizedBox(height: 8),
                      Text(
                        'No tips yet',
                        style: AppTextStyles.labelMedium
                            .copyWith(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Share your QR code to start receiving tips!',
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textHint),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Column(
                  children: List.generate(tips.length, (i) {
                    final tip = tips[i];
                    final isLast = i == tips.length - 1;
                    return _RecentTipRow(tip: tip, isLast: isLast);
                  }),
                ),
              ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// INTERNAL WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

/// Single stat cell inside the purple stats card
class _StatCell extends StatelessWidget {
  final String label;
  final String value;
  final bool isLoading;
  final bool hidden;

  const _StatCell({
    required this.label,
    required this.value,
    this.isLoading = false,
    this.hidden = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            color: Colors.white70,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        if (isLoading)
          Container(
            height: 18,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(4),
            ),
          )
        else if (hidden)
          const Text(
            '••••••',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 2,
            ),
          )
        else
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
      ],
    );
  }
}

/// Action button card (View My QR / Withdraw)
class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconBg;
  final Color iconColor;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconBg,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.labelMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    subtitle,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: AppColors.textSecondary, size: 18),
          ],
        ),
      ),
    );
  }
}

/// Shortcut icon button
class _ShortcutItem extends StatelessWidget {
  final dynamic icon;
  final String label;
  final VoidCallback onTap;

  const _ShortcutItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SizedBox(
                width: 28,
                height: 28,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: HugeIcon(icon: icon, color: AppColors.primary, size: 24),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Recent tip row
class _RecentTipRow extends StatelessWidget {
  final dynamic tip;
  final bool isLast;

  const _RecentTipRow({required this.tip, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final isAnon = tip.isAnonymous == true;
    final name =
        isAnon ? 'Anonymous customer' : (tip.customerName ?? 'Happy guest');
    final message = tip.message as String?;
    final amount = (tip.amount as num).toInt();
    final currency = tip.currency as String;
    final time = _formatTime(tip.createdAt as DateTime);

    // Pick avatar style based on customer type
    final Color avatarBg = isAnon
        ? AppColors.primarySurface
        : AppColors.accentSurface;
    final IconData avatarIcon =
        isAnon ? Icons.person_off_outlined : Icons.sentiment_satisfied_rounded;
    final Color avatarIconColor =
        isAnon ? AppColors.primary : AppColors.accent;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              // Avatar circle
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: avatarBg,
                  shape: BoxShape.circle,
                ),
                child:
                    Icon(avatarIcon, color: avatarIconColor, size: 20),
              ),
              const SizedBox(width: 12),
              // Name + message
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.labelMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      (message != null && message.isNotEmpty)
                          ? '"$message"'
                          : 'No message',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Amount + time
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '+${CurrencyFormatter.format(amount, currency)}',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    time,
                    style: AppTextStyles.caption
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
              height: 1,
              indent: 68,
              endIndent: 14,
              color: AppColors.divider),
      ],
    );
  }

  String _formatTime(DateTime dt) {
    final local = dt.toLocal();
    final h = local.hour.toString().padLeft(2, '0');
    final m = local.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
