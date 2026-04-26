import 'package:flutter/material.dart';
import '../../core/config/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// RatingRow — Star icon + rating value + review count in one row
// ─────────────────────────────────────────────────────────────────────────────
class RatingRow extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final Color? textColor;

  const RatingRow({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = textColor ?? AppColors.textPrimary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.star_rounded,
          size: 14,
          color: AppColors.starRating,
        ),
        const SizedBox(width: 2),
        Text(
          rating.toStringAsFixed(1),
          style: AppTextStyles.rating.copyWith(color: effectiveTextColor),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '($reviewCount reviews)',
          style: AppTextStyles.bodySmall.copyWith(color: effectiveTextColor.withValues(alpha: 0.8)),
        ),
      ],
    );
  }
}
