import 'package:mental_health_care/domain/repository/talk_doc_repository.dart';

import '../../core/result/result.dart';

class InitializeChatBotUseCase {
  final TalkDocRepository _repository;
  final String initialSystemPrompt;

  const InitializeChatBotUseCase({
    required TalkDocRepository repository,
    required this.initialSystemPrompt,
  }) : _repository = repository;

  Future<Result<bool>> execute() async {
    try {
      await _repository.setSystemPrompt(initialSystemPrompt);
      return Result.success(true); // 성공
    } catch (e) {
      return Result.error('챗봇 초기화 실패: $e'); // 실패 시 에러 메시지 전달
    }
  }
}
