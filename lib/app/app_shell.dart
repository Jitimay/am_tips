import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../core/theme/app_colors.dart';
import '../core/widgets/connectivity_banner.dart';

/// Bottom navigation shell — 5 tabs: Home | Tips | Campaign | Wallet | Profile
class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ConnectivityBanner wraps the entire shell body so the offline indicator
      // appears on every tab without each page needing to handle it.
      body: ConnectivityBanner(
        child: navigationShell,
      ),
      bottomNavigationBar: _AmTipsBottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}

class _AmTipsBottomNav extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const _AmTipsBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.divider, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 12,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                _NavItem(
                  icon: HugeIcons.strokeRoundedHome03,
                  label: 'Home',
                  isSelected: currentIndex == 0,
                  onTap: () => onTap(0),
                ),
                _NavItem(
                  icon: HugeIcons.strokeRoundedTips,
                  label: 'Tips',
                  isSelected: currentIndex == 1,
                  onTap: () => onTap(1),
                ),
                // Centre Campaign tab — elevated gradient button
                _CampaignNavItem(
                  isSelected: currentIndex == 2,
                  onTap: () => onTap(2),
                ),
                _NavItem(
                  icon: HugeIcons.strokeRoundedWallet03,
                  label: 'Wallet',
                  isSelected: currentIndex == 3,
                  onTap: () => onTap(3),
                ),
                _NavItem(
                  icon: HugeIcons.strokeRoundedUser02,
                  label: 'Profile',
                  isSelected: currentIndex == 4,
                  onTap: () => onTap(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final dynamic icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        isSelected ? AppColors.primary : AppColors.textSecondary;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(icon: icon, color: color, size: 24),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 4 : 0,
              height: isSelected ? 4 : 0,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CampaignNavItem extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const _CampaignNavItem({
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedPlusSignSquare,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
