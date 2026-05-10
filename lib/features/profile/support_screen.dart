// Purpose: Support and FAQ screen.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 8

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../shared/widgets/section_header.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.supportTitle),
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
              // Contact Cards
              const SectionHeader(AppStrings.contactUs),
              SizedBox(height: AppSpacing.md.h),
              Row(
                children: [
                  Expanded(
                    child: _ContactCard(
                      icon: Icons.email_rounded,
                      title: AppStrings.emailSupport,
                      subtitle: 'support@amanghar.pk',
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: AppSpacing.md.w),
                  Expanded(
                    child: _ContactCard(
                      icon: Icons.phone_rounded,
                      title: AppStrings.callSupport,
                      subtitle: '+92 300 0000000',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: AppSpacing.xl.h),

              // FAQs
              const SectionHeader(AppStrings.faqTitle),
              SizedBox(height: AppSpacing.md.h),
              
              const _FaqTile(
                question: 'How do I cancel a booking?',
                answer: 'You can cancel a booking from the My Bookings screen up to 2 hours before the scheduled time without any penalty.',
              ),
              SizedBox(height: AppSpacing.sm.h),
              const _FaqTile(
                question: 'How does payment work?',
                answer: 'You can pay securely via credit card, JazzCash, EasyPaisa, or choose to pay cash directly to the provider upon completion of the service.',
              ),
              SizedBox(height: AppSpacing.sm.h),
              const _FaqTile(
                question: 'Are the service providers verified?',
                answer: 'Yes, all our service providers undergo a strict background check including NADRA verification and past reference checks.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.card,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 28.sp),
            ),
            SizedBox(height: AppSpacing.sm.h),
            Text(title, style: AppTextStyles.headingSmall, textAlign: TextAlign.center),
            SizedBox(height: 2.h),
            Text(subtitle, style: AppTextStyles.caption, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqTile({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.divider),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: AppColors.primary,
          collapsedIconColor: AppColors.textHint,
          title: Text(question, style: AppTextStyles.headingSmall),
          childrenPadding: EdgeInsets.fromLTRB(AppSpacing.md.w, 0, AppSpacing.md.w, AppSpacing.md.h),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(answer, style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }
}
