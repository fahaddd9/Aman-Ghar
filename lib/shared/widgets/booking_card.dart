// Purpose: Compact booking summary row shown on Home and My Bookings.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 4

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/config/app_theme.dart';
import '../../core/models/booking_model.dart';
import 'custom_outlined_button.dart';

/// BookingCard — Avatar | Provider details | Status badge + action button.
class BookingCard extends StatelessWidget {
  final Booking booking;
  final VoidCallback? onBookAgain;
  final VoidCallback? onRateNow;

  const BookingCard({
    super.key,
    required this.booking,
    this.onBookAgain,
    this.onRateNow,
  });

  static const Map<String, String> _avatarUrls = {
    '1': 'https://i.pravatar.cc/100?img=47',
    '2': 'https://i.pravatar.cc/100?img=45',
    '3': 'https://i.pravatar.cc/100?img=44',
  };

  Color _statusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.booked:
        return AppColors.accent;
      case BookingStatus.confirmed:
        return AppColors.secondary;
      case BookingStatus.onTheWay:
        return AppColors.secondary;
      case BookingStatus.arrived:
        return AppColors.primary;
      case BookingStatus.completed:
        return AppColors.verified;
      case BookingStatus.cancelled:
        return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        _avatarUrls[booking.providerId] ?? 'https://i.pravatar.cc/100';
    final bool isCompleted = booking.status == BookingStatus.completed;
    final Color statusColor = _statusColor(booking.status);

    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          // ── Provider avatar ───────────────────────────────────────────
          CircleAvatar(
            radius: 24.r,
            backgroundColor: AppColors.primaryLight.withValues(alpha: 0.4),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 48.w,
                height: 48.w,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const Icon(
                  Icons.person_rounded,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // ── Booking details ───────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.providerName,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  booking.serviceType,
                  style: AppTextStyles.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  '${booking.date} • ${booking.time}',
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textHint),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.sm.w),

          // ── Status badge + action button ──────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.badge),
                ),
                child: Text(
                  booking.status.label,
                  style: AppTextStyles.label.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              SizedBox(
                width: 100.w,
                height: 32.h,
                child: isCompleted
                    ? CustomOutlinedButton(
                        label: 'RATE NOW',
                        height: 32.h,
                        onTap: onRateNow,
                      )
                    : CustomOutlinedButton(
                        label: 'BOOK AGAIN',
                        height: 32.h,
                        onTap: onBookAgain,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
