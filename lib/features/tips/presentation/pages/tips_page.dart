import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/star_rating.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/tip.dart';
import '../../domain/repositories/tips_repository.dart';
import '../bloc/tips_bloc.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  TipFilter _activeFilter = TipFilter.today;

  @override
  void initState() {
    super.initState();
    context
        .read<TipsBloc>()
        .add(LoadTips(filter: _activeFilter));
  }

  void _setFilter(TipFilter f) {
    if (_activeFilter == f) return;
    setState(() => _activeFilter = f);
    context.read<TipsBloc>().add(TipsFilterChanged(f));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tip History')),
      body: Column(
        children: [
          // Filter chips
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(
                    label: 'Today',
                    isSelected: _activeFilter == TipFilter.today,
                    onTap: () => _setFilter(TipFilter.today),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'This Week',
                    isSelected: _activeFilter == TipFilter.thisWeek,
                    onTap: () => _setFilter(TipFilter.thisWeek),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'This Month',
                    isSelected: _activeFilter == TipFilter.thisMonth,
                    onTap: () => _setFilter(TipFilter.thisMonth),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'All Time',
                    isSelected: _activeFilter == TipFilter.all,
                    onTap: () => _setFilter(TipFilter.all),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          // Tips list
          Expanded(
            child: BlocBuilder<TipsBloc, TipsState>(
              builder: (context, state) {
                if (state is TipsLoading && state.tips.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is TipsError && state.tips.isEmpty) {
                  return ErrorState(
                    message: state.message,
                    onRetry: () => context
                        .read<TipsBloc>()
                        .add(LoadTips(filter: _activeFilter)),
                  );
                }
                if (state is TipsLoaded || state is TipDetailLoaded || state.tips.isNotEmpty) {
                  final tips = state.tips;
                  if (tips.isEmpty) {
                    return EmptyState(
                      icon: Icons.payments_outlined,
                      title: 'No tips yet',
                      subtitle:
                          'Tips you receive will appear here.',
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async => context
                        .read<TipsBloc>()
                        .add(LoadTips(filter: _activeFilter)),
                    child: _GroupedTipsList(tips: tips),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color:
                isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight:
                isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _GroupedTipsList extends StatelessWidget {
  final List<Tip> tips;
  const _GroupedTipsList({required this.tips});

  Map<String, List<Tip>> _groupByDate(List<Tip> tips) {
    final Map<String, List<Tip>> grouped = {};
    for (final tip in tips) {
      final key = DateFormatter.sectionHeader(tip.createdAt);
      grouped.putIfAbsent(key, () => []).add(tip);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByDate(tips);
    final keys = grouped.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: keys.length,
      itemBuilder: (context, i) {
        final key = keys[i];
        final group = grouped[key]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
              child: Text(
                key,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            ...group.map((tip) => TipListItem(tip: tip)),
          ],
        );
      },
    );
  }
}

class TipListItem extends StatelessWidget {
  final Tip tip;
  const TipListItem({super.key, required this.tip});

  BadgeStatus _badgeStatus(TipStatus s) {
    switch (s) {
      case TipStatus.pending:
        return BadgeStatus.pending;
      case TipStatus.processing:
        return BadgeStatus.processing;
      case TipStatus.completed:
        return BadgeStatus.completed;
      case TipStatus.failed:
        return BadgeStatus.failed;
      case TipStatus.refunded:
        return BadgeStatus.refunded;
      case TipStatus.cancelled:
        return BadgeStatus.cancelled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/tips/${tip.id}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_downward_rounded,
                  color: AppColors.accent, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '+${CurrencyFormatter.format(tip.amount, tip.currency)}',
                        style: AppTextStyles.labelLarge
                            .copyWith(color: AppColors.accent),
                      ),
                      const SizedBox(width: 8),
                      StatusBadge(status: _badgeStatus(tip.status)),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    tip.isAnonymous
                        ? 'Anonymous customer'
                        : (tip.customerName ?? 'Customer'),
                    style: AppTextStyles.bodySmall,
                  ),
                  if (tip.message != null && tip.message!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      '"${tip.message}"',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (tip.rating != null) ...[
                    const SizedBox(height: 3),
                    StarRating(rating: tip.rating!, size: 14),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              DateFormatter.formatTime(tip.createdAt),
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }
}
