// Purpose: Booking Tracking / Status Screen.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 6

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/data/dummy_data.dart';
import '../../shared/widgets/custom_filled_button.dart';
import '../../shared/widgets/custom_outlined_button.dart';

class BookingStatusScreen extends StatelessWidget {
  const BookingStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Just grab the first provider for dummy tracking
    final provider = DummyData.providers.first;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.statusTitle),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Map Placeholder ───────────────────────────────────────
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: AppColors.divider,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.map_rounded,
                      size: 100.sp,
                      color: AppColors.textHint.withValues(alpha: 0.5),
                    ),
                    Positioned(
                      bottom: AppSpacing.md.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.md.w, vertical: AppSpacing.sm.h),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.chip),
                          boxShadow: AppShadows.card,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.directions_car_rounded,
                                color: AppColors.primary, size: 20.sp),
                            SizedBox(width: AppSpacing.sm.w),
                            Text(
                              AppStrings.eta,
                              style: AppTextStyles.headingSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Tracking Info Bottom Sheet ────────────────────────────
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSpacing.lg.w),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppRadius.sheet),
                  ),
                  boxShadow: AppShadows.sheet,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Provider Info
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28.r,
                          backgroundColor: AppColors.primaryLight,
                          backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=47'),
                        ),
                        SizedBox(width: AppSpacing.md.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(provider.name, style: AppTextStyles.headingSmall),
                              Text(AppStrings.onTheWay, style: AppTextStyles.bodyMedium),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppRadius.badge),
                          ),
                          child: Text(
                            'ON THE WAY',
                            style: AppTextStyles.label.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const Divider(height: AppSpacing.xl * 2),

                    // Progress Stepper
                    Expanded(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: AppStrings.bookingSteps.length,
                        itemBuilder: (context, index) {
                          final String step = AppStrings.bookingSteps[index];
                          // Dummy logic: first two steps completed, third active
                          final bool isCompleted = index < 2;
                          final bool isActive = index == 2;
                          final bool isLast = index == AppStrings.bookingSteps.length - 1;

                          return _buildStep(
                            title: step,
                            time: isCompleted ? '08:00 AM' : (isActive ? '08:15 AM' : '--:--'),
                            isCompleted: isCompleted,
                            isActive: isActive,
                            isLast: isLast,
                          );
                        },
                      ),
                    ),

                    SizedBox(height: AppSpacing.md.h),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: CustomOutlinedButton(
                            label: 'CALL',
                            icon: Icons.phone_rounded,
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: AppSpacing.md.w),
                        Expanded(
                          child: CustomFilledButton(
                            label: 'CHAT',
                            icon: Icons.chat_bubble_rounded,
                            onTap: () => context.push('/chat/${provider.id}'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep({
    required String title,
    required String time,
    required bool isCompleted,
    required bool isActive,
    required bool isLast,
  }) {
    final Color color = isCompleted || isActive ? AppColors.primary : AppColors.divider;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon Column
        Column(
          children: [
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.primary : (isActive ? AppColors.surface : AppColors.background),
                shape: BoxShape.circle,
                border: Border.all(
                  color: color,
                  width: isActive ? 4 : 1,
                ),
              ),
              child: isCompleted
                  ? Icon(Icons.check_rounded, size: 16.sp, color: Colors.white)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2.w,
                height: 36.h,
                color: color,
              ),
          ],
        ),
        SizedBox(width: AppSpacing.md.w),
        
        // Text Column
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: isCompleted || isActive ? FontWeight.w600 : FontWeight.w400,
                    color: isCompleted || isActive ? AppColors.textPrimary : AppColors.textHint,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  time,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isCompleted || isActive ? AppColors.textSecondary : AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
