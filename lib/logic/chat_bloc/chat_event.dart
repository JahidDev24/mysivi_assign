// Events
import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class SendMessage extends ChatEvent {
  final String text;
  const SendMessage(this.text);

  @override
  // TODO: implement props
  List<Object?> get props => [text];
}
