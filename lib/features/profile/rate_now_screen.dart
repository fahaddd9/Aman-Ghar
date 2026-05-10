// Purpose: Rate your experience screen after booking completes.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 8

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/data/dummy_data.dart';
import '../../shared/widgets/custom_filled_button.dart';

class RateNowScreen extends StatefulWidget {
  final String providerId;
  const RateNowScreen({super.key, required this.providerId});

  @override
  State<RateNowScreen> createState() => _RateNowScreenState();
}

class _RateNowScreenState extends State<RateNowScreen> {
  double _rating = 5.0;
  bool _isLoading = false;
  bool _isSubmitted = false;

  void _handleSubmit() async {
    setState(() => _isLoading = true);
    await Future.delayed(AppDurations.slow);
    if (!mounted) return;
    
    setState(() {
      _isLoading = false;
      _isSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = DummyData.providers.firstWhere(
      (p) => p.id == widget.providerId,
      orElse: () => DummyData.providers.first,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.rateNowTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: _isSubmitted 
            ? _buildSuccessView() 
            : _buildFormView(provider.name),
      ),
    );
  }

  Widget _buildFormView(String providerName) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.lg.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: AppSpacing.xl.h),
          
          CircleAvatar(
            radius: 40.r,
            backgroundColor: AppColors.primaryLight,
            backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=47'),
          ),
          
          SizedBox(height: AppSpacing.lg.h),
          Text(
            '${AppStrings.ratePrompt} $providerName?',
            style: AppTextStyles.headingLarge,
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: AppSpacing.xl.h),
          
          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 48.sp,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
            itemBuilder: (context, _) => const Icon(
              Icons.star_rounded,
              color: AppColors.starRating,
            ),
            onRatingUpdate: (rating) {
              setState(() => _rating = rating);
            },
          ),
          
          SizedBox(height: AppSpacing.xxl.h),
          
          TextField(
            maxLines: 4,
            style: AppTextStyles.bodyLarge,
            decoration: InputDecoration(
              hintText: AppStrings.writeReview,
              alignLabelWithHint: true,
            ),
          ),
          
          SizedBox(height: AppSpacing.xxl.h),
          
          CustomFilledButton(
            label: AppStrings.submitReview,
            isLoading: _isLoading,
            onTap: _handleSubmit,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_circle_rounded, size: 60.sp, color: AppColors.primary),
            ),
            SizedBox(height: AppSpacing.xl.h),
            Text(AppStrings.thankYou, style: AppTextStyles.displayLarge),
            SizedBox(height: AppSpacing.sm.h),
            Text(
              AppStrings.reviewSubmitted,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.xxl.h),
            CustomFilledButton(
              label: 'BACK TO MY BOOKINGS',
              onTap: () {
                context.pop();
                // If they came from somewhere else, this at least goes back.
                // Or we could context.go('/my-bookings');
              },
            ),
          ],
        ),
      ),
    );
  }
}
