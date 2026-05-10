// Purpose: Centralized color constants for the AmanGhar design system.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 1: Establish Strong Design System

import 'package:flutter/material.dart';

/// AppColors — AmanGhar Design System Colors
/// All colors use 8-digit hex (0xFFxxxxxx). Never redefine inline.
class AppColors {
  AppColors._();

  // ── Primary (Trust Green) ──────────────────────────────────────────────────
  static const Color primary = Color(0xFF4CAF50);
  static const Color primaryDark = Color(0xFF388E3C);
  static const Color primaryLight = Color(0xFFA5D6A7);
  static const Color primarySurface = Color(0xFFE8F5E9);

  // ── Secondary (Warm Orange) ────────────────────────────────────────────────
  static const Color secondary = Color(0xFFFF9800);
  static const Color secondaryLight = Color(0xFFFFE0B2);

  // ── Accent (Blue — info, links) ────────────────────────────────────────────
  static const Color accent = Color(0xFF2196F3);

  // ── Surfaces ───────────────────────────────────────────────────────────────
  static const Color background = Color(0xFFFAF9F6);
  static const Color surface = Color(0xFFFFFFFF);

  // ── Text ───────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1F1F1F);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFFAAAAAA);
  static const Color onSurface = Color(0xFF1F1F1F);

  // ── Semantic ───────────────────────────────────────────────────────────────
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFFC107);

  // ── Utility ────────────────────────────────────────────────────────────────
  static const Color divider = Color(0xFFEEEEEE);
  static const Color starRating = Color(0xFFFFC107);
  static const Color verified = Color(0xFF43A047);
  static const Color overlay = Color(0x80000000);
}
