import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Convenience methods for showing snack-bars without boilerplate.
class SnackBarUtils {
  SnackBarUtils._();

  static void showSuccess(BuildContext context, String message) {
    _show(context, message, backgroundColor: AppColors.success);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message, backgroundColor: AppColors.error);
  }

  static void showInfo(BuildContext context, String message) {
    _show(context, message, backgroundColor: AppColors.info);
  }

  static void showWarning(BuildContext context, String message) {
    _show(context, message, backgroundColor: AppColors.warning);
  }

  static void _show(
    BuildContext context,
    String message, {
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
