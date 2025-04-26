import 'package:flutter/material.dart';
import 'package:mental_health_care/domain/repository/talk_doc_repository.dart'; // Import TalkDocRepository

import 'ai_message.dart';
import 'human_message.dart';

class TalkDocScreen extends StatefulWidget {
  final TalkDocRepository talkDocRepository;
  final String initialSystemPrompt;

  const TalkDocScreen(
      {super.key,
      required this.talkDocRepository,
      required this.initialSystemPrompt});

  @override
  State<TalkDocScreen> createState() => _TalkDocScreenState();
}

class _TalkDocScreenState extends State<TalkDocScreen> {
  final _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> _chatList = [];
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    _initializeChatBot();
  }

  Future<void> _initializeChatBot() async {
    try {
      await widget.talkDocRepository
          .setSystemPrompt(widget.initialSystemPrompt);
      // 필요하다면 초기 메시지를 추가할 수 있습니다.
      setState(() {
        _chatList.add(ChatMessage(text: "안녕하세요! 무엇을 도와드릴까요?", isUser: false));
      });
    } catch (e) {
      // 시스템 프롬프트 설정 실패 시 오류 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('챗봇 초기화에 실패했습니다: $e')),
      );
    }
  }

  void _handleNewChat(String newMessage) async {
    if (newMessage.trim().isNotEmpty) {
      setState(() {
        _chatList.add(ChatMessage(text: newMessage, isUser: true));
        _chatController.clear();
        _isGenerating = true;
      });

      try {
        await for (final response
            in widget.talkDocRepository.sendMessage(newMessage)) {
          setState(() {
            _chatList.add(ChatMessage(text: response, isUser: false));
            _isGenerating = false;
          });
        }
      } catch (e) {
        setState(() {
          _chatList.add(
              ChatMessage(text: '응답을 받는 동안 오류가 발생했습니다: $e', isUser: false));
          _isGenerating = false;
        });
      } finally {
        // 메시지 전송 후 스크롤 아래로 이동
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xFF656565),
            width: 1,
          ),
        ),
        backgroundColor: const Color(0xff8A2BE2),
        title: const Text(
          'Gemini 챗봇',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 22 / 17,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  final message = _chatList[index];
                  return message.isUser
                      ? HumanMessage(message: message.text)
                      : AiMessage(message: message.text);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 24),
                itemCount: _chatList.length,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      height: 24 / 14,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      fillColor: const Color(0xFFF7F7FC),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      hintText: '채팅을 시작해보세요.',
                    ),
                    onSubmitted: _handleNewChat,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _handleNewChat(_chatController.text),
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}
