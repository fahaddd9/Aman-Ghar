import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/models/provider_model.dart';
import 'rating_row.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ServiceCard — Horizontal scroll card shown on Home screen
// ─────────────────────────────────────────────────────────────────────────────
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
    final imageUrl = _avatarUrls[provider.id] ?? 'https://i.pravatar.cc/300';
    return GestureDetector(
      onTap: () => context.push('/provider/${provider.id}'),
      child: Container(
        width: 160,
        height: 200,
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
                left: 10,
                right: 10,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      provider.serviceType.toUpperCase(),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white70,
                        fontSize: 10,
                        letterSpacing: 0.6,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    RatingRow(
                      rating: provider.rating,
                      reviewCount: provider.reviewCount,
                      textColor: Colors.white,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      provider.formattedPrice,
                      style: AppTextStyles.price.copyWith(
                        color: Colors.white,
                        fontSize: 13,
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
