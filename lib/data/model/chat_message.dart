import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';

@freezed
class ChatMessage with _$ChatMessage {
  final String message;
  final bool isHuman;

  const ChatMessage({
    required this.message,
    required this.isHuman,
  });
}
