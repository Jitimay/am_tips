import 'package:flutter/material.dart';

/// amTips brand color palette — matches the purple design system in the app.
class AppColors {
  AppColors._();

  // ── Brand Purple ───────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF6C4EE8);       // Main purple
  static const Color primaryDark = Color(0xFF5538C8);
  static const Color primaryLight = Color(0xFF8B72F0);
  static const Color primarySurface = Color(0xFFF0ECFF); // light purple bg for icons

  // ── Accent / Money ────────────────────────────────────────────────────────
  static const Color accent = Color(0xFF2ECC71);        // green for amounts
  static const Color accentSurface = Color(0xFFE9FAF1);

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  static const Color star = Color(0xFFF59E0B);

  // ── Neutrals (Light theme) ────────────────────────────────────────────────
  static const Color background = Color(0xFFF5F6FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0ECFF);  // soft purple tint
  static const Color divider = Color(0xFFEEEEF5);
  static const Color cardBorder = Color(0xFFEEEEF5);

  static const Color textPrimary = Color(0xFF1A1033);
  static const Color textSecondary = Color(0xFF8B8BA0);
  static const Color textHint = Color(0xFFBBBBCC);
  static const Color textInverse = Color(0xFFFFFFFF);

  // ── Neutrals (Dark theme) ─────────────────────────────────────────────────
  static const Color backgroundDark = Color(0xFF0F0D1A);
  static const Color surfaceDark = Color(0xFF1C1830);
  static const Color surfaceVariantDark = Color(0xFF2A2545);
  static const Color dividerDark = Color(0xFF2E2A45);

  static const Color textPrimaryDark = Color(0xFFF1F0F8);
  static const Color textSecondaryDark = Color(0xFF9B98B4);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient statsCardGradient = LinearGradient(
    colors: [Color(0xFF7B5FEE), Color(0xFF5E3DD0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF8B72F0), Color(0xFF5E3DD0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Alias kept for backward compatibility with existing screens.
  static const LinearGradient walletGradient = LinearGradient(
    colors: [Color(0xFF7B5FEE), Color(0xFF5E3DD0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Green-to-purple gradient used on tip success / detail screens.
  static const LinearGradient tipGradient = LinearGradient(
    colors: [Color(0xFF2ECC71), Color(0xFF6C4EE8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Status badge colors ───────────────────────────────────────────────────
  static const Color statusPending = Color(0xFFF59E0B);
  static const Color statusProcessing = Color(0xFF3B82F6);
  static const Color statusCompleted = Color(0xFF2ECC71);
  static const Color statusFailed = Color(0xFFEF4444);
  static const Color statusRefunded = Color(0xFF8B5CF6);
  static const Color statusCancelled = Color(0xFF6B7280);

  // ── Shortcut icon backgrounds (from screenshot) ───────────────────────────
  static const Color shortcutPurple = Color(0xFFF0ECFF);
}
