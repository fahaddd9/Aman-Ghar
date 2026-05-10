// Purpose: Green pill badge for verified service providers.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 1

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/config/app_theme.dart';

/// VerifiedBadge — Green pill shown next to verified providers.
class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColors.verified.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.badge),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_rounded, size: 12.sp, color: AppColors.verified),
          SizedBox(width: AppSpacing.xs.w),
          Text(
            AppStrings.verifiedLabel,
            style: AppTextStyles.label.copyWith(
              color: AppColors.verified,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
