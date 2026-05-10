// Purpose: Service profile (Cook/Maid details).
// Doc: 04_ui_improvement_and_fix_phase.md — Step 5: Service Profile Screen

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/data/dummy_data.dart';
import '../../shared/widgets/custom_filled_button.dart';
import '../../shared/widgets/verified_badge.dart';
import '../../shared/widgets/rating_row.dart';
import '../../shared/widgets/section_header.dart';

class ServiceProfileScreen extends StatelessWidget {
  final String providerId;
  const ServiceProfileScreen({super.key, required this.providerId});

  static const Map<String, String> _avatarUrls = {
    '1': 'https://i.pravatar.cc/500?img=47',
    '2': 'https://i.pravatar.cc/500?img=45',
    '3': 'https://i.pravatar.cc/500?img=44',
    '4': 'https://i.pravatar.cc/500?img=43',
    '5': 'https://i.pravatar.cc/500?img=41',
  };

  @override
  Widget build(BuildContext context) {
    // Find provider or fallback
    final provider = DummyData.providers.firstWhere(
      (p) => p.id == providerId,
      orElse: () => DummyData.providers.first,
    );

    final String imageUrl = _avatarUrls[provider.id] ?? 'https://i.pravatar.cc/500';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Sliver App Bar with Image ──────────────────────────────────
          SliverAppBar(
            expandedHeight: 340.h,
            pinned: true,
            backgroundColor: AppColors.background,
            leading: Padding(
              padding: EdgeInsets.all(8.w),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.share_rounded, color: AppColors.textPrimary),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'provider-image-${provider.id}',
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(color: AppColors.primaryLight),
                ),
              ),
            ),
          ),

          // ── Profile Content ───────────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.sheet)),
              ),
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name & Verified Badge
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            provider.name,
                            style: AppTextStyles.displayLarge,
                          ),
                        ),
                        if (provider.isVerified) const VerifiedBadge(),
                      ],
                    ),
                    SizedBox(height: AppSpacing.xs.h),
                    
                    // Rating
                    RatingRow(
                      rating: provider.rating,
                      reviewCount: provider.reviewCount,
                    ),
                    SizedBox(height: AppSpacing.md.h),
                    
                    // Location & Category
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded, size: 16.sp, color: AppColors.textHint),
                        SizedBox(width: 4.w),
                        Text(provider.location, style: AppTextStyles.bodyMedium),
                        SizedBox(width: AppSpacing.md.w),
                        Icon(Icons.work_rounded, size: 16.sp, color: AppColors.textHint),
                        SizedBox(width: 4.w),
                        Text(provider.serviceType, style: AppTextStyles.bodyMedium),
                      ],
                    ),
                    SizedBox(height: AppSpacing.xl.h),

                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem(
                          label: 'Jobs',
                          value: '${provider.jobsCompleted}+',
                          icon: Icons.check_circle_outline_rounded,
                        ),
                        Container(height: 40.h, width: 1.w, color: AppColors.divider),
                        _StatItem(
                          label: 'Rate',
                          value: provider.formattedPrice,
                          icon: Icons.payments_outlined,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.xl.h),

                    // About
                    const SectionHeader(AppStrings.aboutSection),
                    SizedBox(height: AppSpacing.sm.h),
                    Text(
                      provider.bio,
                      style: AppTextStyles.bodyLarge,
                    ),
                    SizedBox(height: AppSpacing.xl.h),

                    // Services
                    const SectionHeader(AppStrings.servicesProvidedSection),
                    SizedBox(height: AppSpacing.sm.h),
                    Wrap(
                      spacing: AppSpacing.sm.w,
                      runSpacing: AppSpacing.sm.h,
                      children: provider.services.map((service) {
                        return Chip(
                          label: Text(service.name),
                          backgroundColor: AppColors.surface,
                          side: const BorderSide(color: AppColors.divider),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.chip),
                          ),
                          labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
                        );
                      }).toList(),
                    ),
                    
                    SizedBox(height: 100.h), // Bottom padding for fixed button
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // ── Fixed Bottom Button ──────────────────────────────────────────
      bottomSheet: Container(
        padding: EdgeInsets.all(AppSpacing.md.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: AppShadows.sheet,
        ),
        child: SafeArea(
          child: CustomFilledButton(
            label: AppStrings.bookNow,
            onTap: () => context.push('/booking/${provider.id}'),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 24.sp, color: AppColors.primary),
        SizedBox(height: 4.h),
        Text(value, style: AppTextStyles.headingSmall),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}
