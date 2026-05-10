// Purpose: Profile screen (User account management) Role-aware.
// Doc: 05_complete_ui_and_provider_side.md

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/providers/role_provider.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import '../../shared/widgets/custom_outlined_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(roleProvider);
    final isProvider = role == UserRole.provider;
    final userProfileAsync = ref.watch(userProfileProvider);
    final profile = userProfileAsync.valueOrNull;
    
    final name = profile?['name'] as String? ?? (isProvider ? 'Anita Sharma' : AppStrings.dummyUserName);
    final email = profile?['email'] as String? ?? (isProvider ? 'anita@example.com' : AppStrings.dummyUserEmail);
    final initials = name.isNotEmpty ? name[0].toUpperCase() : 'U';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.profileTitle),
        centerTitle: true,
      ),
      bottomNavigationBar: const AmanGharBottomNav(currentIndex: 3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.md.w),
          child: Column(
            children: [
              // ── Header (Avatar + Info) ────────────────────────────────
              Center(
                child: Column(
                  children: [
                    Hero(
                      tag: 'profile-avatar',
                      child: Container(
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
                            initials,
                            style: AppTextStyles.displayLarge.copyWith(color: AppColors.primaryDark),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSpacing.md.h),
                    Text(
                      name,
                      style: AppTextStyles.headingLarge,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      email,
                      style: AppTextStyles.bodyMedium,
                    ),
                    SizedBox(height: AppSpacing.lg.h),
                    CustomOutlinedButton(
                      label: AppStrings.editProfile,
                      height: 40.h,
                      isFullWidth: false,
                      onTap: () => context.push('/edit-profile'),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.xxl.h),

              // ── Menu List ─────────────────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  boxShadow: AppShadows.card,
                ),
                child: Column(
                  children: [
                    if (isProvider) ...[
                      _MenuTile(
                        icon: Icons.account_balance_wallet_rounded,
                        title: 'My Earnings',
                        onTap: () => context.push('/earnings'), // TODO: Add route
                      ),
                      const Divider(height: 1),
                    ],
                    _MenuTile(
                      icon: isProvider ? Icons.receipt_long_rounded : Icons.history_rounded,
                      title: isProvider ? 'My Requests' : AppStrings.myBookings,
                      onTap: () => context.go('/my-bookings'),
                    ),
                    const Divider(height: 1),
                    if (!isProvider) ...[
                      _MenuTile(
                        icon: Icons.payment_rounded,
                        title: AppStrings.paymentHistory,
                        onTap: () => context.push('/payment-history'),
                      ),
                      const Divider(height: 1),
                    ],
                    _MenuTile(
                      icon: Icons.help_outline_rounded,
                      title: AppStrings.support,
                      onTap: () => context.push('/support'),
                    ),
                    const Divider(height: 1),
                    _MenuTile(
                      icon: Icons.info_outline_rounded,
                      title: AppStrings.aboutApp,
                      onTap: () => context.push('/about'),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.xl.h),

              // ── Logout Button ─────────────────────────────────────────
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
                leading: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.button),
                  ),
                  child: Icon(Icons.logout_rounded, color: AppColors.error, size: 24.sp),
                ),
                title: Text(
                  AppStrings.logout,
                  style: AppTextStyles.headingSmall.copyWith(color: AppColors.error),
                ),
                onTap: () => _showLogoutDialog(context, ref),
              ),
              
              SizedBox(height: AppSpacing.xxl.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.card)),
        title: Text(AppStrings.logoutConfirmTitle, style: AppTextStyles.headingMedium),
        content: Text(AppStrings.logoutConfirmMessage, style: AppTextStyles.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(AppStrings.cancel, style: AppTextStyles.bodyMedium),
          ),
          TextButton(
            onPressed: () async {
              context.pop();
              await ref.read(authControllerProvider.notifier).signOut();
              // Router redirect will handle navigating to auth pages,
              // but we can explicitly reset the role state:
              ref.read(roleProvider.notifier).state = UserRole.hirer;
            },
            child: Text(
              AppStrings.logout,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w, vertical: AppSpacing.xs.h),
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.primarySurface,
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
        child: Icon(icon, color: AppColors.primary, size: 24.sp),
      ),
      title: Text(title, style: AppTextStyles.headingSmall),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textHint, size: 16.sp),
      onTap: onTap,
    );
  }
}
