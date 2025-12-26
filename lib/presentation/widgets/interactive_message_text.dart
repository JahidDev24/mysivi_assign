import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class InteractiveMessageText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const InteractiveMessageText({
    super.key,
    required this.text,
    required this.style,
  });

  // Function to fetch meaning
  Future<void> _showDefinition(BuildContext context, String word) async {
    // Clean the word (remove punctuation)
    final cleanWord = word.replaceAll(RegExp(r'[^\w\s]'), '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow it to be tall
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        height: MediaQuery.of(context).size.height * 0.4,
        child: FutureBuilder(
          future: Dio().get(
            "https://api.dictionaryapi.dev/api/v2/entries/en/$cleanWord",
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Could not find definition for '$cleanWord'"),
              );
            }

            // Parsing the Dictionary API response
            final data = snapshot.data?.data as List;
            if (data.isEmpty) return const Text("No definition found.");

            final firstEntry = data[0];
            final meanings = firstEntry['meanings'] as List;
            final definition = meanings[0]['definitions'][0]['definition'];
            final partOfSpeech = meanings[0]['partOfSpeech'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cleanWord,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  partOfSpeech,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const Divider(height: 30),
                const Text(
                  "Definition:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(definition, style: const TextStyle(fontSize: 16)),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final words = text.split(' ');
    final spans = <TextSpan>[];

    for (var word in words) {
      spans.add(
        TextSpan(
          text: "$word ",
          style: style, // Inherit the bubble text style
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // Optional: Handle single tap if needed
            },
        ),
      );
    }

    // Since RichText doesn't support 'onLongPress' on spans easily,
    // we use a workaround: Use InkWell or GestureDetector on the whole block
    // OR simply use the tap to show the meaning (Better UX for mobile)

    // REVISION for UX: Tapping a specific word in a span is hard.
    // Better approach: Wrap words in GestureDetector logic using a custom builder
    // But for this assignment, let's use the TapGestureRecognizer we added above.

    return RichText(
      text: TextSpan(
        children: words.map((word) {
          return TextSpan(
            text: "$word ",
            style: style,
            recognizer:
                LongPressGestureRecognizer() // Detect Long Press
                  ..onLongPress = () => _showDefinition(context, word),
          );
        }).toList(),
      ),
    );
  }
}
