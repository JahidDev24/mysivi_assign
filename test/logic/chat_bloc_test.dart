import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mysivi/data/models/chat_history_item.dart';
import 'package:mysivi/data/models/message_model.dart';
import 'package:mysivi/data/repositories/chat_repository.dart';
import 'package:mysivi/logic/chat_bloc/chat_bloc.dart';
import 'package:mysivi/logic/chat_bloc/chat_event.dart';
import 'package:mysivi/logic/chat_bloc/chat_state.dart';

// Import your app files

// 1. Create a Mock for the Repository
// We don't want to hit the real API in tests!
class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late MockChatRepository mockRepo;
  late ChatBloc chatBloc;
  late Directory tempDir;

  // 2. SETUP (Runs before tests start)
  setUp(() async {
    mockRepo = MockChatRepository();

    // A. Initialize Hive in a temp directory
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);

    // B. Register Adapters (Just like in main.dart)
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(MessageTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(MessageAdapter());
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ChatHistoryItemAdapter());
    }

    // C. Initialize the BLoC
    chatBloc = ChatBloc(mockRepo);
  });

  // 3. TEARDOWN (Runs after tests finish)
  tearDown(() async {
    await chatBloc.close();
    await Hive.close(); // Close boxes
    await tempDir.delete(recursive: true); // Delete temp files
  });

  group('ChatBloc Tests', () {
    const userName = 'Alice';
    const sentText = 'Hello World';
    const replyText = 'This is a mocked reply';

    // TEST 1: Check Initial State
    test('Initial state should be empty', () {
      expect(chatBloc.state.messages, []);
      expect(chatBloc.state.isTyping, false);
    });

    // TEST 2: Verify "ChatStarted" loads messages
    blocTest<ChatBloc, ChatState>(
      'emits state with isLoading=false when ChatStarted is added',
      build: () => chatBloc,
      act: (bloc) => bloc.add(const ChatStarted(userName)),
      expect:
          () => [
            // Expect loading to toggle (true -> false)
            isA<ChatState>().having((s) => s.isLoading, 'isLoading', true),
            isA<ChatState>().having((s) => s.isLoading, 'isLoading', false),
          ],
    );

    // TEST 3: Verify "SendMessage" flow (The big one!)
    blocTest<ChatBloc, ChatState>(
      'emits [UserMessage, ReplyMessage] when SendMessage is added',
      setUp: () {
        // Prepare the Mock: When fetchRandomMessage is called, return "This is a mocked reply"
        when(
          () => mockRepo.fetchRandomMessage(),
        ).thenAnswer((_) async => replyText);
      },
      build: () => chatBloc,
      act: (bloc) async {
        // We must start the chat first to open the box!
        bloc.add(const ChatStarted(userName));
        await Future.delayed(
          const Duration(milliseconds: 100),
        ); // Wait for box to open
        bloc.add(const SendMessage(sentText));
      },
      wait: const Duration(seconds: 2), // Wait for the artificial delay in BLoC
      expect:
          () => [
            // 1. Loading States from ChatStarted
            isA<ChatState>().having((s) => s.isLoading, 'isLoading', true),
            isA<ChatState>().having((s) => s.isLoading, 'isLoading', false),

            // 2. User Message Added (isTyping becomes TRUE)
            isA<ChatState>()
                .having((s) => s.messages.last.text, 'last message', sentText)
                .having((s) => s.isTyping, 'isTyping', true),

            // 3. API Reply Added (isTyping becomes FALSE)
            isA<ChatState>()
                .having((s) => s.messages.last.text, 'last message', replyText)
                .having((s) => s.isTyping, 'isTyping', false),
          ],
    );
  });
}
