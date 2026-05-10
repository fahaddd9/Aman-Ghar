// Purpose: About app screen.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 8

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.aboutTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.xl.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppSpacing.xl.h),
              
              // Logo
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.home_rounded,
                    size: 64.sp,
                    color: AppColors.primary,
                  ),
                ),
              ),
              
              SizedBox(height: AppSpacing.lg.h),
              
              // Name & Version
              Text(AppStrings.appName, style: AppTextStyles.displayLarge),
              SizedBox(height: AppSpacing.xs.h),
              Text(AppStrings.appVersion, style: AppTextStyles.bodyMedium),
              
              SizedBox(height: AppSpacing.xxl.h),
              
              // Description
              Text(
                AppStrings.aboutDescription,
                style: AppTextStyles.bodyLarge,
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: AppSpacing.xxl.h * 1.5),
              
              // Links
              ListTile(
                title: Text(AppStrings.privacyPolicy, style: AppTextStyles.headingSmall),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16.sp, color: AppColors.textHint),
                onTap: () {},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.card)),
                tileColor: AppColors.surface,
              ),
              SizedBox(height: AppSpacing.sm.h),
              ListTile(
                title: Text(AppStrings.termsOfService, style: AppTextStyles.headingSmall),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16.sp, color: AppColors.textHint),
                onTap: () {},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.card)),
                tileColor: AppColors.surface,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
