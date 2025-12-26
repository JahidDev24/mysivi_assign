// State
import 'package:equatable/equatable.dart';
import 'package:mysivi/data/models/message_model.dart';

class ChatState extends Equatable {
  final List<Message> messages;
  final bool isTyping;
  final bool isLoading; // New: To show spinner while opening box

  const ChatState({
    this.messages = const [],
    this.isTyping = false,
    this.isLoading = true,
  });

  ChatState copyWith({
    List<Message>? messages,
    bool? isTyping,
    bool? isLoading,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [messages, isTyping, isLoading];
}
