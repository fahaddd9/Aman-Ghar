// Purpose: Search result row card — Avatar | Name+Rating+Location | Price+SELECT.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 4

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/config/app_theme.dart';
import '../../core/models/provider_model.dart';
import 'verified_badge.dart';
import 'rating_row.dart';
import 'custom_filled_button.dart';

/// ProviderListTile — Full search-result card with avatar, info, and SELECT button.
class ProviderListTile extends StatelessWidget {
  final ServiceProvider provider;
  final VoidCallback? onSelect;

  const ProviderListTile({
    super.key,
    required this.provider,
    this.onSelect,
  });

  static const Map<String, String> _avatarUrls = {
    '1': 'https://i.pravatar.cc/150?img=47',
    '2': 'https://i.pravatar.cc/150?img=45',
    '3': 'https://i.pravatar.cc/150?img=44',
    '4': 'https://i.pravatar.cc/150?img=43',
    '5': 'https://i.pravatar.cc/150?img=41',
  };

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        _avatarUrls[provider.id] ?? 'https://i.pravatar.cc/150';
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppSpacing.xs.h),
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Avatar with Hero ──────────────────────────────────────────
          Hero(
            tag: 'provider-image-${provider.id}',
            child: CircleAvatar(
              radius: 28.r,
              backgroundColor: AppColors.primaryLight.withValues(alpha: 0.4),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 56.w,
                  height: 56.w,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const Icon(
                    Icons.person_rounded,
                    color: AppColors.primary,
                    size: 28,
                  ),
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.person_rounded,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // ── Name, rating, location ────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        provider.name,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (provider.isVerified) ...[
                      SizedBox(width: AppSpacing.xs.w),
                      const VerifiedBadge(),
                    ],
                  ],
                ),
                SizedBox(height: 3.h),
                RatingRow(
                  rating: provider.rating,
                  reviewCount: provider.reviewCount,
                ),
                SizedBox(height: 3.h),
                Text(
                  '${provider.serviceType} • ${provider.location}',
                  style: AppTextStyles.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),

          // ── Price + SELECT button ─────────────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                provider.formattedPrice,
                style: AppTextStyles.price.copyWith(fontSize: 13.sp),
              ),
              SizedBox(height: 6.h),
              SizedBox(
                width: 90.w,
                height: 34.h,
                child: CustomFilledButton(
                  label: 'SELECT',
                  height: 34.h,
                  onTap: onSelect,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
