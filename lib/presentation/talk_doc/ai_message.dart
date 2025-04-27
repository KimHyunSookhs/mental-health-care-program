import 'package:flutter/material.dart';

import 'chat_message.dart';

class AiMessage extends StatelessWidget {
  final String message;

  const AiMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/talkdoc.jpg',
          width: 25,
          height: 25,
        ),
        const SizedBox(width: 12),
        ChatMessage(
          isHuman: false,
          message: message,
        ),
      ],
    );
  }
}
