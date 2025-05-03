import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_health_care/core/ui/color_style.dart';
import 'package:mental_health_care/domain/repository/talk_doc_repository.dart';

import 'message/ai_message.dart';
import 'message/human_message.dart';
import 'provider/talk_doc_providers.dart';

class TalkDocScreen extends ConsumerStatefulWidget {
  final String initialSystemPrompt;
  final TalkDocRepository talkDocRepository;

  const TalkDocScreen(this.talkDocRepository,
      {super.key, required this.initialSystemPrompt});

  @override
  ConsumerState<TalkDocScreen> createState() => _TalkDocScreenState();
}

class _TalkDocScreenState extends ConsumerState<TalkDocScreen> {
  final _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final notifier = ref.read(talkDocScreenProvider.notifier);
      if (notifier.state.chatList.isEmpty) {
        notifier.initializeChatBot(widget.initialSystemPrompt);
      }
      notifier.scrollController = _scrollController;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(talkDocScreenProvider);
    final notifier = ref.read(talkDocScreenProvider.notifier);
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
                    final message = state.chatList[index];
                    return message.isHuman
                        ? HumanMessage(message: message.message)
                        : AiMessage(message: message.message);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 24),
                  itemCount: state.chatList.length,
                ),
              ),
              SizedBox(
                height: 20,
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
                      onSubmitted: (text) {
                        notifier.handleNewChat(text);
                        _chatController.clear();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      notifier.handleNewChat(_chatController.text);
                      _chatController.clear();
                    },
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
