// Purpose: List of all past and active bookings (or requests for providers).
// Doc: 05_complete_ui_and_provider_side.md

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/data/dummy_data.dart';
import '../../core/models/booking_model.dart';
import '../../core/providers/role_provider.dart';
import '../../shared/widgets/booking_card.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import '../../shared/widgets/custom_filled_button.dart';

class MyBookingsScreen extends ConsumerWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(roleProvider);
    final isProvider = role == UserRole.provider;

    // Dummy data handling based on role
    final items = isProvider 
        ? DummyData.bookings.where((b) => b.status != BookingStatus.cancelled).toList() 
        : DummyData.bookings;

    final title = isProvider ? 'My Requests' : AppStrings.myBookings;
    final emptyStateText = isProvider ? 'No requests yet' : AppStrings.noBookings;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        leading: context.canPop()
            ? IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              )
            : null,
      ),
      bottomNavigationBar: const AmanGharBottomNav(currentIndex: 1),
      body: SafeArea(
        child: items.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isProvider ? Icons.receipt_long_rounded : Icons.calendar_today_rounded,
                      size: 64.sp,
                      color: AppColors.textHint.withValues(alpha: 0.5),
                    ),
                    SizedBox(height: AppSpacing.md.h),
                    Text(
                      emptyStateText,
                      style: AppTextStyles.headingMedium.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.all(AppSpacing.md.w),
                itemCount: items.length,
                separatorBuilder: (_, __) => SizedBox(height: AppSpacing.sm.h),
                itemBuilder: (_, i) {
                  final item = items[i];
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: Duration(milliseconds: 300 + i * 60),
                    curve: Curves.easeOutCubic,
                    builder: (_, value, child) => Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 16 * (1 - value)),
                        child: child,
                      ),
                    ),
                    child: isProvider
                        ? _ProviderRequestCard(booking: item)
                        : BookingCard(
                            booking: item,
                            onBookAgain: () => context.push('/provider/${item.providerId}'),
                            onRateNow: () => context.push('/rate-now/${item.providerId}'),
                          ),
                  );
                },
              ),
      ),
    );
  }
}

class _ProviderRequestCard extends StatelessWidget {
  final Booking booking;

  const _ProviderRequestCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Request #${booking.id}', style: AppTextStyles.caption),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(AppRadius.badge),
                ),
                child: Text(
                  booking.status.name.toUpperCase(),
                  style: AppTextStyles.label.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm.h),
          Text(booking.serviceType, style: AppTextStyles.headingMedium),
          SizedBox(height: AppSpacing.xs.h),
          Row(
            children: [
              Icon(Icons.calendar_today_rounded, size: 16.sp, color: AppColors.textHint),
              SizedBox(width: 4.w),
              Text('${booking.date} • ${booking.time}', style: AppTextStyles.bodyMedium),
            ],
          ),
          SizedBox(height: AppSpacing.md.h),
          Row(
            children: [
              Expanded(
                child: CustomFilledButton(
                  label: 'VIEW DETAILS',
                  height: 36.h,
                  onTap: () {
                    context.push('/request-detail/${booking.id}');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
