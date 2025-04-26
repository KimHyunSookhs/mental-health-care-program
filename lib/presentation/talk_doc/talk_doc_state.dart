import 'package:freezed_annotation/freezed_annotation.dart';

part 'talk_doc_state.freezed.dart';

@freezed
abstract class TalkDocState with _$TalkDocState {
  const factory TalkDocState({
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
  }) = _TalkDocState;
}
