import 'package:flutter/material.dart';
import 'package:mental_health_care/core/ui/color_style.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    required this.message,
    required this.isHuman,
  });

  final String message;
  final bool isHuman;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isHuman
              ? Color.fromRGBO(250, 250, 250, 1.0)
              : ColorStyle.moreDarkGrey,
          borderRadius: BorderRadius.only(
            topLeft: isHuman ? const Radius.circular(10) : Radius.zero,
            topRight: isHuman ? Radius.zero : Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            height: 18 / 13,
          ),
        ),
      ),
    );
  }
}
