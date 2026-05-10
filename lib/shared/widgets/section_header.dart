// Purpose: Bold section title used above every content group.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 1

import 'package:flutter/material.dart';
import '../../core/config/app_theme.dart';

/// SectionHeader — e.g. "Services", "Recent Bookings", "Select Date"
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.headingSmall);
  }
}
