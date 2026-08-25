import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/shimmer_widgets.dart';
import '../../domain/entities/tip.dart';
import '../bloc/tips_bloc.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  void initState() {
    super.initState();
    final s = context.read<TipsBloc>().state;
    if (s.tips.isEmpty) context.read<TipsBloc>().add(const LoadTips());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: BlocBuilder<TipsBloc, TipsState>(
        builder: (context, state) {
          if (state is TipsLoading && state.tips.isEmpty) {
            return const TipsListShimmer();
          }
          if (state is TipsError && state.tips.isEmpty) {
            return ErrorState(
              message: state.message,
              onRetry: () => context.read<TipsBloc>().add(const LoadTips()),
            );
          }

          final tips = state.tips
              .where((t) => t.status == TipStatus.completed)
              .toList();
          final stats = state.stats;
          final currency = stats?.currency ?? 'BIF';

          if (tips.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.bar_chart_rounded, size: 56, color: AppColors.textHint),
                  const SizedBox(height: 12),
                  Text('No data yet', style: AppTextStyles.labelLarge.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  Text('Tips will appear here once received', style: AppTextStyles.bodySmall),
                ],
              ),
            );
          }

          final _Analytics a = _Analytics.from(tips, currency);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Summary cards ──────────────────────────────────────
                _SummaryRow(a: a),
                const SizedBox(height: 20),

                // ── Tips per day (last 7 days) ─────────────────────────
                _SectionTitle('Last 7 days'),
                const SizedBox(height: 10),
                _BarChart(bars: a.last7Days, currency: currency),
                const SizedBox(height: 20),

                // ── Rating distribution ────────────────────────────────
                if (a.ratingCounts.values.any((v) => v > 0)) ...[
                  _SectionTitle('Rating breakdown'),
                  const SizedBox(height: 10),
                  _RatingBars(counts: a.ratingCounts, total: a.ratedCount),
                  const SizedBox(height: 20),
                ],

                // ── Top hours ──────────────────────────────────────────
                _SectionTitle('Busiest hours'),
                const SizedBox(height: 10),
                _HourHeatmap(hourCounts: a.hourCounts),
                const SizedBox(height: 20),

                // ── Anonymous vs named ─────────────────────────────────
                _SectionTitle('Customer type'),
                const SizedBox(height: 10),
                _CustomerTypePill(
                  named: a.namedCount,
                  anon: a.anonCount,
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ── Analytics data model ───────────────────────────────────────────────────

class _Analytics {
  final int totalAmount;
  final int totalCount;
  final double avgAmount;
  final double avgRating;
  final int ratedCount;
  final String currency;
  final List<_DayBar> last7Days;
  final Map<int, int> ratingCounts; // 1-5 → count
  final List<int> hourCounts;       // 0-23 → count
  final int namedCount;
  final int anonCount;

  const _Analytics({
    required this.totalAmount,
    required this.totalCount,
    required this.avgAmount,
    required this.avgRating,
    required this.ratedCount,
    required this.currency,
    required this.last7Days,
    required this.ratingCounts,
    required this.hourCounts,
    required this.namedCount,
    required this.anonCount,
  });

  factory _Analytics.from(List<Tip> tips, String currency) {
    final now = DateTime.now();
    final total = tips.fold(0, (s, t) => s + t.amount);
    final avg = tips.isEmpty ? 0.0 : total / tips.length;

    final rated = tips.where((t) => t.rating != null).toList();
    final avgRating = rated.isEmpty
        ? 0.0
        : rated.fold(0, (s, t) => s + t.rating!) / rated.length;

    // Last 7 days
    final days = List.generate(7, (i) {
      final day = DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: 6 - i));
      final dayTips = tips.where((t) {
        final d = t.createdAt.toLocal();
        return d.year == day.year && d.month == day.month && d.day == day.day;
      }).toList();
      return _DayBar(
        label: _dayLabel(day),
        amount: dayTips.fold(0, (s, t) => s + t.amount),
        count: dayTips.length,
      );
    });

    // Rating counts
    final ratingCounts = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (final t in rated) {
      final r = t.rating!.clamp(1, 5);
      ratingCounts[r] = (ratingCounts[r] ?? 0) + 1;
    }

    // Hour counts
    final hourCounts = List.filled(24, 0);
    for (final t in tips) {
      hourCounts[t.createdAt.toLocal().hour]++;
    }

    return _Analytics(
      totalAmount: total,
      totalCount: tips.length,
      avgAmount: avg,
      avgRating: avgRating,
      ratedCount: rated.length,
      currency: currency,
      last7Days: days,
      ratingCounts: ratingCounts,
      hourCounts: hourCounts,
      namedCount: tips.where((t) => !t.isAnonymous).length,
      anonCount: tips.where((t) => t.isAnonymous).length,
    );
  }

  static String _dayLabel(DateTime d) {
    const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return labels[d.weekday - 1];
  }
}

