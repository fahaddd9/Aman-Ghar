// Purpose: Edit user profile details.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 8

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../shared/widgets/custom_filled_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _handleSave() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    await Future.delayed(AppDurations.slow);
    if (!mounted) return;
    setState(() => _isLoading = false);
    
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.editProfileTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.lg.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surface, width: 4),
                        boxShadow: AppShadows.card,
                      ),
                      child: Center(
                        child: Text(
                          'AM',
                          style: AppTextStyles.displayLarge.copyWith(color: AppColors.primaryDark),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 20.sp),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.sm.h),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.changePhoto,
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
                  ),
                ),
                
                SizedBox(height: AppSpacing.xl.h),

                // Form Fields
                TextFormField(
                  initialValue: AppStrings.dummyUserName,
                  style: AppTextStyles.bodyLarge,
                  decoration: const InputDecoration(
                    labelText: AppStrings.nameLabel,
                    prefixIcon: Icon(Icons.person_rounded),
                  ),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: AppSpacing.md.h),
                
                TextFormField(
                  initialValue: AppStrings.dummyUserEmail,
                  keyboardType: TextInputType.emailAddress,
                  style: AppTextStyles.bodyLarge,
                  decoration: const InputDecoration(
                    labelText: AppStrings.emailHint,
                    prefixIcon: Icon(Icons.email_rounded),
                  ),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: AppSpacing.md.h),
                
                TextFormField(
                  initialValue: AppStrings.dummyUserPhone,
                  keyboardType: TextInputType.phone,
                  style: AppTextStyles.bodyLarge,
                  decoration: const InputDecoration(
                    labelText: AppStrings.phoneLabel,
                    prefixIcon: Icon(Icons.phone_rounded),
                  ),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: AppSpacing.md.h),
                
                TextFormField(
                  initialValue: AppStrings.dummyUserLocation,
                  style: AppTextStyles.bodyLarge,
                  decoration: const InputDecoration(
                    labelText: AppStrings.addressLabel,
                    prefixIcon: Icon(Icons.location_on_rounded),
                  ),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                
                SizedBox(height: AppSpacing.xxl.h),
                
                CustomFilledButton(
                  label: AppStrings.saveChanges,
                  isLoading: _isLoading,
                  onTap: _handleSave,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
