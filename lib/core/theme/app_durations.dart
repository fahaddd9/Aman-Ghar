// Purpose: Centralized animation duration constants for the AmanGhar design system.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 1: Establish Strong Design System

/// AppDurations — All animation durations used across AmanGhar.
class AppDurations {
  AppDurations._();

  static const Duration instant = Duration(milliseconds: 120);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 280);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration splash = Duration(milliseconds: 2500);
  static const Duration staggerDelay = Duration(milliseconds: 50);
}
