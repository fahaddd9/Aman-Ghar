import 'package:flutter/material.dart';
import '../../core/config/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SectionHeader — Bold section title used above every content group
// e.g. "Services", "Recent Bookings", "Select Date", "Price Breakdown"
// ─────────────────────────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.headingSmall,
    );
  }
}
