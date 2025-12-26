import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../data/models/chat_history_item.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final Box<ChatHistoryItem> historyBox;

  HistoryBloc()
    : historyBox = Hive.box<ChatHistoryItem>('history_box'),
      super(HistoryState([])) {
    // Initial Load
    on<LoadHistory>((event, emit) {
      final items = historyBox.values.toList();
      // Sort by newest first
      items.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      emit(HistoryState(items));
    });

    // Save/Update History
    on<UpdateHistory>((event, emit) async {
      final newItem = ChatHistoryItem(
        userName: event.userName,
        lastMessage: event.lastMessage,
        timestamp: DateTime.now(),
        unreadCount: 0, // Logic for unread count can be added here
      );

      // Save to Hive (using userName as key to update existing entries)
      await historyBox.put(event.userName, newItem);

      add(LoadHistory()); // Reload the list
    });

    add(LoadHistory()); // Load immediately on creation
  }
}
