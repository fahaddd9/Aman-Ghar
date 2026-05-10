// Purpose: Bordered secondary button with press scale animation.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 1: Reusable widgets

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/config/app_theme.dart';

/// CustomOutlinedButton — Secondary bordered button with tap scale.
class CustomOutlinedButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final double? height;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;
  final bool isFullWidth;

  const CustomOutlinedButton({
    super.key,
    required this.label,
    this.onTap,
    this.height,
    this.icon,
    this.borderColor,
    this.textColor,
    this.isFullWidth = true,
  });

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton>
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

  void _onTapDown(TapDownDetails _) => _controller.forward();

  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
    widget.onTap?.call();
  }

  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    final Color effectiveBorderColor = widget.borderColor ?? AppColors.primary;
    final Color effectiveTextColor = widget.textColor ?? AppColors.primary;
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
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.button),
            border: Border.all(color: effectiveBorderColor, width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: effectiveTextColor, size: 16),
                SizedBox(width: 4.w),
              ],
              Flexible(
                child: Text(
                  widget.label,
                  style: AppTextStyles.headingSmall.copyWith(
                    color: effectiveTextColor,
                    fontSize: isSmall ? 11.sp : 14.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
