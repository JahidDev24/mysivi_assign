// Events
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class AddUser extends UserEvent {
  final String name;
  const AddUser(this.name);
}

class LoadUsers extends UserEvent {} // New Event
