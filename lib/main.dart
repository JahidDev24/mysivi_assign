import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mysivi/data/models/chat_history_item.dart';
import 'package:mysivi/data/models/message_model.dart';
import 'package:mysivi/presentation/screens/rootapp.dart';

import 'core/app_theme.dart';
import 'logic/history_bloc/history_bloc.dart';
import 'logic/user_bloc/user_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 1. Init Hive
  await Hive.initFlutter();

  // 2. Register Adapter
  Hive.registerAdapter(ChatHistoryItemAdapter());
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(MessageTypeAdapter());

  // We need a specific box for messages
  await Hive.openBox<Message>('messages_box'); // Box to store all messages
  // 3. Open Boxes (One for Users, One for History)
  await Hive.openBox<String>('users_box');
  await Hive.openBox<ChatHistoryItem>('history_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (_) => HistoryBloc()),
      ],
      child: MaterialApp(
        title: 'Mini Chat',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const RootApp(),
      ),
    );
  }
}
