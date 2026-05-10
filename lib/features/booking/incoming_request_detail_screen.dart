import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/data/dummy_data.dart';
import '../../shared/widgets/custom_filled_button.dart';
import '../../shared/widgets/custom_outlined_button.dart';

class IncomingRequestDetailScreen extends StatelessWidget {
  final String requestId;
  
  const IncomingRequestDetailScreen({super.key, required this.requestId});

  @override
  Widget build(BuildContext context) {
    // Find booking from dummy data
    final booking = DummyData.bookings.firstWhere(
      (b) => b.id == requestId,
      orElse: () => DummyData.bookings.first, // fallback
    );
    
    // Hardcode dummy hirer details for demo
    const hirerName = 'Ayesha Malik';
    const hirerLocation = AppStrings.dummyUserLocation;
    const price = 1800; // Hardcoded or dynamic depending on service

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Request Details'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.md.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Hirer Info ────────────────────────────────────────────────
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: AppColors.primaryLight,
                    backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=12'),
                  ),
                  SizedBox(width: AppSpacing.md.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(hirerName, style: AppTextStyles.headingMedium),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded, size: 14.sp, color: AppColors.textHint),
                            SizedBox(width: 4.w),
                            Text(hirerLocation, style: AppTextStyles.bodySmall),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.push('/chat/${booking.providerId}'), // demo chat
                    icon: Icon(Icons.chat_bubble_outline_rounded, color: AppColors.primary, size: 24.sp),
                  )
                ],
              ),
              
              SizedBox(height: AppSpacing.xl.h),
              
              // ── Service Details ──────────────────────────────────────────
              Text('Service Details', style: AppTextStyles.headingMedium),
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
                    _buildDetailRow('Service Type', booking.serviceType),
                    _buildDetailRow('Date', booking.date),
                    _buildDetailRow('Time', booking.time),
                    _buildDetailRow('Estimated Price', AppStrings.formatPriceRaw(price)),
                    _buildDetailRow('Status', booking.status.name.toUpperCase(), isStatus: true),
                  ],
                ),
              ),
              
              SizedBox(height: AppSpacing.xxl.h),
              
              // ── Action Buttons ──────────────────────────────────────────
              if (booking.status.name == 'booked' || booking.status.name == 'pending')
                Row(
                  children: [
                    Expanded(
                      child: CustomOutlinedButton(
                        label: 'REJECT',
                        textColor: AppColors.error,
                        borderColor: AppColors.error,
                        onTap: () {
                           context.pop();
                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request Rejected')));
                        },
                      ),
                    ),
                    SizedBox(width: AppSpacing.md.w),
                    Expanded(
                      child: CustomFilledButton(
                        label: 'ACCEPT',
                        onTap: () {
                           context.pop();
                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request Accepted')));
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.sm.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
          if (isStatus)
             Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(AppRadius.badge),
                ),
                child: Text(
                  value,
                  style: AppTextStyles.label.copyWith(color: AppColors.primary),
                ),
             )
          else
            Text(value, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
