import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/app_constants.dart';
import '../../core/data/dummy_data.dart';
import '../../core/models/message_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ChatScreen — Message bubbles with staggered FadeIn, text input + send button
// ─────────────────────────────────────────────────────────────────────────────
class ChatScreen extends StatefulWidget {
  final String providerId;
  const ChatScreen({super.key, required this.providerId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static const bool enableAnimations = true;
  static const String _anitaAvatarUrl = 'https://i.pravatar.cc/100?img=47';

  final TextEditingController _inputController = TextEditingController();
  final List<ChatMessage> _messages = List.from(DummyData.chatMessages);

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(
        id: 'm${_messages.length + 1}',
        text: text,
        time: _currentTime(),
        isFromMe: true,
      ));
      _inputController.clear();
    });
  }

  String _currentTime() {
    final now = DateTime.now();
    final h = now.hour > 12 ? now.hour - 12 : now.hour;
    final m = now.minute.toString().padLeft(2, '0');
    final ampm = now.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $ampm';
  }

  @override
  Widget build(BuildContext context) {
    final provider = DummyData.providerById(widget.providerId);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
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
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primaryLight.withValues(alpha: 0.4),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: _anitaAvatarUrl,
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) =>
                      const Icon(Icons.person_rounded, size: 18),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.name, 
                    style: AppTextStyles.headingSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.verified,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        AppConstants.chatOnline,
                        style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final uri =
                  Uri.parse('tel:${AppConstants.dummyUserPhone}');
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            },
            icon: const Icon(Icons.phone_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Message list ─────────────────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: _messages.length,
                itemBuilder: (_, i) {
                  final msg = _messages[i];
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: Duration(
                      milliseconds: enableAnimations
                          ? 300 + (i * 80).clamp(0, 400)
                          : 0,
                    ),
                    curve: Curves.easeOut,
                    builder: (_, value, child) => Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 16 * (1 - value)),
                        child: child,
                      ),
                    ),
                    child: _MessageBubble(
                      message: msg,
                      avatarUrl: _anitaAvatarUrl,
                    ),
                  );
                },
              ),
            ),
        
            // ── Input row ────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      style: AppTextStyles.bodyLarge,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: AppConstants.chatInputHint,
                        hintStyle: AppTextStyles.bodyMedium
                            .copyWith(color: AppColors.textHint),
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _SendButton(onTap: _sendMessage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final String avatarUrl;

  const _MessageBubble({required this.message, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    final isFromMe = message.isFromMe;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Align(
        alignment: isFromMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isFromMe) ...[
              CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.primaryLight.withValues(alpha: 0.4),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: avatarUrl,
                    width: 28,
                    height: 28,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) =>
                        const Icon(Icons.person_rounded, size: 14),
                  ),
                ),
              ),
              const SizedBox(width: 6),
            ],
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                margin: EdgeInsets.only(
                  left: isFromMe ? 60 : 0,
                  right: isFromMe ? 0 : 60,
                ),
                decoration: BoxDecoration(
                  color:
                      isFromMe ? AppColors.primary : AppColors.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: isFromMe
                        ? const Radius.circular(16)
                        : const Radius.circular(4),
                    bottomRight: isFromMe
                        ? const Radius.circular(4)
                        : const Radius.circular(16),
                  ),
                  boxShadow: AppShadows.card,
                ),
                child: Column(
                  crossAxisAlignment: isFromMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.text,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isFromMe
                            ? Colors.white
                            : AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      message.time,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 10,
                        color: isFromMe
                            ? Colors.white70
                            : AppColors.textHint,
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

class _SendButton extends StatefulWidget {
  final VoidCallback onTap;
  const _SendButton({required this.onTap});

  @override
  State<_SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 120));
    _scale = Tween<double>(begin: 1.0, end: 0.9).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: AppShadows.button,
          ),
          child: const Icon(
            Icons.send_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
