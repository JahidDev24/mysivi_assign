enum MessageType { sender, receiver }

class Message {
  final String id;
  final String text;
  final MessageType type;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.text,
    required this.type,
    required this.timestamp,
  });
}
