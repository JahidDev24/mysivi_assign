import 'package:flutter/material.dart';
import '../../core/app_theme.dart'; // Make sure to import your theme

class HistoryTile extends StatelessWidget {
  final String userName;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final int index;

  const HistoryTile({
    super.key,
    required this.userName,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.blueGrey[50],
        child: Text(
          userName[0],
          style: const TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        userName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
          if (unreadCount > 0) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
