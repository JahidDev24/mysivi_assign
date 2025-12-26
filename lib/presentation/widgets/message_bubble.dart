import 'package:flutter/material.dart';
import 'package:mysivi/presentation/widgets/interactive_message_text.dart';
import '../../core/app_theme.dart'; // Import your theme

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  final String avatarChar;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isSender,
    required this.avatarChar,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Define the Avatar Widget
    final avatar = CircleAvatar(
      radius: 16,
      backgroundColor: isSender
          ? AppTheme.primaryColor.withOpacity(0.8)
          : Colors.grey[300],
      child: Text(
        avatarChar.toUpperCase(),
        style: TextStyle(
          color: isSender ? Colors.white : Colors.black87,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    // 2. Define the Bubble Widget
    final bubble = Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7, // Max 70% width
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isSender ? AppTheme.primaryColor : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: isSender
              ? const Radius.circular(20)
              : Radius.zero, // Squared corner for receiver
          bottomRight: isSender
              ? Radius.zero
              : const Radius.circular(20), // Squared corner for sender
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InteractiveMessageText(
        text: text,
        style: TextStyle(
          color: isSender ? Colors.white : Colors.black87,
          fontSize: 15,
          height: 1.4, // Better readability
        ),
      ),
    );

    // 3. Arrange them based on isSender
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        mainAxisAlignment: isSender
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment:
            CrossAxisAlignment.end, // Aligns avatar to bottom of bubble
        children: [
          if (!isSender) ...[avatar, const SizedBox(width: 8), bubble],
          if (isSender) ...[bubble, const SizedBox(width: 8), avatar],
        ],
      ),
    );
  }
}
