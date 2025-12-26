import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mysivi/data/models/chat_history_item.dart';
import '../../data/models/message_model.dart';
import '../../data/repositories/chat_repository.dart';
import 'package:uuid/uuid.dart';

import 'chat_event.dart';
import 'chat_state.dart';

// BLoC
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository repository;
  Box<Message>? _userMessageBox; // Nullable until opened
  String? _currentUserName;

  ChatBloc(this.repository) : super(const ChatState()) {
    on<ChatStarted>(_onChatStarted);
    on<SendMessage>(_onSendMessage);
  }

  // 1. OPEN THE SPECIFIC BOX FOR THIS USER
  Future<void> _onChatStarted(
    ChatStarted event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    _currentUserName = event.userName;

    // Unique box name: "chat_Alice", "chat_Bob", etc.
    final boxName = 'chat_${event.userName}';

    // Open the box (if not already open)
    if (!Hive.isBoxOpen(boxName)) {
      _userMessageBox = await Hive.openBox<Message>(boxName);
    } else {
      _userMessageBox = Hive.box<Message>(boxName);
    }

    // Load existing messages
    final history = _userMessageBox!.values.toList();
    emit(state.copyWith(messages: history, isLoading: false));
  }

  // 2. SEND MESSAGE TO THE SPECIFIC BOX
  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    // Safety check: Ensure the specific chat box is open
    if (_userMessageBox == null) return;

    // --- STEP 1: HANDLE USER MESSAGE (Sender) ---

    final userMsg = Message(
      id: const Uuid().v4(),
      text: event.text,
      type: MessageType.sender,
      timestamp: DateTime.now(),
    );

    // 1. Save to THIS user's specific chat box
    await _userMessageBox!.add(userMsg);

    // 2. Update the GLOBAL History Box (For the History Tab)
    // We open it on the fly to ensure we write the latest data
    final historyBox = await Hive.openBox<ChatHistoryItem>('history_box');

    final userHistoryItem = ChatHistoryItem(
      userName: _currentUserName!, // e.g., "Alice"
      lastMessage: userMsg.text,
      timestamp: userMsg.timestamp,
      unreadCount: 0,
    );

    // Save using userName as Key (Overwrites old entry to keep it fresh)
    await historyBox.put(_currentUserName!, userHistoryItem);

    // 3. Update UI immediately
    emit(
      state.copyWith(messages: [...state.messages, userMsg], isTyping: true),
    );

    // --- STEP 2: HANDLE API REPLY (Receiver) ---

    try {
      // 4. Fetch Reply
      final replyText = await repository.fetchRandomMessage();

      final replyMsg = Message(
        id: const Uuid().v4(),
        text: replyText,
        type: MessageType.receiver,
        timestamp: DateTime.now(),
      );

      // UX Delay (feels more natural)
      await Future.delayed(const Duration(seconds: 1));

      // 5. Save Reply to THIS user's specific chat box
      await _userMessageBox!.add(replyMsg);

      // 6. Update History Box AGAIN (So the list shows the received message)
      final replyHistoryItem = ChatHistoryItem(
        userName: _currentUserName!,
        lastMessage: replyMsg.text, // Show the reply in the list
        timestamp: replyMsg.timestamp,
        unreadCount: 0,
      );
      await historyBox.put(_currentUserName!, replyHistoryItem);

      // 7. Update UI with reply
      emit(
        state.copyWith(
          messages: [...state.messages, replyMsg],
          isTyping: false,
        ),
      );
    } catch (e) {
      // Handle Error (Stop typing indicator)
      emit(state.copyWith(isTyping: false));
    }
  }
}
