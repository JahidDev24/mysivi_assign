import 'package:hive/hive.dart';

part 'message_model.g.dart'; // Run build_runner after this!

@HiveType(typeId: 1) // Unique ID (ChatHistoryItem was 0)
enum MessageType {
  @HiveField(0)
  sender,
  @HiveField(1)
  receiver,
}

@HiveType(typeId: 2) // Unique ID
class Message extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final MessageType type;
  @HiveField(3)
  final DateTime timestamp;

  Message({
    required this.id,
    required this.text,
    required this.type,
    required this.timestamp,
  });
}
