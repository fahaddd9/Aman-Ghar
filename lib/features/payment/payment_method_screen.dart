// Purpose: Select payment method.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 7

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../shared/widgets/custom_filled_button.dart';
import '../../shared/widgets/section_header.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedMethod = 'card_1';
  bool _isLoading = false;

  void _handlePayment() async {
    setState(() => _isLoading = true);
    await Future.delayed(AppDurations.slow); // Process payment
    if (!mounted) return;
    context.pushReplacement('/payment-success');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.paymentTitle),
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
              const SectionHeader(AppStrings.savedCards),
              SizedBox(height: AppSpacing.md.h),

              // Saved Card 1
              _PaymentOptionTile(
                id: 'card_1',
                title: '•••• •••• •••• 4242',
                subtitle: 'Expires 12/26',
                icon: Icons.credit_card_rounded,
                isSelected: _selectedMethod == 'card_1',
                onTap: () => setState(() => _selectedMethod = 'card_1'),
              ),
              SizedBox(height: AppSpacing.sm.h),

              // Saved Card 2
              _PaymentOptionTile(
                id: 'card_2',
                title: '•••• •••• •••• 5555',
                subtitle: 'Expires 08/25',
                icon: Icons.credit_card_rounded,
                isSelected: _selectedMethod == 'card_2',
                onTap: () => setState(() => _selectedMethod = 'card_2'),
              ),
              SizedBox(height: AppSpacing.xl.h),

              // Add New Card
              const SectionHeader(AppStrings.addNewCard),
              SizedBox(height: AppSpacing.md.h),
              
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: AppStrings.cardNumberHint,
                  prefixIcon: Icon(Icons.credit_card_rounded),
                ),
              ),
              SizedBox(height: AppSpacing.md.h),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        hintText: AppStrings.expiryHint,
                        prefixIcon: Icon(Icons.calendar_today_rounded),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.md.w),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: AppStrings.cvvHint,
                        prefixIcon: Icon(Icons.lock_rounded),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.xl.h),

              // Other Methods
              const SectionHeader(AppStrings.otherOptions),
              SizedBox(height: AppSpacing.md.h),
              
              _PaymentOptionTile(
                id: 'cash',
                title: 'Cash on Arrival',
                subtitle: 'Pay directly to provider',
                icon: Icons.money_rounded,
                isSelected: _selectedMethod == 'cash',
                onTap: () => setState(() => _selectedMethod = 'cash'),
              ),
              
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(AppSpacing.md.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: AppShadows.sheet,
        ),
        child: SafeArea(
          child: CustomFilledButton(
            label: AppStrings.proceedToPay,
            isLoading: _isLoading,
            onTap: _handlePayment,
          ),
        ),
      ),
    );
  }
}

class _PaymentOptionTile extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentOptionTile({
    required this.id,
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
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: EdgeInsets.all(AppSpacing.md.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.textHint, size: 28.sp),
            SizedBox(width: AppSpacing.md.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                  Text(subtitle, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.divider,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
