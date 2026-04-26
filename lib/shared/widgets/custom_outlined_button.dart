import 'package:flutter/material.dart';
import '../../core/config/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CustomOutlinedButton — Bordered secondary button with press scale animation
// ─────────────────────────────────────────────────────────────────────────────
class CustomOutlinedButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final double height;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;
  final bool isFullWidth;

  const CustomOutlinedButton({
    super.key,
    required this.label,
    this.onTap,
    this.height = 52,
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
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  static const bool enableAnimations = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 120),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (enableAnimations) _controller.forward();
  }

  void _onTapUp(TapUpDetails _) {
    if (enableAnimations) _controller.reverse();
    widget.onTap?.call();
  }

  void _onTapCancel() {
    if (enableAnimations) _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = widget.borderColor ?? AppColors.primary;
    final effectiveTextColor = widget.textColor ?? AppColors.primary;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.isFullWidth ? double.infinity : null,
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
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
                const SizedBox(width: 4),
              ],
              Flexible(
                child: Text(
                  widget.label,
                  style: AppTextStyles.headingSmall
                      .copyWith(color: effectiveTextColor, fontSize: widget.height < 40 ? 11 : 14),
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
