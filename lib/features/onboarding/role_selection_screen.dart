// Purpose: User chooses Hirer or Provider role at onboarding.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 3: Role Selection Screen

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/providers/role_provider.dart';

class RoleSelectionScreen extends ConsumerStatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  ConsumerState<RoleSelectionScreen> createState() =>
      _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends ConsumerState<RoleSelectionScreen>
    with TickerProviderStateMixin {
  late final AnimationController _hirerController;
  late final AnimationController _providerController;
  late final Animation<double> _hirerFade;
  late final Animation<double> _providerFade;
  late final Animation<Offset> _hirerSlide;
  late final Animation<Offset> _providerSlide;

  @override
  void initState() {
    super.initState();
    _hirerController = AnimationController(
      vsync: this,
      duration: AppDurations.slow,
    );
    _providerController = AnimationController(
      vsync: this,
      duration: AppDurations.slow,
    );

    _hirerFade = CurvedAnimation(
      parent: _hirerController,
      curve: Curves.easeOut,
    );
    _providerFade = CurvedAnimation(
      parent: _providerController,
      curve: Curves.easeOut,
    );
    _hirerSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _hirerController, curve: Curves.easeOut));
    _providerSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _providerController, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 100),
        () => _hirerController.forward());
    Future.delayed(const Duration(milliseconds: 200),
        () => _providerController.forward());
  }

  @override
  void dispose() {
    _hirerController.dispose();
    _providerController.dispose();
    super.dispose();
  }

  void _selectRole(UserRole role) {
    ref.read(roleProvider.notifier).state = role;
    context.push('/login', extra: role.roleKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: AppSpacing.xl.h),

                      // ── Header ─────────────────────────────────────────
                      Icon(
                        Icons.home_rounded,
                        size: 44.sp,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: AppSpacing.md.h),
                      Text(
                        AppStrings.roleTitle,
                        style: AppTextStyles.headingLarge,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSpacing.sm.h),
                      Text(
                        AppStrings.roleSubtitle,
                        style: AppTextStyles.bodyMedium,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: AppSpacing.xxl.h),

                      // ── Hirer card ─────────────────────────────────────
                      FadeTransition(
                        opacity: _hirerFade,
                        child: SlideTransition(
                          position: _hirerSlide,
                          child: _RoleCard(
                            icon: Icons.home_rounded,
                            title: AppStrings.hirerRoleName,
                            description: AppStrings.hirerRoleDescription,
                            onTap: () => _selectRole(UserRole.hirer),
                          ),
                        ),
                      ),

                      SizedBox(height: AppSpacing.md.h),

                      // ── Provider card ──────────────────────────────────
                      FadeTransition(
                        opacity: _providerFade,
                        child: SlideTransition(
                          position: _providerSlide,
                          child: _RoleCard(
                            icon: Icons.work_rounded,
                            title: AppStrings.providerRoleName,
                            description: AppStrings.providerRoleDescription,
                            onTap: () => _selectRole(UserRole.provider),
                          ),
                        ),
                      ),

                      const Spacer(),
                      SizedBox(height: AppSpacing.lg.h),

                      // ── Footer ─────────────────────────────────────────
                      Text(
                        AppStrings.taglineShort,
                        style: AppTextStyles.caption,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSpacing.lg.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RoleCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  State<_RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<_RoleCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.instant,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSpacing.lg.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.primary, width: 1.5),
            boxShadow: AppShadows.card,
          ),
          child: Row(
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                ),
                child: Icon(
                  widget.icon,
                  size: 30.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: AppSpacing.md.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: AppTextStyles.headingSmall),
                    SizedBox(height: AppSpacing.xs.h),
                    Text(
                      widget.description,
                      style: AppTextStyles.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppSpacing.sm.w),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.sp,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
