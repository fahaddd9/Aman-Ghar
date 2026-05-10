// Purpose: Horizontal scroll card shown on Home screen for service providers.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 4: Home Screen

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/models/provider_model.dart';
import 'rating_row.dart';

/// ServiceCard — Full-bleed image card with gradient overlay.
class ServiceCard extends StatelessWidget {
  final ServiceProvider provider;

  const ServiceCard({super.key, required this.provider});

  static const Map<String, String> _avatarUrls = {
    '1': 'https://i.pravatar.cc/300?img=47',
    '2': 'https://i.pravatar.cc/300?img=45',
    '3': 'https://i.pravatar.cc/300?img=44',
    '4': 'https://i.pravatar.cc/300?img=43',
    '5': 'https://i.pravatar.cc/300?img=41',
  };

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        _avatarUrls[provider.id] ?? 'https://i.pravatar.cc/300';
    return GestureDetector(
      onTap: () => context.push('/provider/${provider.id}'),
      child: Container(
        width: 160.w,
        height: 210.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.card,
          color: AppColors.surface,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── Full-bleed provider image ─────────────────────────────
              Hero(
                tag: 'provider-image-${provider.id}',
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    color: AppColors.primaryLight.withValues(alpha: 0.4),
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    color: AppColors.primaryLight.withValues(alpha: 0.3),
                    child: const Icon(Icons.person_rounded,
                        color: AppColors.primary, size: 48),
                  ),
                ),
              ),

              // ── Gradient overlay ──────────────────────────────────────
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.65),
                      ],
                      stops: const [0.4, 1.0],
                    ),
                  ),
                ),
              ),

              // ── Bottom text content ───────────────────────────────────
              Positioned(
                left: 10.w,
                right: 10.w,
                bottom: 12.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      provider.serviceType.toUpperCase(),
                      style: AppTextStyles.label.copyWith(
                        color: Colors.white70,
                        fontSize: 10.sp,
                        letterSpacing: 0.6,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    RatingRow(
                      rating: provider.rating,
                      reviewCount: provider.reviewCount,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      provider.formattedPrice,
                      style: AppTextStyles.price.copyWith(
                        color: Colors.white,
                        fontSize: 13.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
