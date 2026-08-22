import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/avatar_widget.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/star_rating.dart';
import '../bloc/customer_tip_bloc.dart';

class CustomerProfilePage extends StatefulWidget {
  final String waiterId;
  const CustomerProfilePage({super.key, required this.waiterId});

  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  int? _selectedAmount;
  final TextEditingController _customController = TextEditingController();
  bool _showCustom = false;
  String _currency = AppConstants.defaultCurrency;

  @override
  void initState() {
    super.initState();
    context.read<CustomerTipBloc>().add(
          CustomerProfileRequested(widget.waiterId),
        );
  }

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  void _selectAmount(int amount) {
    setState(() {
      _selectedAmount = amount;
      _showCustom = false;
      _customController.clear();
    });
  }

  void _proceed() {
    final amount = _showCustom
        ? int.tryParse(_customController.text.replaceAll(',', '').trim())
        : _selectedAmount;

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select or enter a tip amount.')),
      );
      return;
    }

    context.read<CustomerTipBloc>().add(
          TipAmountSelected(amount: amount, currency: _currency),
        );
    context.push(
      '/t/${widget.waiterId}/payment',
      extra: {'amount': amount, 'currency': _currency},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<CustomerTipBloc, CustomerTipState>(
        builder: (context, state) {
          if (state is CustomerTipLoading || state is CustomerTipInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CustomerTipError) {
            return ErrorState(message: state.message);
          }
          if (state is CustomerProfileLoaded ||
              state is CustomerTipAmountSelected) {
            final profile = state is CustomerProfileLoaded
                ? state.profile
                : (state as CustomerTipAmountSelected).profile;
            _currency = AppConstants.defaultCurrency;

            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  _buildHeader(context, profile),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _buildPresetAmounts(),
                        const SizedBox(height: 16),
                        _buildCustomAmount(),
                        const SizedBox(height: 32),
                        _buildContinueButton(),
                        const SizedBox(height: 24),
                        _buildPoweredBy(),
                        const SizedBox(height: 32),
                      ]),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  // ── Header ───────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context, dynamic profile) {
    final professions = (profile.professions as List?)
            ?.map((e) => e.toString())
            .toList() ??
        <String>[];
    final hasWorkplace = (profile.restaurantName as String?)?.isNotEmpty == true;
    final hasProfessions = professions.isNotEmpty;

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
        decoration: const BoxDecoration(gradient: AppColors.walletGradient),
        child: Column(
          children: [
            // Avatar
            AvatarWidget(
              name: profile.fullName as String,
              imageUrl: profile.avatarUrl as String?,
              radius: 40,
            ),
            const SizedBox(height: 14),

            // Name
            Text(
              'Tip ${(profile.fullName as String).split(' ').first}',
              style: AppTextStyles.h1.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 6),

            // ── Professions chips (primary identity) ──────────────────────
            if (hasProfessions) ...[
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 6,
                runSpacing: 6,
                children: professions.map((p) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      p,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
            ],

            // ── Workplace (secondary, only if set) ────────────────────────
            if (hasWorkplace) ...[
              Text(
                profile.restaurantName as String,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
            ],

            // ── Location ──────────────────────────────────────────────────
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_on_outlined,
                    size: 13, color: Colors.white70),
                const SizedBox(width: 3),
                Text(
                  '${profile.city}, ${profile.country}',
                  style: AppTextStyles.bodySmall
                      .copyWith(color: Colors.white70),
                ),
              ],
            ),

            // ── Rating ────────────────────────────────────────────────────
            if ((profile.totalRatings as int) > 0) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StarRating(
                    rating: (profile.averageRating as double).round(),
                    size: 16,
                    activeColor: AppColors.warning,
                    inactiveColor: Colors.white38,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    (profile.averageRating as double).toStringAsFixed(1),
                    style: AppTextStyles.labelSmall
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ],

            // ── Personal message ──────────────────────────────────────────
            if ((profile.personalMessage as String?)?.isNotEmpty == true) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '"${profile.personalMessage}"',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ── Preset amounts ────────────────────────────────────────────────────────

  Widget _buildPresetAmounts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose an amount', style: AppTextStyles.h3),
        const SizedBox(height: 14),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.4,
          children: AppConstants.tipPresets.map((amount) {
            final isSelected = _selectedAmount == amount && !_showCustom;
            return GestureDetector(
              onTap: () => _selectAmount(amount),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : Theme.of(context).colorScheme.outline,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color:
                                AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    CurrencyFormatter.format(amount, _currency),
                    style: AppTextStyles.labelLarge.copyWith(
                      color: isSelected
                          ? Colors.white
                          : AppColors.textPrimary,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ── Custom amount ─────────────────────────────────────────────────────────

  Widget _buildCustomAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() {
            _showCustom = !_showCustom;
            _selectedAmount = null;
          }),
          child: Row(
            children: [
              Icon(
                _showCustom
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.add_circle_outline_rounded,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                'Custom amount',
                style: AppTextStyles.labelMedium
                    .copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ),
        if (_showCustom) ...[
          const SizedBox(height: 12),
          TextField(
            controller: _customController,
            keyboardType: TextInputType.number,
            autofocus: true,
            style: AppTextStyles.amountMedium,
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: AppTextStyles.amountMedium
                  .copyWith(color: AppColors.textHint),
              suffix: Text(
                _currency,
                style: AppTextStyles.labelMedium
                    .copyWith(color: AppColors.textSecondary),
              ),
            ),
          ),
        ],
      ],
    );
  }

  // ── CTA ───────────────────────────────────────────────────────────────────

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _proceed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(
          'Continue',
          style: AppTextStyles.button.copyWith(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildPoweredBy() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.monetization_on_rounded,
              size: 13, color: AppColors.textHint),
          const SizedBox(width: 4),
          Text('Powered by amTips', style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
