import 'package:flutter/material.dart';
import 'package:mental_health_care/core/ui/color_style.dart';
import 'package:mental_health_care/domain/repository/talk_doc_repository.dart';
import 'package:mental_health_care/presentation/talk_doc/talk_doc_screen_controller.dart';

import 'message/ai_message.dart';
import 'message/human_message.dart';

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

  // List<ChatMessage> _chatList = [];
  // bool _isGenerating = false;
  late TalkDocScreenController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TalkDocScreenController(
      talkDocRepository: widget.talkDocRepository,
      chatController: _chatController,
      scrollController: _scrollController,
      setStateCallback: setState,
    );
    _controller.initializeChatBot(widget.initialSystemPrompt).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    });
  }

  // Future<void> _initializeChatBot() async {
  //   try {
  //     await widget.talkDocRepository
  //         .setSystemPrompt(widget.initialSystemPrompt);
  //     setState(() {
  //       _chatList
  //           .add(ChatMessage(message: "안녕하세요! 무엇을 도와드릴까요?", isHuman: false));
  //     });
  //   } catch (e) {
  //     // 시스템 프롬프트 설정 실패 시 오류 처리
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('챗봇 초기화에 실패했습니다: $e')),
  //     );
  //   }
  // }
  //
  // void _handleNewChat(String newMessage) async {
  //   if (newMessage.trim().isNotEmpty) {
  //     setState(() {
  //       _chatList.add(ChatMessage(message: newMessage, isHuman: true));
  //       _chatController.clear();
  //       _isGenerating = true;
  //     });
  //
  //     try {
  //       await for (final response
  //           in widget.talkDocRepository.sendMessage(newMessage)) {
  //         setState(() {
  //           _chatList.add(ChatMessage(message: response, isHuman: false));
  //           _isGenerating = false;
  //         });
  //       }
  //     } catch (e) {
  //       setState(() {
  //         _chatList.add(
  //             ChatMessage(message: '응답을 받는 동안 오류가 발생했습니다: $e', isHuman: false));
  //         _isGenerating = false;
  //       });
  //     } finally {
  //       // 메시지 전송 후 스크롤 아래로 이동
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         _scrollController.animateTo(
  //           _scrollController.position.maxScrollExtent,
  //           duration: const Duration(milliseconds: 300),
  //           curve: Curves.easeInOut,
  //         );
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/talkdoc.jpg'),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '마음지기',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 22 / 17,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  '24/7 상담 가능',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    height: 22 / 17,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color: ColorStyle.lightGrey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    final message = _controller.chatList[index];
                    return message.isHuman
                        ? HumanMessage(message: message.message)
                        : AiMessage(message: message.message);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 24),
                  itemCount: _controller.chatList.length,
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
                        hintText: '메세지를 입력하세요...',
                      ),
                      onSubmitted: _controller.handleNewChat,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () =>
                        _controller.handleNewChat(_chatController.text),
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
