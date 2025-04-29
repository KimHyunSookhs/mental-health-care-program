import 'package:flutter/material.dart';

import '../../domain/repository/talk_doc_repository.dart';
import 'message/chat_message.dart';

class TalkDocScreenController {
  final TalkDocRepository talkDocRepository;
  final TextEditingController chatController;
  final ScrollController scrollController;
  final void Function(VoidCallback fn) setStateCallback;

  List<ChatMessage> chatList = [];
  bool isGenerating = false;

  TalkDocScreenController({
    required this.talkDocRepository,
    required this.chatController,
    required this.scrollController,
    required this.setStateCallback,
  });

  Future<void> initializeChatBot(String initialSystemPrompt) async {
    try {
      await talkDocRepository.setSystemPrompt(initialSystemPrompt);
      setStateCallback(() {
        chatList
            .add(ChatMessage(message: "안녕하세요! 무엇을 도와드릴까요?", isHuman: false));
      });
    } catch (e) {
      throw Exception('챗봇 초기화에 실패했습니다: $e');
    }
  }

  Future<void> handleNewChat(String newMessage) async {
    if (newMessage.trim().isNotEmpty) {
      setStateCallback(() {
        chatList.add(ChatMessage(message: newMessage, isHuman: true));
        chatController.clear();
        isGenerating = true;
      });

      try {
        await for (final response
            in talkDocRepository.sendMessage(newMessage)) {
          setStateCallback(() {
            chatList.add(ChatMessage(message: response, isHuman: false));
            isGenerating = false;
          });
        }
      } catch (e) {
        setStateCallback(() {
          chatList.add(
              ChatMessage(message: '응답을 받는 동안 오류가 발생했습니다: $e', isHuman: false));
          isGenerating = false;
        });
      } finally {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      }
    }
  }
}
