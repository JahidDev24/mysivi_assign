part of 'history_bloc.dart';

class HistoryState extends Equatable {
  // State
  final List<ChatHistoryItem> items;
  const HistoryState(this.items);

  @override
  // TODO: implement props
  List<Object?> get props => [items];
}
