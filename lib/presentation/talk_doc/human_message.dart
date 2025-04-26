import 'package:flutter/material.dart';

import 'chat_message.dart';

class HumanMessage extends StatelessWidget {
  const HumanMessage({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChatMessage(
          isHuman: true,
          message: message,
        ),
        const SizedBox(width: 16),
        Icon(Icons.person),
      ],
    );
  }
}
