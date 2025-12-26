part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadHistory extends HistoryEvent {}

class UpdateHistory extends HistoryEvent {
  final String userName;
  final String lastMessage;

  UpdateHistory({required this.userName, required this.lastMessage});
}
