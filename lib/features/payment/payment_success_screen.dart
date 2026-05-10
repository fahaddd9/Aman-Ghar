// Purpose: Success screen after payment.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 7

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../shared/widgets/custom_filled_button.dart';
import '../../shared/widgets/custom_outlined_button.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.slow,
    );

    _scale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg.w),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  // Success Icon Animation
                  ScaleTransition(
                    scale: _scale,
                    child: Container(
                      width: 120.w,
                      height: 120.w,
                      decoration: BoxDecoration(
                        color: AppColors.primarySurface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            blurRadius: 24.r,
                            spreadRadius: 8.r,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.check_circle_rounded,
                        size: 80.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  SizedBox(height: AppSpacing.xxl.h),

                  // Text Content
                  FadeTransition(
                    opacity: _fade,
                    child: Column(
                      children: [
                        Text(
                          AppStrings.successTitle,
                          style: AppTextStyles.displayLarge.copyWith(color: AppColors.primary),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: AppSpacing.sm.h),
                        Text(
                          AppStrings.successSubtitle,
                          style: AppTextStyles.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Action Buttons
                  FadeTransition(
                    opacity: _fade,
                    child: Column(
                      children: [
                        CustomFilledButton(
                          label: AppStrings.trackBookingStatus,
                          onTap: () => context.pushReplacement('/booking-status'),
                        ),
                        SizedBox(height: AppSpacing.md.h),
                        CustomOutlinedButton(
                          label: 'BACK TO HOME',
                          onTap: () => context.go('/home'),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: AppSpacing.lg.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
