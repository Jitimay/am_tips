import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/star_rating.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/tip.dart';
import '../bloc/tips_bloc.dart';

class TipDetailPage extends StatefulWidget {
  final String tipId;
  const TipDetailPage({super.key, required this.tipId});

  @override
  State<TipDetailPage> createState() => _TipDetailPageState();
}

class _TipDetailPageState extends State<TipDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TipsBloc>().add(TipDetailRequested(widget.tipId));
  }

  BadgeStatus _badge(TipStatus s) {
    return BadgeStatus.values.firstWhere(
      (b) => b.name == s.name,
      orElse: () => BadgeStatus.pending,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tip Details')),
      body: BlocBuilder<TipsBloc, TipsState>(
        builder: (context, state) {
          if (state is TipsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TipsError) {
            return ErrorState(message: state.message);
          }
          if (state is TipDetailLoaded) {
            return _DetailBody(tip: state.tip, badge: _badge);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  final Tip tip;
  final BadgeStatus Function(TipStatus) badge;

  const _DetailBody({required this.tip, required this.badge});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero amount
          Center(
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: AppColors.tipGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    '+${CurrencyFormatter.format(tip.amount, tip.currency)}',
                    style: AppTextStyles.amountLarge.copyWith(
                      color: Colors.white,
                      fontSize: 44,
                    ),
                  ),
                  const SizedBox(height: 8),
                  StatusBadge(status: badge(tip.status)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Message
          if (tip.message != null && tip.message!.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer message', style: AppTextStyles.labelSmall),
                  const SizedBox(height: 6),
                  Text(
                    '"${tip.message}"',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Rating
          if (tip.rating != null) ...[
            _DetailRow(
              label: 'Rating',
              child: StarRating(rating: tip.rating!, size: 20),
            ),
            const SizedBox(height: 8),
          ],

          _DetailRow(
            label: 'From',
            value: tip.isAnonymous
                ? 'Anonymous customer'
                : (tip.customerName ?? 'Customer'),
          ),
          const SizedBox(height: 8),
          _DetailRow(
            label: 'Date',
            value: DateFormatter.formatDateTime(tip.createdAt),
          ),
          const SizedBox(height: 8),
          if (tip.transactionReference != null) ...[
            _DetailRow(
              label: 'Reference',
              value: tip.transactionReference!,
            ),
            const SizedBox(height: 8),
          ],
          if (tip.paymentProvider != null) ...[
            _DetailRow(
              label: 'Payment provider',
              value: tip.paymentProvider!,
            ),
          ],
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? child;

  const _DetailRow({required this.label, this.value, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary)),
          child ??
              Text(
                value ?? '—',
                style: AppTextStyles.labelMedium,
              ),
        ],
      ),
    );
  }
}
