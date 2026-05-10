// Purpose: Forgot password screen for resetting passwords.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 3

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/providers/auth_provider.dart';
import '../../shared/widgets/custom_filled_button.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    if (!_formKey.currentState!.validate()) return;
    
    try {
      await ref.read(authControllerProvider.notifier).resetPassword(
            _emailController.text.trim(),
          );
      
      if (!mounted) return;
      setState(() {
        _isSent = true;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/login');
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
          child: _isSent ? _buildSuccessView() : _buildFormView(),
        ),
      ),
    );
  }

  Widget _buildFormView() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.lg.h),
          
          Text(AppStrings.forgotPasswordTitle, style: AppTextStyles.headingLarge),
          SizedBox(height: AppSpacing.xs.h),
          Text(AppStrings.forgotPasswordSubtitle, style: AppTextStyles.bodyMedium),

          SizedBox(height: AppSpacing.xl.h),

          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: AppTextStyles.bodyLarge,
            decoration: const InputDecoration(
              hintText: AppStrings.emailHint,
              prefixIcon: Icon(Icons.email_rounded),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Required';
              return null;
            },
          ),
          
          SizedBox(height: AppSpacing.xl.h),

          CustomFilledButton(
            label: AppStrings.sendResetLink,
            isLoading: ref.watch(authControllerProvider).isLoading,
            onTap: _handleReset,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: AppSpacing.xxl.h),
        
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.mark_email_read_rounded, size: 40.sp, color: AppColors.primary),
        ),
        
        SizedBox(height: AppSpacing.xl.h),
        Text(AppStrings.resetSentTitle, style: AppTextStyles.headingLarge),
        SizedBox(height: AppSpacing.sm.h),
        Text(
          AppStrings.resetSentSubtitle,
          style: AppTextStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: AppSpacing.xxl.h),
        CustomFilledButton(
          label: AppStrings.backToLogin,
          onTap: () => context.pop(),
        ),
      ],
    );
  }
}
