import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/message_model.dart';
import '../../data/repositories/chat_repository.dart';
import 'package:uuid/uuid.dart';

import 'chat_event.dart';
import 'chat_state.dart';

// BLoC
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository repository;

  ChatBloc(this.repository) : super(const ChatState()) {
    on<SendMessage>(_onSendMessage);
  }

  void _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    // 1. Add Sender Message immediately
    final userMsg = Message(
      id: const Uuid().v4(),
      text: event.text,
      type: MessageType.sender,
      timestamp: DateTime.now(),
    );

    emit(
      ChatState(
        messages: List.from(state.messages)..add(userMsg),
        isTyping: true,
      ),
    );

    // 2. Simulate network delay then fetch API
    await Future.delayed(const Duration(seconds: 1));
    final replyText = await repository.fetchRandomMessage();

    final replyMsg = Message(
      id: const Uuid().v4(),
      text: replyText,
      type: MessageType.receiver,
      timestamp: DateTime.now(),
    );

    emit(
      ChatState(
        messages: List.from(state.messages)..add(replyMsg),
        isTyping: false,
      ),
    );
  }
}
