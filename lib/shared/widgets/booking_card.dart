import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/config/app_theme.dart';
import '../../core/models/booking_model.dart';
import 'custom_outlined_button.dart';

// ─────────────────────────────────────────────────────────────────────────────
// BookingCard — Compact booking summary row shown on Home and My Bookings
// ─────────────────────────────────────────────────────────────────────────────
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
    final imageUrl =
        _avatarUrls[booking.providerId] ?? 'https://i.pravatar.cc/100';
    final isCompleted = booking.status == BookingStatus.completed;
    final statusColor = _statusColor(booking.status);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          // ── Provider avatar ───────────────────────────────────────────
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primaryLight.withValues(alpha: 0.4),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const Icon(
                  Icons.person_rounded,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

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
                const SizedBox(height: 2),
                Text(
                  booking.serviceType, 
                  style: AppTextStyles.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${booking.date} • ${booking.time}',
                  style:
                      AppTextStyles.bodySmall.copyWith(color: AppColors.textHint),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // ── Status badge + action button ──────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.badge),
                ),
                child: Text(
                  booking.status.label,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: 100,
                height: 32,
                child: isCompleted
                    ? CustomOutlinedButton(
                        label: 'RATE NOW',
                        height: 32,
                        onTap: onRateNow,
                      )
                    : CustomOutlinedButton(
                        label: 'BOOK AGAIN',
                        height: 32,
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
