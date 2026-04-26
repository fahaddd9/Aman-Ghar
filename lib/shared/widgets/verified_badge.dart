import 'package:flutter/material.dart';
import '../../core/config/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// VerifiedBadge — Green pill badge shown on verified service providers
// ─────────────────────────────────────────────────────────────────────────────
class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.verified.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.badge),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.verified_rounded,
            size: 12,
            color: AppColors.verified,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            'VERIFIED',
            style: AppTextStyles.label.copyWith(
              color: AppColors.verified,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
