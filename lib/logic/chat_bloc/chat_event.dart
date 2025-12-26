// Events
import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class ChatStarted extends ChatEvent {
  final String userName;
  const ChatStarted(this.userName);
  @override
  List<Object> get props => [userName];
}

class SendMessage extends ChatEvent {
  final String text;
  const SendMessage(this.text);
  @override
  List<Object> get props => [text];
}
