import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/app_constants.dart';
import '../../core/providers/role_provider.dart';
import '../../shared/widgets/custom_outlined_button.dart';
import '../../shared/widgets/bottom_nav_bar.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ProfileScreen — Avatar, user info, menu list items, LOG OUT button
// ─────────────────────────────────────────────────────────────────────────────
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const String _userAvatarUrl = 'https://i.pravatar.cc/200?img=5';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(AppConstants.profileTitle, style: AppTextStyles.headingSmall),
        leading: context.canPop() ? IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ) : null,
      ),
      bottomNavigationBar: const AmanGharBottomNav(currentIndex: 2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.xl),
                color: AppColors.primary.withValues(alpha: 0.05),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: AppColors.primaryLight.withValues(alpha: 0.4),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: _userAvatarUrl,
                              width: 96,
                              height: 96,
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => const Icon(
                                  Icons.person_rounded,
                                  color: AppColors.primary,
                                  size: 48),
                            ),
                          ),
                        ),
                        const Positioned(
                          bottom: 0,
                          right: 0,
                          child: _EditAvatarButton(),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      AppConstants.dummyUserName, 
                      style: AppTextStyles.headingMedium,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      AppConstants.dummyUserEmail, 
                      style: AppTextStyles.bodyMedium,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              _ProfileMenuItem(
                icon: Icons.calendar_month_rounded, 
                label: AppConstants.profileMyBookings, 
                onTap: () => context.push('/my-bookings'),
              ),
              const Divider(color: AppColors.divider, indent: 56, height: 1),
              _ProfileMenuItem(icon: Icons.person_outline_rounded, label: AppConstants.profileEditProfile, onTap: () {}),
              const Divider(color: AppColors.divider, indent: 56, height: 1),
              _ProfileMenuItem(icon: Icons.payment_rounded, label: AppConstants.profilePaymentHistory, onTap: () {}),
              const Divider(color: AppColors.divider, indent: 56, height: 1),
              _ProfileMenuItem(icon: Icons.headset_mic_rounded, label: AppConstants.profileSupport, onTap: () {}),
              const Divider(color: AppColors.divider, indent: 56, height: 1),
              _ProfileMenuItem(icon: Icons.info_outline_rounded, label: AppConstants.profileAbout, onTap: () {}),
              const SizedBox(height: AppSpacing.xl),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: CustomOutlinedButton(
                  label: AppConstants.profileLogout,
                  borderColor: AppColors.error,
                  textColor: AppColors.error,
                  onTap: () {
                    ref.read(roleProvider.notifier).state = null;
                    context.go('/role-select');
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _EditAvatarButton extends StatelessWidget {
  const _EditAvatarButton();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32, height: 32,
      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
      child: const Icon(Icons.edit_rounded, size: 14, color: Colors.white),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ProfileMenuItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        label, 
        style: AppTextStyles.bodyLarge,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
    );
  }
}
