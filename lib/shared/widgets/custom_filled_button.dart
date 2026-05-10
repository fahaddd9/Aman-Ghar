// Purpose: Primary green gradient button with press scale animation.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 1: Reusable widgets

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/config/app_theme.dart';

/// CustomFilledButton — Primary CTA button with gradient and tap scale.
class CustomFilledButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final double? height;
  final IconData? icon;
  final bool isFullWidth;
  final bool isLoading;

  const CustomFilledButton({
    super.key,
    required this.label,
    this.onTap,
    this.height,
    this.icon,
    this.isFullWidth = true,
    this.isLoading = false,
  });

  @override
  State<CustomFilledButton> createState() => _CustomFilledButtonState();
}

class _CustomFilledButtonState extends State<CustomFilledButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.instant,
      reverseDuration: AppDurations.instant,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (!widget.isLoading) _controller.forward();
  }

  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
    if (!widget.isLoading) widget.onTap?.call();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final double effectiveHeight = widget.height ?? 52.h;
    final bool isSmall = effectiveHeight < 40.h;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.isFullWidth ? double.infinity : null,
          height: effectiveHeight,
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm.w),
          decoration: BoxDecoration(
            gradient: widget.isLoading
                ? null
                : const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            color: widget.isLoading ? AppColors.primaryLight : null,
            borderRadius: BorderRadius.circular(AppRadius.button),
            boxShadow: widget.isLoading ? null : AppShadows.button,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isLoading) ...[
                SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ] else ...[
                if (widget.icon != null) ...[
                  Icon(widget.icon, color: Colors.white, size: 16),
                  SizedBox(width: 4.w),
                ],
                Flexible(
                  child: Text(
                    widget.label,
                    style: AppTextStyles.headingSmall.copyWith(
                      color: Colors.white,
                      fontSize: isSmall ? 11.sp : 14.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
