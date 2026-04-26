import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/app_constants.dart';
import '../../core/data/dummy_data.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/custom_filled_button.dart';

// ─────────────────────────────────────────────────────────────────────────────
// BookingScheduleScreen — Date selector, time chips, service details,
// price breakdown, address, recurring toggle, CONFIRM BOOKING button
// ─────────────────────────────────────────────────────────────────────────────
class BookingScheduleScreen extends StatefulWidget {
  final String providerId;
  const BookingScheduleScreen({super.key, required this.providerId});

  @override
  State<BookingScheduleScreen> createState() => _BookingScheduleScreenState();
}

class _BookingScheduleScreenState extends State<BookingScheduleScreen> {

  int _selectedDateIndex = 0;
  String _selectedTime = '8:00 AM';
  bool _isRecurring = false;

  @override
  Widget build(BuildContext context) {
    final provider = DummyData.providerById(widget.providerId);
    final now = DateTime.now();

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
        title: Text(AppConstants.bookingTitle,
            style: AppTextStyles.headingSmall),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Date selector ──────────────────────────────────────────
                const SectionHeader(AppConstants.bookingDateSection),
                const SizedBox(height: AppSpacing.sm),
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: AppSpacing.sm),
                    itemBuilder: (_, i) {
                      final date = now.add(Duration(days: i + 1));
                      final isSelected = _selectedDateIndex == i;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedDateIndex = i),
                        child: AnimatedContainer(
                          duration: AppConstants.chipAnimationDuration,
                          width: 60,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.surface,
                            borderRadius: BorderRadius.circular(AppRadius.chip),
                            boxShadow: isSelected ? null : AppShadows.card,
                            border: isSelected
                                ? null
                                : Border.all(color: AppColors.divider),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('EEE').format(date).toUpperCase(),
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('d').format(date),
                                style: AppTextStyles.headingSmall.copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.textPrimary,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        
                // ── Time slots ─────────────────────────────────────────────
                const SizedBox(height: AppSpacing.lg),
                const SectionHeader(AppConstants.bookingTimeSection),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: AppConstants.timeSlots.map((t) {
                    final isSelected = _selectedTime == t;
                    return ChoiceChip(
                      label: Text(t),
                      selected: isSelected,
                      onSelected: (_) => setState(() => _selectedTime = t),
                      backgroundColor: AppColors.surface,
                      selectedColor: AppColors.primary,
                      labelStyle: AppTextStyles.bodyMedium.copyWith(
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                      side: BorderSide(
                        color:
                            isSelected ? AppColors.primary : AppColors.divider,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                      ),
                      showCheckmark: false,
                    );
                  }).toList(),
                ),
        
                // ── Service details card ───────────────────────────────────
                const SizedBox(height: AppSpacing.lg),
                const SectionHeader(AppConstants.bookingDetailsSection),
                const SizedBox(height: AppSpacing.sm),
                _buildInfoCard(children: [
                  _DetailRow('Service', provider.serviceType),
                  const Divider(color: AppColors.divider),
                  _DetailRow('Provider', provider.name),
                  const Divider(color: AppColors.divider),
                  const _DetailRow('Duration', '8 hours'),
                ]),
        
                // ── Price breakdown card ────────────────────────────────────
                const SizedBox(height: AppSpacing.lg),
                const SectionHeader(AppConstants.bookingPriceSection),
                const SizedBox(height: AppSpacing.sm),
                _buildInfoCard(children: [
                  _PriceRow(
                      'Service Fee', provider.formattedPrice.replaceAll('/day', '')),
                  const Divider(color: AppColors.divider),
                  const _PriceRow('Platform Fee', 'PKR 120'),
                  const Divider(color: AppColors.divider),
                  _PriceRow(
                    'Total',
                    'PKR ${_calcTotal(provider.pricePerDay)}',
                    isBold: true,
                  ),
                ]),
        
                // ── Service address ─────────────────────────────────────────
                const SizedBox(height: AppSpacing.lg),
                const SectionHeader(AppConstants.bookingAddressSection),
                const SizedBox(height: AppSpacing.sm),
                _buildInfoCard(children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded,
                          color: AppColors.primary, size: 20),
                      const SizedBox(width: AppSpacing.sm),
                      const Expanded(
                        child: Text(
                          AppConstants.bookingAddress,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Edit',
                            style: AppTextStyles.bodyMedium
                                .copyWith(color: AppColors.primary)),
                      ),
                    ],
                  ),
                ]),
        
                // ── Recurring toggle ───────────────────────────────────────
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    boxShadow: AppShadows.card,
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Text('Recurring Booking', style: AppTextStyles.bodyLarge)),
                      Switch(
                        value: _isRecurring,
                        onChanged: (v) => setState(() => _isRecurring = v),
                        activeThumbColor: AppColors.primary,
                      ),
                    ],
                  ),
                ),
        
                // ── Confirm button ─────────────────────────────────────────
                const SizedBox(height: AppSpacing.xl),
                CustomFilledButton(
                  label: AppConstants.bookingConfirmButton,
                  onTap: () => context.push('/payment'),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _calcTotal(int pricePerDay) {
    final total = pricePerDay + 120;
    if (total < 1000) return '$total';
    return '${(total ~/ 1000)},${(total % 1000).toString().padLeft(3, '0')}';
  }

  Widget _buildInfoCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: AppTextStyles.bodyMedium)),
          Text(value,
              style: AppTextStyles.bodyLarge
                  .copyWith(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  const _PriceRow(this.label, this.value, {this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(label,
                style: isBold
                    ? AppTextStyles.bodyLarge
                        .copyWith(fontWeight: FontWeight.w700)
                    : AppTextStyles.bodyMedium),
          ),
          Text(value,
              style: isBold
                  ? AppTextStyles.price
                  : AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
