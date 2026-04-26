import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/app_constants.dart';
import '../../shared/widgets/custom_filled_button.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PaymentSuccessScreen — Animated success check, booking summary, TRACK button
// ─────────────────────────────────────────────────────────────────────────────
class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen>
    with SingleTickerProviderStateMixin {
  static const bool enableAnimations = true;

  late AnimationController _checkController;
  late Animation<double> _checkScale;

  @override
  void initState() {
    super.initState();
    _checkController = AnimationController(
      vsync: this,
      duration: AppConstants.successIconDuration,
    );
    _checkScale = CurvedAnimation(
      parent: _checkController,
      curve: Curves.elasticOut,
    );
    if (enableAnimations) {
      Future.delayed(const Duration(milliseconds: 200),
          () => _checkController.forward());
    } else {
      _checkController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Booking Confirmed', style: AppTextStyles.headingSmall),
        // Added a back button for safety, though typically success screens lead forward
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.close_rounded),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── Animated success icon ─────────────────────────────────
                ScaleTransition(
                  scale: _checkScale,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      size: 64,
                      color: AppColors.primary,
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),
                Text(
                  AppConstants.successTitle,
                  style: AppTextStyles.headingLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  AppConstants.successSubtitle,
                  style: AppTextStyles.bodyMedium,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.xl),

                // ── Booking summary card ──────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    boxShadow: AppShadows.card,
                  ),
                  child: const Column(
                    children: [
                      _DetailRow('Provider', 'Anita S.'),
                      Divider(color: AppColors.divider),
                      _DetailRow('Service', 'Daily Cook'),
                      Divider(color: AppColors.divider),
                      _DetailRow('Date', 'Tomorrow, 8:00 AM'),
                      Divider(color: AppColors.divider),
                      _DetailRow('Total Paid', 'PKR 1,320', highlight: true),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                CustomFilledButton(
                  label: AppConstants.successTrackButton,
                  onTap: () => context.go('/booking-status'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;
  const _DetailRow(this.label, this.value, {this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMedium),
          Text(
            value,
            style: highlight
                ? AppTextStyles.price
                : AppTextStyles.bodyLarge
                    .copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
