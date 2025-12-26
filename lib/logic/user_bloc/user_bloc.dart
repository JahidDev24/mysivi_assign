import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'user_event.dart';
import 'user_state.dart';

// BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  // Access the box we opened in main.dart
  final Box<String> _userBox = Hive.box<String>('users_box');
  UserBloc() : super(const UserState()) {
    // 1. Handle Loading Users
    on<LoadUsers>((event, emit) {
      // Get all values from the box
      final usersList = _userBox.values.toList();
      emit(UserState(users: usersList));
    });

    // 2. Handle Adding User
    on<AddUser>((event, emit) async {
      // Save to Hive
      // We use 'add' to let Hive generate the key, or we can just store the string
      await _userBox.add(event.name);

      // Reload the list from Hive to ensure state is in sync
      add(LoadUsers());
    });

    // 3. Trigger initial load immediately
    add(LoadUsers());
  }
}
