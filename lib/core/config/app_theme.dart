// Purpose: AmanGhar Material 3 ThemeData and design system barrel export.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 1: Establish Strong Design System

// Re-export all design tokens so screens can import a single file
export 'package:amanghar_app/core/theme/app_colors.dart';
export 'package:amanghar_app/core/theme/app_text_styles.dart';
export 'package:amanghar_app/core/theme/app_spacing.dart';
export 'package:amanghar_app/core/theme/app_radius.dart';
export 'package:amanghar_app/core/theme/app_shadows.dart';
export 'package:amanghar_app/core/theme/app_durations.dart';
export 'package:amanghar_app/core/theme/app_strings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amanghar_app/core/theme/app_colors.dart';
import 'package:amanghar_app/core/theme/app_radius.dart';
import 'package:amanghar_app/core/theme/app_text_styles.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppTheme — AmanGhar Material 3 ThemeData
// ─────────────────────────────────────────────────────────────────────────────
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.surface,
        primaryContainer: AppColors.primaryLight,
        onPrimaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondary,
        onSecondary: AppColors.surface,
        secondaryContainer: AppColors.secondaryLight,
        onSecondaryContainer: Color(0xFFE65100),
        tertiary: AppColors.accent,
        onTertiary: AppColors.surface,
        tertiaryContainer: Color(0xFFBBDEFB),
        onTertiaryContainer: Color(0xFF0D47A1),
        error: AppColors.error,
        onError: AppColors.surface,
        errorContainer: Color(0xFFFFCDD2),
        onErrorContainer: Color(0xFFB71C1C),
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        surfaceContainerHighest: AppColors.background,
        onSurfaceVariant: AppColors.textSecondary,
        outline: AppColors.divider,
        outlineVariant: AppColors.textHint,
        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),
        inverseSurface: AppColors.textPrimary,
        onInverseSurface: AppColors.surface,
        inversePrimary: AppColors.primaryLight,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.headingSmall,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textHint,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.primary,
        labelStyle:
            GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w500),
        side: const BorderSide(color: AppColors.divider),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.chip),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle:
            AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.headingLarge,
        displaySmall: AppTextStyles.headingMedium,
        headlineMedium: AppTextStyles.headingSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.label,
      ),
    );
  }
}