class _DayBar {
  final String label;
  final int amount;
  final int count;
  const _DayBar({required this.label, required this.amount, required this.count});
}

// ── Widgets ────────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) =>
      Text(text, style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.w700));
}

class _SummaryRow extends StatelessWidget {
  final _Analytics a;
  const _SummaryRow({required this.a});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _SummaryCard(
          label: 'Total earned',
          value: CurrencyFormatter.format(a.totalAmount, a.currency),
          icon: Icons.payments_rounded,
          color: AppColors.primary,
        )),
        const SizedBox(width: 10),
        Expanded(child: _SummaryCard(
          label: 'Total tips',
          value: '${a.totalCount}',
          icon: Icons.thumb_up_rounded,
          color: AppColors.accent,
        )),
        const SizedBox(width: 10),
        Expanded(child: _SummaryCard(
          label: 'Avg tip',
          value: CurrencyFormatter.format(a.avgAmount.round(), a.currency),
          icon: Icons.trending_up_rounded,
          color: AppColors.info,
        )),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _SummaryCard({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  final List<_DayBar> bars;
  final String currency;
  const _BarChart({required this.bars, required this.currency});

  @override
  Widget build(BuildContext context) {
    final maxAmount = bars.map((b) => b.amount).fold(0, (a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: bars.map((bar) {
          final ratio = maxAmount == 0 ? 0.0 : bar.amount / maxAmount;
          final isToday = bar == bars.last;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (bar.count > 0)
                    Text('${bar.count}',
                        style: AppTextStyles.caption.copyWith(fontSize: 9)),
                  const SizedBox(height: 2),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: 80 * ratio + (bar.amount > 0 ? 4 : 2),
                    decoration: BoxDecoration(
                      color: isToday ? AppColors.primary : AppColors.primaryLight.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(bar.label,
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                        color: isToday ? AppColors.primary : AppColors.textSecondary,
                      )),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _RatingBars extends StatelessWidget {
  final Map<int, int> counts;
  final int total;
  const _RatingBars({required this.counts, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [5, 4, 3, 2, 1].map((star) {
          final count = counts[star] ?? 0;
          final ratio = total == 0 ? 0.0 : count / total;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                const Icon(Icons.star_rounded, size: 14, color: AppColors.star),
                const SizedBox(width: 4),
                Text('$star', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: ratio,
                      minHeight: 8,
                      backgroundColor: AppColors.divider,
                      valueColor: const AlwaysStoppedAnimation(AppColors.star),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 24,
                  child: Text('$count', style: AppTextStyles.caption, textAlign: TextAlign.end),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _HourHeatmap extends StatelessWidget {
  final List<int> hourCounts;
  const _HourHeatmap({required this.hourCounts});

  @override
  Widget build(BuildContext context) {
    final maxCount = hourCounts.fold(0, (a, b) => a > b ? a : b);
    // Show only 6am–midnight for readability
    final hours = List.generate(18, (i) => i + 6);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: hours.map((h) {
          final count = hourCounts[h];
          final ratio = maxCount == 0 ? 0.0 : count / maxCount;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40 * ratio + 4,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15 + 0.85 * ratio),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 3),
                  if (h % 3 == 0)
                    Text('${h}h', style: AppTextStyles.caption.copyWith(fontSize: 8))
                  else
                    const SizedBox(height: 10),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _CustomerTypePill extends StatelessWidget {
  final int named;
  final int anon;
  const _CustomerTypePill({required this.named, required this.anon});

  @override
  Widget build(BuildContext context) {
    final total = named + anon;
    final namedRatio = total == 0 ? 0.5 : named / total;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 14,
              child: Row(
                children: [
                  Flexible(
                    flex: (namedRatio * 100).round(),
                    child: Container(color: AppColors.primary),
                  ),
                  Flexible(
                    flex: 100 - (namedRatio * 100).round(),
                    child: Container(color: AppColors.primaryLight.withValues(alpha: 0.3)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _LegendDot(color: AppColors.primary, label: 'Named', count: named),
              _LegendDot(color: AppColors.primaryLight.withValues(alpha: 0.5), label: 'Anonymous', count: anon),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  final int count;
  const _LegendDot({required this.color, required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text('$label ($count)', style: AppTextStyles.bodySmall),
      ],
    );
  }
}
