import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/app_constants.dart';
import '../../core/data/dummy_data.dart';
import '../../shared/widgets/service_card.dart';
import '../../shared/widgets/booking_card.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/bottom_nav_bar.dart';

// ─────────────────────────────────────────────────────────────────────────────
// HomeScreen — Discovery home for Hirer
// AppBar | Search bar | Horizontal service cards | Recent Bookings | Bottom nav
// ─────────────────────────────────────────────────────────────────────────────
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String _userAvatarUrl = 'https://i.pravatar.cc/100?img=5';

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return AppConstants.homeGreetingMorning;
    if (hour < 17) return AppConstants.homeGreetingAfternoon;
    return AppConstants.homeGreetingEvening;
  }

  @override
  Widget build(BuildContext context) {
    const providers = DummyData.providers;
    const bookings = DummyData.bookings;

    return Scaffold(
      backgroundColor: AppColors.background,

      // ── AppBar ──────────────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 52,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.md),
          child: CircleAvatar(
            radius: 18,
              backgroundColor: AppColors.primaryLight.withValues(alpha: 0.4),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: _userAvatarUrl,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    const Icon(Icons.person_rounded, size: 18),
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on_rounded,
                    size: 12, color: AppColors.primary),
                const SizedBox(width: 2),
                Flexible(
                  child: Text(
                    AppConstants.dummyUserLocation,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.primary, fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Text(
              '${_greeting()}, Ayesha!',
              style: AppTextStyles.headingSmall,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_rounded,
                color: AppColors.textPrimary),
          ),
        ],
      ),

      // ── Bottom nav ──────────────────────────────────────────────────────
      bottomNavigationBar: const AmanGharBottomNav(currentIndex: 0),

      // ── Body ────────────────────────────────────────────────────────────
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Search bar ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, AppSpacing.md, AppSpacing.md, 0),
                child: GestureDetector(
                  onTap: () => context.push('/search'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      boxShadow: AppShadows.card,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search_rounded,
                            color: AppColors.textHint, size: 22),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            AppConstants.homeSearchHint,
                            style: AppTextStyles.bodyMedium
                                .copyWith(color: AppColors.textHint),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        
              // ── Section: Services ───────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.sm),
                child: Row(
                  children: [
                    const Expanded(child: SectionHeader('Services')),
                    TextButton(
                      onPressed: () => context.push('/search'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                      ),
                      child: Text(
                        AppConstants.homeSeeAll,
                        style: AppTextStyles.bodyMedium
                            .copyWith(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
        
              // ── Horizontal service cards ─────────────────────────────────
              SizedBox(
                height: 220, // Increased slightly for better fit
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  itemCount: providers.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.sm),
                  itemBuilder: (_, i) => ServiceCard(provider: providers[i]),
                ),
              ),
        
              // ── Section: Recent Bookings ─────────────────────────────────
              const Padding(
                padding: EdgeInsets.fromLTRB(
                    AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.sm),
                child: SectionHeader('Recent Bookings'),
              ),
        
              // ── Booking cards ─────────────────────────────────────────────
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (_, i) => BookingCard(
                    booking: bookings[i],
                    onBookAgain: () =>
                        context.push('/provider/${bookings[i].providerId}'),
                  ),
                ),
              ),
        
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
