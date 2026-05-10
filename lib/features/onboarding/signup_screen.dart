// Purpose: Sign up screen (decoupled from Login).
// Doc: 04_ui_improvement_and_fix_phase.md — Step 3: Auth Flow Decoupling

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/providers/auth_provider.dart';
import '../../shared/widgets/custom_filled_button.dart';

class SignupScreen extends ConsumerStatefulWidget {
  final String role;
  const SignupScreen({super.key, required this.role});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;
    
    try {
      await ref.read(authControllerProvider.notifier).signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            name: _nameController.text.trim(),
            phone: _phoneController.text.trim(),
            role: widget.role,
          );
      // App router handles redirect on auth state change!
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/role-select');
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSpacing.lg.h),
                
                // ── Title ────────────────────────────────────────────────
                Text(AppStrings.signUpTitle, style: AppTextStyles.headingLarge),
                SizedBox(height: AppSpacing.xs.h),
                Text(AppStrings.signUpSubtitle, style: AppTextStyles.bodyMedium),

                SizedBox(height: AppSpacing.xl.h),

                // ── Form Fields ──────────────────────────────────────────
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  style: AppTextStyles.bodyLarge,
                  decoration: const InputDecoration(
                    hintText: AppStrings.fullNameHint,
                    prefixIcon: Icon(Icons.person_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Name is required';
                    if (value.trim().length < 3) return 'Name must be at least 3 characters';
                    return null;
                  },
                ),
                SizedBox(height: AppSpacing.md.h),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: AppTextStyles.bodyLarge,
                  decoration: const InputDecoration(
                    hintText: AppStrings.emailHint,
                    prefixIcon: Icon(Icons.email_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email is required';
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) return 'Enter a valid email address';
                    return null;
                  },
                ),
                SizedBox(height: AppSpacing.md.h),

                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: AppTextStyles.bodyLarge,
                  decoration: const InputDecoration(
                    hintText: AppStrings.phoneHint,
                    prefixIcon: Icon(Icons.phone_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Phone number is required';
                    final phoneRegex = RegExp(r'^\+?[0-9]{10,13}$');
                    if (!phoneRegex.hasMatch(value.replaceAll(' ', ''))) return 'Enter a valid phone number';
                    return null;
                  },
                ),
                SizedBox(height: AppSpacing.md.h),
                
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: AppTextStyles.bodyLarge,
                  decoration: InputDecoration(
                    hintText: AppStrings.createPasswordHint,
                    prefixIcon: const Icon(Icons.lock_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Password is required';
                    if (value.length < 8) return 'Minimum 8 characters';
                    if (!value.contains(RegExp(r'[A-Z]'))) return 'Must contain 1 uppercase letter';
                    if (!value.contains(RegExp(r'[0-9]'))) return 'Must contain 1 number';
                    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return 'Must contain 1 special character';
                    return null;
                  },
                ),
                
                SizedBox(height: AppSpacing.xl.h),

                // ── Signup Button ─────────────────────────────────────────
                CustomFilledButton(
                  label: AppStrings.createAccountButton,
                  isLoading: isLoading,
                  onTap: _handleSignup,
                ),

                SizedBox(height: AppSpacing.lg.h),

                // ── Login Link ─────────────────────────────────────────
                Center(
                  child: GestureDetector(
                    onTap: () => context.pushReplacement('/login', extra: widget.role),
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.bodyMedium,
                        children: [
                          const TextSpan(text: AppStrings.alreadyHaveAccount),
                          TextSpan(
                            text: AppStrings.loginLink,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppSpacing.xl.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
