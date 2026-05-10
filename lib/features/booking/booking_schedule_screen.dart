// Purpose: Booking flow — Date/Time selection and price breakdown.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 6: Booking Flow

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/config/app_theme.dart';
import '../../core/data/dummy_data.dart';
import '../../shared/widgets/custom_filled_button.dart';
import '../../shared/widgets/section_header.dart';

class BookingScheduleScreen extends StatefulWidget {
  final String providerId;
  const BookingScheduleScreen({super.key, required this.providerId});

  @override
  State<BookingScheduleScreen> createState() => _BookingScheduleScreenState();
}

class _BookingScheduleScreenState extends State<BookingScheduleScreen> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String? _selectedTime;
  bool _isRecurring = false;

  void _generateDates() {} // Dates are generated directly in build for UI

  @override
  Widget build(BuildContext context) {
    final provider = DummyData.providers.firstWhere(
      (p) => p.id == widget.providerId,
      orElse: () => DummyData.providers.first,
    );

    // Generate next 14 days
    final List<DateTime> dates = List.generate(
        14, (i) => DateTime.now().add(Duration(days: i + 1)));

    // Calculate prices
    final int basePrice = provider.pricePerDay;
    final int platformFee = 250;
    final int total = basePrice + platformFee;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.bookingTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Select Date ────────────────────────────────────────────────
            const SectionHeader(AppStrings.selectDate),
            SizedBox(height: AppSpacing.md.h),
            SizedBox(
              height: 80.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                separatorBuilder: (_, __) => SizedBox(width: AppSpacing.sm.w),
                itemBuilder: (context, index) {
                  final date = dates[index];
                  final isSelected = _selectedDate.day == date.day &&
                      _selectedDate.month == date.month;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedDate = date),
                    child: AnimatedContainer(
                      duration: AppDurations.fast,
                      width: 64.w,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.divider,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEE').format(date).toUpperCase(),
                            style: AppTextStyles.label.copyWith(
                              color: isSelected
                                  ? Colors.white70
                                  : AppColors.textHint,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            date.day.toString(),
                            style: AppTextStyles.headingMedium.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: AppSpacing.xl.h),

            // ── Select Time ────────────────────────────────────────────────
            const SectionHeader(AppStrings.selectTime),
            SizedBox(height: AppSpacing.md.h),
            Wrap(
              spacing: AppSpacing.sm.w,
              runSpacing: AppSpacing.sm.h,
              children: AppStrings.timeSlots.map((time) {
                final isSelected = _selectedTime == time;
                return ChoiceChip(
                  label: Text(time),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedTime = time);
                  },
                  selectedColor: AppColors.primary,
                  backgroundColor: AppColors.surface,
                  labelStyle: AppTextStyles.bodyMedium.copyWith(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                  side: BorderSide(
                    color: isSelected ? AppColors.primary : AppColors.divider,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: AppSpacing.xl.h),

            // ── Service Details & Address ──────────────────────────────────
            const SectionHeader(AppStrings.serviceDetails),
            SizedBox(height: AppSpacing.md.h),
            Container(
              padding: EdgeInsets.all(AppSpacing.md.w),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.serviceAddress, style: AppTextStyles.label),
                      Text(AppStrings.edit, style: AppTextStyles.label.copyWith(color: AppColors.primary)),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, size: 20.sp, color: AppColors.primary),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          AppStrings.defaultAddress,
                          style: AppTextStyles.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: AppSpacing.xl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.recurringBooking, style: AppTextStyles.bodyLarge),
                      Switch(
                        value: _isRecurring,
                        onChanged: (val) => setState(() => _isRecurring = val),
                        activeColor: AppColors.primary,
                      ),
                    ],
                  ),
                  if (_isRecurring) ...[
                    SizedBox(height: 8.h),
                    Text(
                      'Provider will be booked for the same time every day.',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: AppSpacing.xl.h),

            // ── Price Breakdown ────────────────────────────────────────────
            const SectionHeader(AppStrings.priceBreakdown),
            SizedBox(height: AppSpacing.md.h),
            Container(
              padding: EdgeInsets.all(AppSpacing.md.w),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: [
                  _PriceRow(label: provider.serviceType, value: AppStrings.formatPriceRaw(basePrice)),
                  SizedBox(height: 8.h),
                  _PriceRow(label: 'Platform Fee', value: AppStrings.formatPriceRaw(platformFee)),
                  if (_isRecurring) ...[
                    SizedBox(height: 8.h),
                    const _PriceRow(label: 'Recurring Discount', value: '-PKR 0', isDiscount: true),
                  ],
                  const Divider(height: AppSpacing.xl),
                  _PriceRow(label: 'Total', value: AppStrings.formatPriceRaw(total), isTotal: true),
                ],
              ),
            ),
            
            SizedBox(height: 100.h), // Bottom padding
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(AppSpacing.md.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: AppShadows.sheet,
        ),
        child: SafeArea(
          child: CustomFilledButton(
            label: AppStrings.confirmBooking,
            onTap: _selectedTime != null
                ? () => context.push('/payment')
                : null, // Disabled state if no time selected
          ),
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  final bool isDiscount;

  const _PriceRow({
    required this.label,
    required this.value,
    this.isTotal = false,
    this.isDiscount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal ? AppTextStyles.headingSmall : AppTextStyles.bodyMedium,
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyles.price
              : AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDiscount ? AppColors.success : AppColors.textPrimary,
                ),
        ),
      ],
    );
  }
}
