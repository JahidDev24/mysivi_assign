// State
import 'package:equatable/equatable.dart';
import 'package:mysivi/data/models/message_model.dart';

class ChatState extends Equatable {
  final List<Message> messages;
  final bool isTyping; // For loading indicator
  const ChatState({this.messages = const [], this.isTyping = false});
  @override
  List<Object> get props => [messages, isTyping];
}
