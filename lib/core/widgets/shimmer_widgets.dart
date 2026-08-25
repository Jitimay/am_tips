import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Base shimmer container — every skeleton widget uses this
// ─────────────────────────────────────────────────────────────────────────────

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const ShimmerBox({
    required this.width,
    required this.height,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? const Color(0xFF2A2545) : const Color(0xFFEEEEF5),
      highlightColor: isDark ? const Color(0xFF3A3560) : const Color(0xFFF8F8FF),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

// Shorthand for a full-width shimmer box
class ShimmerLine extends StatelessWidget {
  final double height;
  final double? width;
  final double radius;

  const ShimmerLine({
    this.height = 14,
    this.width,
    this.radius = 6,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(
      width: width ?? double.infinity,
      height: height,
      radius: radius,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Home page shimmer — greeting card + stats card + action buttons + shortcuts
// ─────────────────────────────────────────────────────────────────────────────

class HomePageShimmer extends StatelessWidget {
  const HomePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting card
          GreetingCardShimmer(),
          const SizedBox(height: 16),
          // Stats card
          StatsCardShimmer(),
          const SizedBox(height: 16),
          // Action buttons
          ActionButtonsShimmer(),
          const SizedBox(height: 16),
          // Shortcuts
          ShortcutsShimmer(),
          const SizedBox(height: 16),
          // Recent tips
          RecentTipsShimmer(),
        ],
      ),
    );
  }
}

class GreetingCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          ShimmerBox(width: 56, height: 56, radius: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLine(height: 16, width: 160),
                const SizedBox(height: 6),
                ShimmerLine(height: 12, width: 120),
                const SizedBox(height: 6),
                ShimmerLine(height: 10, width: 100),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ShimmerBox(width: 60, height: 48, radius: 12),
        ],
      ),
    );
  }
}

class StatsCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white.withValues(alpha: 0.15),
        highlightColor: Colors.white.withValues(alpha: 0.35),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: StatsCell()),
                const SizedBox(width: 16),
                Expanded(child: StatsCell()),
              ],
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.white.withValues(alpha: 0.2)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: StatsCell()),
                const SizedBox(width: 16),
                Expanded(child: StatsCell()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatsCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 11,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 20,
          width: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }
}

class ActionButtonsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Expanded(
          child: ShimmerBox(
            width: double.infinity,
            height: 72,
            radius: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ShimmerBox(
            width: double.infinity,
            height: 72,
            radius: 16,
          ),
        ),
      ],
    );
  }
}

class ShortcutsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLine(height: 14, width: 80),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (_) => Column(
                children: [
                  ShimmerBox(width: 56, height: 56, radius: 14),
                  const SizedBox(height: 6),
                  ShimmerLine(height: 10, width: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecentTipsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerLine(height: 14, width: 100),
            ShimmerLine(height: 12, width: 50),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            children: List.generate(
              4,
              (i) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    child: Row(
                      children: [
                        ShimmerBox(width: 42, height: 42, radius: 21),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerLine(height: 13, width: 130),
                              const SizedBox(height: 5),
                              ShimmerLine(height: 11, width: 90),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ShimmerLine(height: 13, width: 70),
                            const SizedBox(height: 4),
                            ShimmerLine(height: 10, width: 36),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (i < 3)
                    Divider(height: 1, indent: 68, endIndent: 14,
                        color: AppColors.divider),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tips history page shimmer
// ─────────────────────────────────────────────────────────────────────────────

class TipsListShimmer extends StatelessWidget {
  const TipsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 6,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            ShimmerBox(width: 44, height: 44, radius: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ShimmerLine(height: 14, width: 90),
                      const SizedBox(width: 8),
                      ShimmerLine(height: 14, width: 60),
                    ],
                  ),
                  const SizedBox(height: 5),
                  ShimmerLine(height: 11, width: 110),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ShimmerLine(height: 11, width: 36),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Wallet page shimmer
// ─────────────────────────────────────────────────────────────────────────────

class WalletShimmer extends StatelessWidget {
  const WalletShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance card
          Shimmer.fromColors(
            baseColor: AppColors.primary.withValues(alpha: 0.2),
            highlightColor: AppColors.primary.withValues(alpha: 0.4),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              color: AppColors.primary.withValues(alpha: 0.15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 13, width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      )),
                  const SizedBox(height: 10),
                  Container(height: 44, width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      )),
                  const SizedBox(height: 6),
                  Container(height: 13, width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      )),
                  const SizedBox(height: 24),
                  Container(height: 48, width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Transactions header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLine(height: 16, width: 160),
                const SizedBox(height: 12),
                ...List.generate(5, (_) => TransactionRowShimmer()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionRowShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          ShimmerBox(width: 40, height: 40, radius: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLine(height: 13, width: 120),
                const SizedBox(height: 5),
                ShimmerLine(height: 10, width: 80),
              ],
            ),
          ),
          ShimmerLine(height: 13, width: 70),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Profile page shimmer
// ─────────────────────────────────────────────────────────────────────────────

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Avatar + name
          Column(
            children: [
              ShimmerBox(width: 96, height: 96, radius: 48),
              const SizedBox(height: 14),
              ShimmerLine(height: 20, width: 150),
              const SizedBox(height: 8),
              ShimmerLine(height: 12, width: 200),
              const SizedBox(height: 6),
              ShimmerLine(height: 12, width: 120),
            ],
          ),
          const SizedBox(height: 24),
          // Info cards
          ...List.generate(
            4,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(
                  children: [
                    ShimmerBox(width: 36, height: 36, radius: 10),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerLine(height: 10, width: 60),
                          const SizedBox(height: 5),
                          ShimmerLine(height: 13, width: 140),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Notifications page shimmer
// ─────────────────────────────────────────────────────────────────────────────

class NotificationsShimmer extends StatelessWidget {
  const NotificationsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 7,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerBox(width: 42, height: 42, radius: 21),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerLine(height: 13, width: 180),
                  const SizedBox(height: 5),
                  ShimmerLine(height: 11, width: double.infinity),
                  const SizedBox(height: 4),
                  ShimmerLine(height: 11, width: 120),
                  const SizedBox(height: 5),
                  ShimmerLine(height: 9, width: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tip detail page shimmer
// ─────────────────────────────────────────────────────────────────────────────

class TipDetailShimmer extends StatelessWidget {
  const TipDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Hero amount card
          ShimmerBox(width: double.infinity, height: 140, radius: 20),
          const SizedBox(height: 24),
          // Detail rows
          ...List.generate(
            5,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLine(height: 12, width: 80),
                    ShimmerLine(height: 12, width: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
