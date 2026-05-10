// Purpose: AmanGhar launch screen with staggered fade-in animations.
// After 2.5s → navigates to /role-select
// Doc: 04_ui_improvement_and_fix_phase.md — Step 2: Logo & Splash

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;
  late final Animation<double> _titleFade;
  late final Animation<double> _taglineFade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
      ),
    );
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );
    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.55, curve: Curves.easeOut),
      ),
    );
    _taglineFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.75, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(AppDurations.splash);
    if (!mounted) return;
    context.go('/role-select');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── Logo ─────────────────────────────────────────────────
                FadeTransition(
                  opacity: _logoFade,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        color: AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            blurRadius: 24.r,
                            offset: Offset(0, 8.h),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.home_rounded,
                          size: 56.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: AppSpacing.md.h),

                // ── App Name ─────────────────────────────────────────────
                FadeTransition(
                  opacity: _titleFade,
                  child: Column(
                    children: [
                      Text(
                        AppStrings.appName,
                        style: AppTextStyles.displayLarge.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: AppSpacing.xs.h),
                      Text(
                        AppStrings.appNameUrdu,
                        style: AppTextStyles.headingMedium.copyWith(
                          color: AppColors.primary.withValues(alpha: 0.6),
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: AppSpacing.sm.h),

                // ── Tagline ──────────────────────────────────────────────
                FadeTransition(
                  opacity: _taglineFade,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl.w),
                    child: Text(
                      AppStrings.tagline,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                SizedBox(height: AppSpacing.xxl.h),

                // ── Loading indicator ────────────────────────────────────
                FadeTransition(
                  opacity: _taglineFade,
                  child: SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.primary.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
