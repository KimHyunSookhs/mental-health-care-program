import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mental_health_care/data/model/chat_message.dart';

part 'talk_doc_screen_state.freezed.dart';

@freezed
abstract class TalkDocScreenState with _$TalkDocScreenState {
  const factory TalkDocScreenState(
          {@Default(false) bool isGenerating,
          @Default(<ChatMessage>[]) List<ChatMessage> chatList}) =
      _TalkDocScreenState;
}
