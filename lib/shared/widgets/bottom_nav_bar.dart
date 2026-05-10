// Purpose: Shared bottom navigation bar with 4 items — Home, Bookings, Inbox, Profile.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 8: Bottom Navigation & Global Navigation Fix

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/providers/role_provider.dart';

/// AmanGharBottomNav — 4-tab bottom navigation.
/// 0=Home, 1=Bookings/Requests, 2=Inbox, 3=Profile
class AmanGharBottomNav extends ConsumerWidget {
  final int currentIndex;
  const AmanGharBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(roleProvider);
    final bool isProvider = role == UserRole.provider;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D000000),
            blurRadius: 12.r,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                isSelected: currentIndex == 0,
                onTap: () {
                  if (currentIndex != 0) context.go('/home');
                },
              ),
              _NavItem(
                icon: isProvider ? Icons.receipt_long_rounded : Icons.calendar_month_rounded,
                label: isProvider ? 'Requests' : 'Bookings',
                isSelected: currentIndex == 1,
                onTap: () {
                  if (currentIndex != 1) context.go('/my-bookings');
                },
              ),
              _NavItem(
                icon: Icons.chat_bubble_outline_rounded,
                label: 'Inbox',
                isSelected: currentIndex == 2,
                onTap: () {
                  if (currentIndex != 2) context.go('/inbox');
                },
              ),
              _NavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                isSelected: currentIndex == 3,
                onTap: () {
                  if (currentIndex != 3) context.go('/profile');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color =
        isSelected ? AppColors.primary : AppColors.textHint;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: AppDurations.fast,
              curve: Curves.easeOut,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primarySurface
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppRadius.chip),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: color,
                fontSize: 10.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
