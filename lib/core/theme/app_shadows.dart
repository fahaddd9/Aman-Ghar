// Purpose: Centralized shadow definitions for the AmanGhar design system.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 1: Establish Strong Design System

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

/// AppShadows — Custom BoxShadow definitions. Never use Material elevation.
class AppShadows {
  AppShadows._();

  static List<BoxShadow> get card => [
        BoxShadow(
          color: const Color(0x0D000000),
          blurRadius: 12.r,
          spreadRadius: 0,
          offset: Offset(0, 4.h),
        ),
      ];

  static List<BoxShadow> get button => [
        BoxShadow(
          color: AppColors.primary.withValues(alpha: 0.28),
          blurRadius: 8.r,
          offset: Offset(0, 3.h),
        ),
      ];

  static List<BoxShadow> get sheet => [
        BoxShadow(
          color: const Color(0x1A000000),
          blurRadius: 20.r,
          offset: Offset(0, -4.h),
        ),
      ];
}
