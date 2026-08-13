import 'package:flutter/material.dart';

/// amTips brand color palette.
/// Modern + Trustworthy + African fintech friendly.
class AppColors {
  AppColors._();

  // ── Brand ─────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF1A73E8);       // Blue — trust, digital
  static const Color primaryDark = Color(0xFF1557B0);
  static const Color primaryLight = Color(0xFF4A9EF8);

  static const Color accent = Color(0xFF00C896);        // Teal/green — success, money
  static const Color accentDark = Color(0xFF009E76);

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF00C896);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF42A5F5);

  // ── Neutrals (Light) ──────────────────────────────────────────────────────
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F3F8);
  static const Color divider = Color(0xFFE0E6F0);

  static const Color textPrimary = Color(0xFF1A1D26);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFFADB5BD);
  static const Color textInverse = Color(0xFFFFFFFF);

  // ── Neutrals (Dark) ───────────────────────────────────────────────────────
  static const Color backgroundDark = Color(0xFF0F1117);
  static const Color surfaceDark = Color(0xFF1C1F2E);
  static const Color surfaceVariantDark = Color(0xFF252840);
  static const Color dividerDark = Color(0xFF2E3347);

  static const Color textPrimaryDark = Color(0xFFF1F3F9);
  static const Color textSecondaryDark = Color(0xFF9BA3B4);

  // ── Financial card gradients ──────────────────────────────────────────────
  static const LinearGradient walletGradient = LinearGradient(
    colors: [Color(0xFF1A73E8), Color(0xFF00C896)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient tipGradient = LinearGradient(
    colors: [Color(0xFF00C896), Color(0xFF1A73E8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Status colors ─────────────────────────────────────────────────────────
  static const Color statusPending = Color(0xFFFFA726);
  static const Color statusProcessing = Color(0xFF42A5F5);
  static const Color statusCompleted = Color(0xFF00C896);
  static const Color statusFailed = Color(0xFFEF5350);
  static const Color statusRefunded = Color(0xFFAB47BC);
  static const Color statusCancelled = Color(0xFF78909C);
}
