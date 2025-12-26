import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../data/models/chat_history_item.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final Box<ChatHistoryItem> _historyBox = Hive.box<ChatHistoryItem>(
    'history_box',
  );

  HistoryBloc() : super(HistoryState([])) {
    on<LoadHistory>((event, emit) {
      final items = _historyBox.values.toList();
      // Sort: Newest first
      items.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      emit(HistoryState(items));
    });

    // Load initially
    add(LoadHistory());

    // IMPORTANT: Listen to Hive changes automatically!
    _historyBox.watch().listen((event) {
      add(LoadHistory()); // Reload whenever the box changes
    });
  }
}
