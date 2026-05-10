// Purpose: Provider Earnings Screen.
// Doc: 05_complete_ui_and_provider_side.md

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../shared/widgets/section_header.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Earnings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.md.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Balance Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSpacing.lg.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  boxShadow: AppShadows.card,
                ),
                child: Column(
                  children: [
                    Text(
                      'Available Balance',
                      style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
                    ),
                    SizedBox(height: AppSpacing.sm.h),
                    Text(
                      AppStrings.formatPriceRaw(12500),
                      style: AppTextStyles.displayLarge.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: AppSpacing.lg.h),
                    ElevatedButton(
                      onPressed: () => context.push('/withdraw'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.button),
                        ),
                        minimumSize: Size(double.infinity, 44.h),
                      ),
                      child: Text(
                        'WITHDRAW FUNDS',
                        style: AppTextStyles.headingSmall.copyWith(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),
              
              // Stats
              Row(
                children: [
                  Expanded(
                    child: _EarningStatCard(title: 'This Week', value: AppStrings.formatPriceRaw(4500)),
                  ),
                  SizedBox(width: AppSpacing.md.w),
                  Expanded(
                    child: _EarningStatCard(title: 'This Month', value: AppStrings.formatPriceRaw(18000)),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.xl.h),

              // Recent Transactions
              const SectionHeader('Recent Transactions'),
              SizedBox(height: AppSpacing.md.h),
              
              _TransactionTile(
                name: 'Ayesha Malik',
                date: 'Today, 2:30 PM',
                amount: 1800,
                isCredit: true,
              ),
              _TransactionTile(
                name: 'Withdrawal to Bank',
                date: 'Yesterday, 10:00 AM',
                amount: 5000,
                isCredit: false,
              ),
              _TransactionTile(
                name: 'Zainab Fatima',
                date: 'May 4, 4:00 PM',
                amount: 1200,
                isCredit: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EarningStatCard extends StatelessWidget {
  final String title;
  final String value;

  const _EarningStatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.bodyMedium),
          SizedBox(height: 4.h),
          Text(value, style: AppTextStyles.headingSmall),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final String name;
  final String date;
  final int amount;
  final bool isCredit;

  const _TransactionTile({
    required this.name,
    required this.date,
    required this.amount,
    required this.isCredit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.sm.h),
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: isCredit ? AppColors.success.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCredit ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
              color: isCredit ? AppColors.success : AppColors.error,
              size: 20.sp,
            ),
          ),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.headingSmall),
                Text(date, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Text(
            '${isCredit ? '+' : '-'} ${AppStrings.formatPriceRaw(amount)}',
            style: AppTextStyles.price.copyWith(
              fontSize: 14.sp,
              color: isCredit ? AppColors.success : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
