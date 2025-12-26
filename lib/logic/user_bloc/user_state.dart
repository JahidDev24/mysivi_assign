// State
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  final List<String> users;
  const UserState({this.users = const ["Mini help"]});

  @override
  List<Object> get props => [users];
}
