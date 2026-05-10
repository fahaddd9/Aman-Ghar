// Purpose: AmanGhar Home Screen (Discovery & Status).
// Doc: 04_ui_improvement_and_fix_phase.md — Step 4: Home Screen

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/data/dummy_data.dart';
import '../../core/providers/role_provider.dart';
import '../../shared/widgets/service_card.dart';
import '../../shared/widgets/booking_card.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import '../../shared/widgets/section_header.dart';
import '../../core/providers/auth_provider.dart';
import 'provider_home_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(userProfileProvider);
    
    return userProfileAsync.when(
      data: (profile) {
        final roleStr = profile?['role'] as String? ?? 'hirer';
        final name = profile?['name'] as String? ?? 'User';
        
        // Sync the local role provider for bottom nav and other elements
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final expectedRole = roleStr == 'provider' ? UserRole.provider : UserRole.hirer;
          if (ref.read(roleProvider) != expectedRole) {
            ref.read(roleProvider.notifier).state = expectedRole;
          }
        });

        if (roleStr == 'provider') {
          return ProviderHomeScreen(userName: name);
        }
        return HirerHomeScreen(userName: name);
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator(color: AppColors.primary))),
      error: (_, __) => const HirerHomeScreen(userName: 'Guest'),
    );
  }
}

class HirerHomeScreen extends StatefulWidget {
  final String userName;
  const HirerHomeScreen({super.key, required this.userName});

  @override
  State<HirerHomeScreen> createState() => _HirerHomeScreenState();
}

class _HirerHomeScreenState extends State<HirerHomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    if (query.trim().isEmpty) return;
    context.push('/search?q=${Uri.encodeComponent(query)}');
  }

  @override
  Widget build(BuildContext context) {
    final providers = DummyData.providers;
    final bookings = DummyData.bookings;
    // Just showing active/recent bookings
    final recentBookings = bookings.take(2).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AmanGharBottomNav(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSpacing.lg.h),
              
              // ── Header (Greeting + Avatar) ───────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.greetingMorning,
                          style: AppTextStyles.bodyMedium,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          widget.userName,
                          style: AppTextStyles.headingMedium,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => context.go('/profile'),
                      child: Hero(
                        tag: 'profile-avatar',
                        child: CircleAvatar(
                          radius: 24.r,
                          backgroundColor: AppColors.primaryLight,
                          child: Text(
                            widget.userName.isNotEmpty ? widget.userName[0].toUpperCase() : 'U',
                            style: AppTextStyles.headingSmall.copyWith(color: AppColors.primaryDark),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: AppSpacing.lg.h),

              // ── Search Bar ───────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: _handleSearch,
                  style: AppTextStyles.bodyLarge,
                  decoration: InputDecoration(
                    hintText: AppStrings.searchHint,
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.tune_rounded),
                      onPressed: () {
                        // Show filter bottom sheet (placeholder for future implementation)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Filters coming soon', style: AppTextStyles.bodyMedium.copyWith(color: Colors.white)),
                            backgroundColor: AppColors.textPrimary,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),

              // ── Services Horizontal List ─────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SectionHeader(AppStrings.servicesSection),
                    TextButton(
                      onPressed: () => context.push('/search?q='),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        AppStrings.seeAll,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.sm.h),
              SizedBox(
                height: 210.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: providers.length,
                  separatorBuilder: (_, __) => SizedBox(width: AppSpacing.md.w),
                  itemBuilder: (_, index) {
                    return ServiceCard(provider: providers[index]);
                  },
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),

              // ── Recent Bookings ──────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SectionHeader(AppStrings.recentBookingsSection),
                    TextButton(
                      onPressed: () => context.go('/my-bookings'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        AppStrings.seeAll,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.sm.h),
              ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recentBookings.length,
                separatorBuilder: (_, __) => SizedBox(height: AppSpacing.sm.h),
                itemBuilder: (_, index) {
                  return BookingCard(
                    booking: recentBookings[index],
                    onBookAgain: () => context.push('/provider/${recentBookings[index].providerId}'),
                    onRateNow: () => context.push('/rate-now/${recentBookings[index].providerId}'),
                  );
                },
              ),
              
              SizedBox(height: AppSpacing.xxl.h),
            ],
          ),
        ),
      ),
    );
  }
}
