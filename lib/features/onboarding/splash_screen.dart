import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/app_constants.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SplashScreen — AmanGhar launch screen with staggered AnimatedOpacity
// After 2.5s → navigates to /role-select
// ─────────────────────────────────────────────────────────────────────────────
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const bool enableAnimations = true;

  double _logoOpacity = 0;
  double _titleOpacity = 0;
  double _taglineOpacity = 0;

  @override
  void initState() {
    super.initState();
    _runAnimations();
  }

  Future<void> _runAnimations() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;
    setState(() => _logoOpacity = 1.0);

    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    setState(() => _titleOpacity = 1.0);

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    setState(() => _taglineOpacity = 1.0);

    await Future.delayed(const Duration(milliseconds: 1300));
    if (!mounted) return;
    context.go('/role-select');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── Logo ─────────────────────────────────────────────────────
            AnimatedOpacity(
              opacity: enableAnimations ? _logoOpacity : 1.0,
              duration: AppConstants.splashLogoFadeDuration,
              curve: Curves.easeIn,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.home_rounded,
                    size: 56,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // ── App Name ─────────────────────────────────────────────────
            AnimatedOpacity(
              opacity: enableAnimations ? _titleOpacity : 1.0,
              duration: AppConstants.splashLogoFadeDuration,
              curve: Curves.easeIn,
              child: Column(
                children: [
                  Text(
                    AppConstants.appName,
                    style: AppTextStyles.headingLarge.copyWith(
                      color: AppColors.primary,
                      fontSize: 32,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    AppConstants.appNameUrdu,
                    style: AppTextStyles.headingMedium.copyWith(
                      color: AppColors.primary.withValues(alpha: 0.6),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            // ── Tagline ───────────────────────────────────────────────────
            AnimatedOpacity(
              opacity: enableAnimations ? _taglineOpacity : 1.0,
              duration: AppConstants.splashLogoFadeDuration,
              curve: Curves.easeIn,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Text(
                  AppConstants.tagline,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // ── Loading indicator ─────────────────────────────────────────
            AnimatedOpacity(
              opacity: enableAnimations ? _taglineOpacity : 1.0,
              duration: AppConstants.splashLogoFadeDuration,
              curve: Curves.easeIn,
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.primary.withValues(alpha: 0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
