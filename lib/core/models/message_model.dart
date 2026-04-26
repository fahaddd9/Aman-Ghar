// ─────────────────────────────────────────────────────────────────────────────
// ChatMessage — AmanGhar chat message model
// Represents a single message in the provider-hirer chat interface
// ─────────────────────────────────────────────────────────────────────────────

class ChatMessage {
  final String id;
  final String text;
  final String time;
  final bool isFromMe; // true = sent by current user (Hirer), false = from provider

  const ChatMessage({
    required this.id,
    required this.text,
    required this.time,
    required this.isFromMe,
  });
}
