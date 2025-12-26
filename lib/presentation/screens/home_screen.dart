import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mysivi/logic/user_bloc/user_event.dart';
import 'package:mysivi/presentation/widgets/home_sliver_appbar.dart';

// Imports
import '../../logic/history_bloc/history_bloc.dart';
import '../../logic/user_bloc/user_bloc.dart';

import '../../logic/user_bloc/user_state.dart';
import '../widgets/add_user_dialog.dart';
import '../widgets/user_tile.dart';
import '../widgets/history_tile.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                // 1. WRAP APP BAR IN ABSORBER
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ),
                  sliver: const HomeSliverAppBar(),
                ),
              ],
          body: const TabBarView(
            children: [
              _UserListTab(), // Private widget defined below
              _ChatHistoryTab(), // Private widget defined below
            ],
          ),
        ),
      ),
    );
  }
}

// --- TAB 1: USERS LIST ---
class _UserListTab extends StatelessWidget {
  const _UserListTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // ... (Keep your existing dialog logic here) ...
          final newName = await AddUserDialog.show(context);
          if (newName != null && context.mounted) {
            context.read<UserBloc>().add(AddUser(newName));
          }
        },
        child: const Icon(Icons.add),
      ),
      // 2. USE BUILDER TO GET CONTEXT
      body: Builder(
        builder: (BuildContext context) {
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state.users.isEmpty) {
                // Handle empty state (optional)
                return const Center(child: Text("No users found"));
              }

              return CustomScrollView(
                key: const PageStorageKey('user_list'),
                slivers: [
                  // 3. THE INJECTOR (Creates the safe space)
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    ),
                  ),

                  // 4. THE LIST (Converted to Sliver)
                  SliverPadding(
                    padding: const EdgeInsets.all(2),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final user = state.users[index];

                        // Add bottom padding manually since we aren't using 'separated'
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: UserTile(
                            name: user,
                            index: index,
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChatScreen(userName: user),
                                  ),
                                ),
                          ),
                        );
                      }, childCount: state.users.length),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// --- TAB 2: HISTORY ---
class _ChatHistoryTab extends StatelessWidget {
  const _ChatHistoryTab();

  @override
  Widget build(BuildContext context) {
    // 1. WE MUST USE A BUILDER TO GET THE NESTED SCROLL VIEW CONTEXT
    return Builder(
      builder: (BuildContext context) {
        return BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state.items.isEmpty) {
              return const Center(
                child: Text(
                  "No chat history yet",
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }

            return CustomScrollView(
              key: const PageStorageKey('history_list'),
              slivers: [
                // 2. THIS IS THE FIX: IT PUSHES THE LIST DOWN
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ),
                ),

                // 3. THE LIST
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = state.items[index];

                      // 4. WRAP IN INKWELL/GESTURE DETECTOR FOR TAPPING
                      return GestureDetector(
                        onTap: () {
                          // Navigate to Chat Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => ChatScreen(userName: item.userName),
                            ),
                          );
                        },
                        child: HistoryTile(
                          userName: item.userName,
                          lastMessage: item.lastMessage,
                          time: DateFormat.jm().format(item.timestamp),
                          unreadCount: item.unreadCount,
                          index: index,
                        ),
                      );
                    }, childCount: state.items.length),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
