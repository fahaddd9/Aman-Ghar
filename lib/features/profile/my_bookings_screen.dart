import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/app_constants.dart';
import '../../core/data/dummy_data.dart';
import '../../shared/widgets/booking_card.dart';
import '../../shared/widgets/bottom_nav_bar.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MyBookingsScreen — List of all past and active bookings
// ─────────────────────────────────────────────────────────────────────────────
class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bookings = DummyData.bookings;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          AppConstants.profileMyBookings,
          style: AppTextStyles.headingSmall,
        ),
        leading: context.canPop() ? IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ) : null,
      ),
      bottomNavigationBar: const AmanGharBottomNav(currentIndex: 1),
      body: SafeArea(
        child: bookings.isEmpty 
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today_rounded, size: 64, color: AppColors.textHint.withValues(alpha: 0.5)),
                  const SizedBox(height: 16),
                  Text(
                    'No bookings found',
                    style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: bookings.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.sm),
              itemBuilder: (_, i) {
                final booking = bookings[i];
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(milliseconds: 300 + i * 60),
                  curve: Curves.easeOut,
                  builder: (_, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 16 * (1 - value)),
                      child: child,
                    ),
                  ),
                  child: BookingCard(
                    booking: booking,
                    onBookAgain: () =>
                        context.push('/provider/${booking.providerId}'),
                    onRateNow: () {},
                  ),
                );
              },
            ),
      ),
    );
  }
}
