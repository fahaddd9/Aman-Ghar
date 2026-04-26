import 'package:flutter/material.dart';
import '../../core/config/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CustomFilledButton — Primary green gradient button with press scale animation
// ─────────────────────────────────────────────────────────────────────────────
class CustomFilledButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final double height;
  final IconData? icon;
  final bool isFullWidth;

  const CustomFilledButton({
    super.key,
    required this.label,
    this.onTap,
    this.height = 52,
    this.icon,
    this.isFullWidth = true,
  });

  @override
  State<CustomFilledButton> createState() => _CustomFilledButtonState();
}

class _CustomFilledButtonState extends State<CustomFilledButton>
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
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppRadius.button),
            boxShadow: AppShadows.button,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: Colors.white, size: 16),
                const SizedBox(width: 4),
              ],
              Flexible(
                child: Text(
                  widget.label,
                  style: AppTextStyles.headingSmall.copyWith(
                    color: Colors.white,
                    fontSize: widget.height < 40 ? 11 : 14,
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
