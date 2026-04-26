import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppColors — AmanGhar Design System Colors
// ─────────────────────────────────────────────────────────────────────────────
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF4CAF50);
  static const Color primaryDark = Color(0xFF388E3C);
  static const Color primaryLight = Color(0xFFA5D6A7);
  static const Color secondary = Color(0xFFFF9800);
  static const Color secondaryLight = Color(0xFFFFE0B2);
  static const Color accent = Color(0xFF2196F3);
  static const Color background = Color(0xFFFAF9F6);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1F1F1F);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFFAAAAAA);
  static const Color divider = Color(0xFFEEEEEE);
  static const Color error = Color(0xFFE53935);
  static const Color verified = Color(0xFF43A047);
  static const Color starRating = Color(0xFFFFC107);
}

// ─────────────────────────────────────────────────────────────────────────────
// AppSpacing — AmanGhar Spacing Constants
// ─────────────────────────────────────────────────────────────────────────────
class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

// ─────────────────────────────────────────────────────────────────────────────
// AppRadius — AmanGhar Border Radius Constants
// ─────────────────────────────────────────────────────────────────────────────
class AppRadius {
  AppRadius._();

  static const double card = 16.0;
  static const double chip = 12.0;
  static const double button = 12.0;
  static const double avatar = 50.0;
  static const double badge = 6.0;
  static const double input = 12.0;
}

// ─────────────────────────────────────────────────────────────────────────────
// AppShadows — AmanGhar Shadow Definitions (no Material elevation — custom only)
// ─────────────────────────────────────────────────────────────────────────────
class AppShadows {
  AppShadows._();

  static final List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.07),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static final List<BoxShadow> button = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.25),
      blurRadius: 8,
      offset: const Offset(0, 3),
    ),
  ];
}

// ─────────────────────────────────────────────────────────────────────────────
// AppTextStyles — AmanGhar Typography System
// ─────────────────────────────────────────────────────────────────────────────
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get headingLarge => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get headingMedium => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get headingSmall => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get label => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        letterSpacing: 0.8,
      );

  static TextStyle get price => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        height: 1.3,
      );

  static TextStyle get rating => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      );
}

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
        shadow: Colors.black,
        scrim: Colors.black,
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
        centerTitle: false,
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
            GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
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
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        displayLarge: AppTextStyles.headingLarge,
        displayMedium: AppTextStyles.headingMedium,
        displaySmall: AppTextStyles.headingSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.label,
      ),
    );
  }
}
