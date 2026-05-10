// Purpose: In-app messaging screen.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 8: Inbox / Chat

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/data/dummy_data.dart';
import '../../core/models/message_model.dart';

class ChatScreen extends StatefulWidget {
  final String providerId;
  const ChatScreen({super.key, required this.providerId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    // Load dummy messages
    _messages = List.from(DummyData.chatMessages);
    // Start at bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: AppDurations.fast,
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          time: 'Just now',
          isFromMe: true,
        ),
      );
    });
    
    _messageController.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    // Find provider details
    final provider = DummyData.providers.firstWhere(
      (p) => p.id == widget.providerId,
      orElse: () => DummyData.providers.first,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16.r,
              backgroundImage: const NetworkImage('https://i.pravatar.cc/100?img=47'),
            ),
            SizedBox(width: AppSpacing.sm.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(provider.name, style: AppTextStyles.headingSmall),
                Text(
                  AppStrings.online,
                  style: AppTextStyles.caption.copyWith(color: AppColors.success),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Message List ─────────────────────────────────────────
            Expanded(
              child: _messages.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chat_bubble_outline_rounded,
                              size: 64.sp, color: AppColors.textHint.withValues(alpha: 0.5)),
                          SizedBox(height: AppSpacing.md.h),
                          Text(
                            AppStrings.noMessagesHint,
                            style: AppTextStyles.bodyMedium,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.all(AppSpacing.md.w),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        return _ChatBubble(message: msg);
                      },
                    ),
            ),

            // ── Input Area ───────────────────────────────────────────
            Container(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w, vertical: AppSpacing.sm.h),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: AppShadows.sheet,
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add_circle_outline_rounded,
                          color: AppColors.textHint, size: 28.sp),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        style: AppTextStyles.bodyLarge,
                        decoration: InputDecoration(
                          hintText: AppStrings.chatInputHint,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.md.w, vertical: 12.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadius.avatar),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadius.avatar),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadius.avatar),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: AppColors.background,
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm.w),
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.send_rounded, color: Colors.white, size: 20.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final bool isMe = message.isFromMe;

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.md.h),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 12.r,
              backgroundImage: const NetworkImage('https://i.pravatar.cc/100?img=47'),
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isMe ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.card),
                  topRight: Radius.circular(AppRadius.card),
                  bottomLeft: Radius.circular(isMe ? AppRadius.card : 4),
                  bottomRight: Radius.circular(isMe ? 4 : AppRadius.card),
                ),
                border: isMe ? null : Border.all(color: AppColors.divider),
              ),
              child: Text(
                message.text,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: isMe ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
