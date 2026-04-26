import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/app_constants.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/custom_filled_button.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PaymentMethodScreen — Saved cards, add new card, other payment options
// ─────────────────────────────────────────────────────────────────────────────
class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  // 0=Visa, 1=Mastercard, 2=Cash, 3=Bank, -1=none
  int _selectedOption = 0;

  @override
  Widget build(BuildContext context) {
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
            Text(AppConstants.paymentTitle, style: AppTextStyles.headingSmall),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Saved cards ─────────────────────────────────────────────
                const SectionHeader(AppConstants.paymentSavedCards),
                const SizedBox(height: AppSpacing.sm),
                _buildInfoCard(children: [
                  _PaymentOption(
                    icon: Icons.credit_card_rounded,
                    label: 'Visa •••• 4242',
                    isSelected: _selectedOption == 0,
                    onTap: () => setState(() => _selectedOption = 0),
                  ),
                  const Divider(color: AppColors.divider, height: 1),
                  _PaymentOption(
                    icon: Icons.credit_card_rounded,
                    label: 'Mastercard •••• 8821',
                    isSelected: _selectedOption == 1,
                    onTap: () => setState(() => _selectedOption = 1),
                  ),
                ]),
        
                // ── Add new card ─────────────────────────────────────────────
                const SizedBox(height: AppSpacing.lg),
                const SectionHeader(AppConstants.paymentAddCard),
                const SizedBox(height: AppSpacing.sm),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration(
                      hint: 'Card number', icon: Icons.credit_card_rounded),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.datetime,
                        decoration: _inputDecoration(
                            hint: 'MM/YY',
                            icon: Icons.calendar_today_rounded),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration(
                            hint: 'CVV', icon: Icons.lock_outline_rounded),
                      ),
                    ),
                  ],
                ),
        
                // ── Other options ────────────────────────────────────────────
                const SizedBox(height: AppSpacing.lg),
                const SectionHeader(AppConstants.paymentOtherOptions),
                const SizedBox(height: AppSpacing.sm),
                _buildInfoCard(children: [
                  _PaymentOption(
                    icon: Icons.money_rounded,
                    label: 'Cash on Service',
                    isSelected: _selectedOption == 2,
                    onTap: () => setState(() => _selectedOption = 2),
                  ),
                  const Divider(color: AppColors.divider, height: 1),
                  _PaymentOption(
                    icon: Icons.account_balance_rounded,
                    label: 'Bank Transfer (JazzCash / EasyPaisa)',
                    isSelected: _selectedOption == 3,
                    onTap: () => setState(() => _selectedOption = 3),
                  ),
                ]),
        
                // ── Proceed button ────────────────────────────────────────────
                const SizedBox(height: AppSpacing.xl),
                CustomFilledButton(
                  label: AppConstants.paymentProceedButton,
                  onTap: () => context.go('/payment-success'),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.card,
      ),
      child: Column(children: children),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label, 
                style: AppTextStyles.bodyLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            // Custom radio circle
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.textHint,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration _inputDecoration(
    {required String hint, required IconData icon}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
    prefixIcon: Icon(icon, color: AppColors.textHint, size: 20),
    filled: true,
    fillColor: AppColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.input),
      borderSide: const BorderSide(color: AppColors.divider),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.input),
      borderSide: const BorderSide(color: AppColors.divider),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.input),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  );
}
