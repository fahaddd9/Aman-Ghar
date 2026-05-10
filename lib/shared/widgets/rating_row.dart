// Purpose: Star icon + rating + review count row.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 1

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/config/app_theme.dart';

/// RatingRow — ⭐ 4.8 (142 reviews) in a single row.
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
    final Color effectiveTextColor = textColor ?? AppColors.textPrimary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, size: 14.sp, color: AppColors.starRating),
        SizedBox(width: 2.w),
        Text(
          rating.toStringAsFixed(1),
          style: AppTextStyles.rating.copyWith(color: effectiveTextColor),
        ),
        SizedBox(width: AppSpacing.xs.w),
        Text(
          '($reviewCount reviews)',
          style: AppTextStyles.bodySmall.copyWith(
            color: effectiveTextColor.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
