import 'package:hive/hive.dart';

part 'chat_history_item.g.dart'; // Name of the generated file

@HiveType(typeId: 0)
class ChatHistoryItem extends HiveObject {
  @HiveField(0)
  final String userName;

  @HiveField(1)
  final String lastMessage;

  @HiveField(2)
  final DateTime timestamp;

  @HiveField(3)
  final int unreadCount;

  ChatHistoryItem({
    required this.userName,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
  });
}
