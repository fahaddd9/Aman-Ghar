// Purpose: Provider Side Home Screen (Dashboard).
// Doc: 05_complete_ui_and_provider_side.md

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/data/dummy_data.dart';
import '../../core/models/booking_model.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/custom_filled_button.dart';
import '../../shared/widgets/custom_outlined_button.dart';

class ProviderHomeScreen extends StatefulWidget {
  final String userName;
  const ProviderHomeScreen({super.key, required this.userName});

  @override
  State<ProviderHomeScreen> createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {

  @override
  Widget build(BuildContext context) {
    // Dummy incoming requests (reusing bookings with "booked" status)
    final requests = DummyData.bookings.where((b) => b.status == BookingStatus.booked).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AmanGharBottomNav(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSpacing.lg.h),
              
              // ── Header (Greeting + Availability Toggle) ───────────────
              Row(
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
                        widget.userName, // Use actual dynamic username
                        style: AppTextStyles.headingMedium,
                      ),
                    ],
                  ),
                  // Removed online toggle as per user request
                ],
              ),
              
              SizedBox(height: AppSpacing.xl.h),

              // ── Summary Cards ─────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      title: 'Today\'s Earnings',
                      value: AppStrings.formatPriceRaw(3500),
                      icon: Icons.account_balance_wallet_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: AppSpacing.md.w),
                  Expanded(
                    child: _SummaryCard(
                      title: 'Active Bookings',
                      value: '2',
                      icon: Icons.calendar_month_rounded,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.xl.h),

              // ── Incoming Requests ─────────────────────────────────────
              const SectionHeader('Incoming Requests'),
              SizedBox(height: AppSpacing.sm.h),
              
              if (requests.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.xl.w),
                    child: Column(
                      children: [
                        Icon(Icons.inbox_rounded, size: 64.sp, color: AppColors.textHint.withValues(alpha: 0.5)),
                        SizedBox(height: AppSpacing.md.h),
                        Text(
                          'No new requests',
                          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: requests.length,
                  separatorBuilder: (_, __) => SizedBox(height: AppSpacing.md.h),
                  itemBuilder: (_, index) {
                    final req = requests[index];
                    return _RequestCard(
                      name: 'Ayesha Malik', // Dummy hirer name
                      service: req.serviceType,
                      date: req.date,
                      time: req.time,
                      location: AppStrings.dummyUserLocation,
                      price: 1800,
                      onViewDetails: () => context.push('/request-detail/${req.id}'),
                      onAccept: () {},
                      onReject: () {},
                    );
                  },
                ),
                
              SizedBox(height: AppSpacing.xl.h),
              
              // ── Quick Stats ───────────────────────────────────────────
              const SectionHeader('My Stats'),
              SizedBox(height: AppSpacing.sm.h),
              Container(
                padding: EdgeInsets.all(AppSpacing.md.w),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  boxShadow: AppShadows.card,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(label: 'Rating', value: '4.8', icon: Icons.star_rounded, iconColor: AppColors.starRating),
                    Container(width: 1, height: 40.h, color: AppColors.divider),
                    _StatItem(label: 'Jobs', value: '142', icon: Icons.check_circle_rounded, iconColor: AppColors.success),
                    Container(width: 1, height: 40.h, color: AppColors.divider),
                    _StatItem(label: 'Profile', value: '100%', icon: Icons.person_rounded, iconColor: AppColors.primary),
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.xxl.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28.sp),
          SizedBox(height: AppSpacing.md.h),
          Text(value, style: AppTextStyles.headingMedium.copyWith(color: color)),
          SizedBox(height: 4.h),
          Text(title, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final String name;
  final String service;
  final String date;
  final String time;
  final String location;
  final int price;
  final VoidCallback onViewDetails;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const _RequestCard({
    required this.name,
    required this.service,
    required this.date,
    required this.time,
    required this.location,
    required this.price,
    required this.onViewDetails,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.card,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: AppColors.primaryLight,
                backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=12'),
              ),
              SizedBox(width: AppSpacing.sm.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyles.headingSmall),
                    Text(service, style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
              Text(AppStrings.formatPriceRaw(price), style: AppTextStyles.price.copyWith(fontSize: 14.sp)),
            ],
          ),
          SizedBox(height: AppSpacing.md.h),
          Row(
            children: [
              Icon(Icons.calendar_today_rounded, size: 16.sp, color: AppColors.textHint),
              SizedBox(width: 4.w),
              Text('$date • $time', style: AppTextStyles.bodyMedium),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(Icons.location_on_rounded, size: 16.sp, color: AppColors.textHint),
              SizedBox(width: 4.w),
              Text(location, style: AppTextStyles.bodyMedium),
            ],
          ),
          SizedBox(height: AppSpacing.md.h),
          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  label: 'VIEW DETAILS',
                  textColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  height: 40.h,
                  onTap: onViewDetails,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm.h),
          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  label: 'REJECT',
                  textColor: AppColors.error,
                  borderColor: AppColors.error,
                  height: 40.h,
                  onTap: onReject,
                ),
              ),
              SizedBox(width: AppSpacing.md.w),
              Expanded(
                child: CustomFilledButton(
                  label: 'ACCEPT',
                  height: 40.h,
                  onTap: onAccept,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 28.sp),
        SizedBox(height: 4.h),
        Text(value, style: AppTextStyles.headingSmall),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}
