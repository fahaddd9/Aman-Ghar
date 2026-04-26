import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/app_constants.dart';
import '../../core/data/dummy_data.dart';
import '../../shared/widgets/rating_row.dart';
import '../../shared/widgets/custom_filled_button.dart';
import '../../shared/widgets/custom_outlined_button.dart';

// ─────────────────────────────────────────────────────────────────────────────
// BookingStatusScreen — Progress stepper, provider card, map placeholder,
// MESSAGE and CALL action buttons
// ─────────────────────────────────────────────────────────────────────────────
class BookingStatusScreen extends StatelessWidget {
  const BookingStatusScreen({super.key});

  static const String _anitaAvatarUrl = 'https://i.pravatar.cc/100?img=47';

  @override
  Widget build(BuildContext context) {
    final booking = DummyData.activeBooking;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title:
            Text(AppConstants.statusTitle, style: AppTextStyles.headingSmall),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Progress stepper ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  _StepItem(
                      label: AppConstants.bookingSteps[0],
                      isDone: true,
                      isActive: false),
                  const _StepConnector(isDone: true),
                   _StepItem(
                      label: AppConstants.bookingSteps[1],
                      isDone: true,
                      isActive: false),
                  const _StepConnector(isDone: true),
                   _StepItem(
                      label: AppConstants.bookingSteps[2],
                      isDone: false,
                      isActive: true),
                  const _StepConnector(isDone: false),
                  _StepItem(
                      label: AppConstants.bookingSteps[3],
                      isDone: false,
                      isActive: false),
                ],
              ),
            ),

            // ── Provider info card ─────────────────────────────────────
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  boxShadow: AppShadows.card,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.primaryLight.withValues(alpha: 0.4),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: _anitaAvatarUrl,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => const Icon(
                              Icons.person_rounded,
                              color: AppColors.primary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(booking.providerName,
                              style: AppTextStyles.headingSmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          Text(booking.serviceType,
                              style: AppTextStyles.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 2),
                          const RatingRow(
                              rating: 4.8,
                              reviewCount: 142),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(AppRadius.badge),
                      ),
                      child: Text(
                        AppConstants.statusEta,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Map placeholder ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.card),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: const Color(0xFFE8EAF0),
                  child: Stack(
                    children: [
                      // Grid-line painting
                      CustomPaint(
                        painter: _GridPainter(),
                        size: const Size(double.infinity, 200),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_pin,
                              size: 44,
                              color: AppColors.primary,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: AppShadows.card,
                              ),
                              child: Text(
                                AppConstants.statusOnTheWay,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Action buttons ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      label: 'MESSAGE',
                      icon: Icons.chat_bubble_outline_rounded,
                      onTap: () => context.push('/chat/1'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: CustomFilledButton(
                      label: 'CALL',
                      icon: Icons.phone_rounded,
                      onTap: () async {
                        final uri =
                            Uri.parse('tel:${AppConstants.dummyUserPhone}');
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final String label;
  final bool isDone;
  final bool isActive;

  const _StepItem({
    required this.label,
    required this.isDone,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    Color circleColor;
    if (isDone) {
      circleColor = AppColors.primary;
    } else if (isActive) {
      circleColor = AppColors.secondary;
    } else {
      circleColor = AppColors.divider;
    }

    Color textColor = (isDone || isActive) ? AppColors.primary : AppColors.textHint;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: circleColor),
            child: Icon(
              isDone ? Icons.check_rounded : Icons.circle,
              size: isDone ? 14 : 8,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: textColor,
              fontSize: 10,
              fontWeight: (isDone || isActive) ? FontWeight.w600 : FontWeight.w400,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _StepConnector extends StatelessWidget {
  final bool isDone;
  const _StepConnector({required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 2,
      margin: const EdgeInsets.only(bottom: 18),
      color: isDone ? AppColors.primary : AppColors.divider,
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..strokeWidth = 1;

    const spacing = 30.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
