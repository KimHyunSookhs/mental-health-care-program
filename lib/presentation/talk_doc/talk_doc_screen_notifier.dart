import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_health_care/data/model/chat_message.dart';
import 'package:mental_health_care/domain/repository/talk_doc_repository.dart';
import 'package:mental_health_care/presentation/talk_doc/talk_doc_screen_state.dart';

class TalkDocScreenNotifier extends StateNotifier<TalkDocScreenState> {
  final TalkDocRepository repository;
  late ScrollController scrollController = ScrollController();

  TalkDocScreenNotifier({required this.repository})
      : super(TalkDocScreenState());

  Future<void> initializeChatBot(String initialSystemPrompt) async {
    try {
      await repository.setSystemPrompt(initialSystemPrompt);
      state = state.copyWith(chatList: [
        ...state.chatList,
        ChatMessage(message: '안녕하세요! 무엇을 도와드릴까요?', isHuman: false)
      ]);
    } catch (e) {
      throw Exception('챗봇 초기화에 실패했습니다: $e');
    }
  }

  Future<void> handleNewChat(String newMessage) async {
    if (newMessage.trim().isEmpty) return;
    state = state.copyWith(chatList: [
      ...state.chatList,
      ChatMessage(message: newMessage, isHuman: true)
    ], isGenerating: true);

    try {
      await for (final response in repository.sendMessage(newMessage)) {
        state = state.copyWith(
          chatList: [
            ...state.chatList,
            ChatMessage(message: response, isHuman: false)
          ],
          isGenerating: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        chatList: [
          ...state.chatList,
          ChatMessage(message: '오류가 발생했습니다: $e', isHuman: false)
        ],
        isGenerating: false,
      );
    }
    {
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
