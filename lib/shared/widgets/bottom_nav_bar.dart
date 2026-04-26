import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AmanGharBottomNav — Shared BottomNavigationBar used across Home, Bookings,
// Profile screens. currentIndex: 0=Home, 1=Bookings, 2=Profile
// ─────────────────────────────────────────────────────────────────────────────
class AmanGharBottomNav extends StatelessWidget {
  final int currentIndex;
  const AmanGharBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textHint,
      backgroundColor: AppColors.surface,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle:
          AppTextStyles.bodySmall.copyWith(color: AppColors.primary),
      unselectedLabelStyle: AppTextStyles.bodySmall,
      onTap: (i) {
        if (i == 0 && currentIndex != 0) context.go('/home');
        if (i == 1 && currentIndex != 1) context.go('/my-bookings');
        if (i == 2 && currentIndex != 2) context.go('/profile');
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_rounded),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
    );
  }
}
