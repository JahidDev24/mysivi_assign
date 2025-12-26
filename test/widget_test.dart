// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mysivi/data/models/chat_history_item.dart';
import 'package:mysivi/data/models/message_model.dart';
import 'package:mysivi/main.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    // 1. Setup a Temporary Directory for Hive (So it doesn't mess with real app data)
    tempDir = await Directory.systemTemp.createTemp();

    // 2. Initialize Hive for Testing
    Hive.init(tempDir.path);

    // 3. Register Adapters (Must match your main.dart)
    if (!Hive.isAdapterRegistered(0))
      Hive.registerAdapter(ChatHistoryItemAdapter());
    if (!Hive.isAdapterRegistered(1))
      Hive.registerAdapter(MessageTypeAdapter());
    if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(MessageAdapter());
  });

  setUp(() async {
    // 4. Open Boxes before the app starts (UserBloc & HistoryBloc need these)
    if (!Hive.isBoxOpen('users_box')) await Hive.openBox<String>('users_box');
    if (!Hive.isBoxOpen('history_box')) {
      await Hive.openBox<ChatHistoryItem>('history_box');
    }
  });

  tearDownAll(() async {
    // 5. Cleanup after tests
    await Hive.close();
    await tempDir.delete(recursive: true);
  });

  testWidgets('App smoke test - Verifies Home Screen loads', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for animations and async data loading
    await tester.pumpAndSettle();

    // --- CHECKS ---

    // 1. Check if the "Add User" FAB exists (The (+) button)
    expect(find.byIcon(Icons.add), findsOneWidget);

    // 2. Check if the Tab Bar exists (Users / History)
    // Note: Finding Text widgets depends on your exact string, let's assume "Users" is visible
    expect(find.text('Users'), findsOneWidget);
  });
}
