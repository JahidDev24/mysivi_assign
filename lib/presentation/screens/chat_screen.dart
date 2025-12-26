import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysivi/logic/history_bloc/history_bloc.dart';
import '../../data/models/message_model.dart';
import '../../data/repositories/chat_repository.dart';
import '../../logic/chat_bloc/chat_bloc.dart';
import '../../logic/chat_bloc/chat_event.dart';
import '../../logic/chat_bloc/chat_state.dart';
import '../widgets/feature_tip_card.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  const ChatScreen({super.key, required this.userName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Local state to track visibility of the tip
  bool _showTip = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ChatBloc(ChatRepository())..add(ChatStarted(widget.userName)),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leadingWidth: 40,

          title: Row(
            children: [
              CircleAvatar(child: Text(widget.userName[0])),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.userName, style: const TextStyle(fontSize: 16)),
                  const Text(
                    "Online",
                    style: TextStyle(fontSize: 12, color: Colors.greenAccent),
                  ),
                ],
              ),
            ],
          ),

          actions: [
            IconButton(
              icon: const Icon(Icons.videocam_outlined),
              onPressed: () {},
            ),
            IconButton(icon: const Icon(Icons.call_outlined), onPressed: () {}),
          ],
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 2),
            child: Divider(color: Colors.black12, thickness: 0.4, height: 2),
          ),
        ),
        body: Column(
          children: [
            // 1. THE TIP CARD (Conditionally Rendered)
            BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                // Logic: Show tip only if there are messages AND user hasn't dismissed it
                if (state.messages.isNotEmpty && _showTip) {
                  return FeatureTipCard(
                    onDismiss: () {
                      setState(() {
                        _showTip = false; // Hide it when X is clicked
                      });
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            // 2. THE CHAT LIST
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  // 1. Show Loading Spinner while opening Hive Box
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // 2. Show Empty State
                  if (state.messages.isEmpty) {
                    return Center(
                      child: Text("Say hello to ${widget.userName}!"),
                    );
                  }
                  // 1. Reverse the list data so the Newest message is at Index 0
                  final reversedMessages = state.messages.reversed.toList();
                  // 3. Show List
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      // 3. Use the reversed list
                      final msg = reversedMessages[index];
                      final isMe = msg.type == MessageType.sender;

                      return MessageBubble(
                        text: msg.text,
                        isSender: isMe,
                        avatarChar: isMe ? "M" : widget.userName[0],
                        timestamp: msg.timestamp,
                      );
                    },
                  );
                },
              ),
            ),
            // Loading Indicator (Typing status)
            BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state.isTyping) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: Text(
                      "${widget.userName} is typing...",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            // Input Area
            _MessageInput(widget.userName),
          ],
        ),
      ),
    );
  }
}

class _MessageInput extends StatefulWidget {
  final username;
  const _MessageInput(this.username);
  @override
  State<_MessageInput> createState() => __MessageInputState();
}

class __MessageInputState extends State<_MessageInput> {
  final _controller = TextEditingController();

  void _send() {
    if (_controller.text.isNotEmpty) {
      context.read<ChatBloc>().add(SendMessage(_controller.text));
      // // 2. UPDATE HISTORY (Bonus Integration)
      // context.read<HistoryBloc>().add(
      //   UpdateHistory(userName: widget.username, lastMessage: _controller.text),
      // );

      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: _send,
          ),
        ],
      ),
    );
  }
}
