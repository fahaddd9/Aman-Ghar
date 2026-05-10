// Purpose: Payment history screen.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 8

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/data/dummy_data.dart';
import '../../core/models/booking_model.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We'll reuse bookings as mock payments since they have prices
    final payments = DummyData.bookings.where((b) => b.status == BookingStatus.completed).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.paymentHistoryTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: payments.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.receipt_long_rounded,
                      size: 64.sp,
                      color: AppColors.textHint.withValues(alpha: 0.5),
                    ),
                    SizedBox(height: AppSpacing.md.h),
                    Text(
                      AppStrings.noPayments,
                      style: AppTextStyles.headingMedium.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.all(AppSpacing.md.w),
                itemCount: payments.length,
                separatorBuilder: (_, __) => SizedBox(height: AppSpacing.sm.h),
                itemBuilder: (_, index) {
                  final payment = payments[index];
                  // Staggered slide animation
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: Duration(milliseconds: 300 + (index * 60)),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(AppSpacing.md.w),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        boxShadow: AppShadows.card,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: AppColors.primarySurface,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.payment_rounded, color: AppColors.primary, size: 24.sp),
                          ),
                          SizedBox(width: AppSpacing.md.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  payment.providerName,
                                  style: AppTextStyles.headingSmall,
                                ),
                                Text(
                                  '${payment.date} • Card ending in 4242',
                                  style: AppTextStyles.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            AppStrings.formatPriceRaw(1800), // Mock fixed price
                            style: AppTextStyles.price.copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
