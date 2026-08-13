import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Interactive or read-only star rating widget (1–5).
class StarRating extends StatelessWidget {
  final int rating;
  final int maxRating;
  final double size;
  final bool interactive;
  final void Function(int)? onRatingChanged;
  final Color? activeColor;
  final Color? inactiveColor;

  const StarRating({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 24,
    this.interactive = false,
    this.onRatingChanged,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        final filled = index < rating;
        final star = Icon(
          filled ? Icons.star_rounded : Icons.star_outline_rounded,
          size: size,
          color: filled
              ? (activeColor ?? AppColors.warning)
              : (inactiveColor ?? AppColors.textHint),
        );

        if (interactive && onRatingChanged != null) {
          return GestureDetector(
            onTap: () => onRatingChanged!(index + 1),
            child: star,
          );
        }
        return star;
      }),
    );
  }
}
