import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/data/dummy_data.dart';
import '../../shared/widgets/bottom_nav_bar.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate some dummy inbox data based on dummy providers
    final chats = DummyData.providers.take(3).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Inbox'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const AmanGharBottomNav(currentIndex: 2), // Index 2 is Inbox
      body: SafeArea(
        child: chats.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 64.sp,
                      color: AppColors.textHint.withValues(alpha: 0.5),
                    ),
                    SizedBox(height: AppSpacing.md.h),
                    Text(
                      'No messages yet',
                      style: AppTextStyles.headingMedium.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.all(AppSpacing.md.w),
                itemCount: chats.length,
                separatorBuilder: (_, __) => const Divider(color: AppColors.divider),
                itemBuilder: (_, i) {
                  final chat = chats[i];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 24.r,
                      backgroundColor: AppColors.primaryLight,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${i + 10}'),
                    ),
                    title: Text(chat.name, style: AppTextStyles.headingSmall),
                    subtitle: Text(
                      'Hello, are you available tomorrow?', // dummy message
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('10:42 AM', style: AppTextStyles.caption),
                        SizedBox(height: 4.h),
                        if (i == 0) // dummy unread indicator
                          Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Text('1', style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 10.sp)),
                          ),
                      ],
                    ),
                    onTap: () {
                      context.push('/chat/${chat.id}');
                    },
                  );
                },
              ),
      ),
    );
  }
}
