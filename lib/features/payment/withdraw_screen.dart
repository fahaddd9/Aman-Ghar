import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../shared/widgets/custom_filled_button.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  String _selectedMethod = 'bank';
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Withdraw Funds'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.md.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Available Balance', style: AppTextStyles.bodyMedium),
              SizedBox(height: 4.h),
              Text(AppStrings.formatPriceRaw(3500), style: AppTextStyles.displayLarge.copyWith(color: AppColors.primary)),
              
              SizedBox(height: AppSpacing.xl.h),
              
              Text('Enter Amount', style: AppTextStyles.headingMedium),
              SizedBox(height: AppSpacing.sm.h),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: AppTextStyles.headingLarge,
                decoration: const InputDecoration(
                  prefixText: 'Rs. ',
                  hintText: '0',
                ),
              ),
              
              SizedBox(height: AppSpacing.xl.h),
              
              Text('Withdrawal Method', style: AppTextStyles.headingMedium),
              SizedBox(height: AppSpacing.sm.h),
              
              _MethodCard(
                title: 'Bank Transfer',
                subtitle: 'Takes 1-2 business days',
                icon: Icons.account_balance_rounded,
                isSelected: _selectedMethod == 'bank',
                onTap: () => setState(() => _selectedMethod = 'bank'),
              ),
              SizedBox(height: AppSpacing.sm.h),
              _MethodCard(
                title: 'JazzCash / EasyPaisa',
                subtitle: 'Instant transfer',
                icon: Icons.phone_android_rounded,
                isSelected: _selectedMethod == 'mobile',
                onTap: () => setState(() => _selectedMethod = 'mobile'),
              ),
              
              SizedBox(height: AppSpacing.xxl.h),
              
              CustomFilledButton(
                label: 'CONFIRM WITHDRAWAL',
                onTap: () {
                  if (_amountController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter an amount')));
                    return;
                  }
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Withdrawal request submitted successfully.'),
                      backgroundColor: AppColors.success,
                    )
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MethodCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _MethodCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight.withValues(alpha: 0.3) : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.background,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: isSelected ? AppColors.surface : AppColors.textPrimary, size: 24.sp),
            ),
            SizedBox(width: AppSpacing.md.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.headingSmall),
                  Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 24.sp),
          ],
        ),
      ),
    );
  }
}
