import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:mental_health_care/domain/repository/talk_doc_repository.dart';

class TalkDocRepositoryImpl implements TalkDocRepository {
  static final String apiKey = dotenv.env['GEMINI_API_KEY']!;
  static const String modelName = "gemini-2.0-flash";

  late GenerativeModel _model;
  ChatSession? _chatSession;

  TalkDocRepositoryImpl() {
    _model = GenerativeModel(
      model: modelName,
      apiKey: apiKey,
    );
  }
  
  @override
  Future<void> setSystemPrompt(String prompt) async {
    _chatSession = _model.startChat(history: [
      Content.model([TextPart(prompt)]), // 첫 번째 메시지로 시스템 프롬프트 전달
    ]);
  }

  @override
  Stream<String> sendMessage(String message) async* {
    try {
      final response = await _chatSession!.sendMessage(Content.text(message));
      final responseText = response.text ?? '응답을 생성할 수 없습니다.';
      yield responseText;
    } catch (e) {
      yield '메시지 전송 중 오류가 발생했습니다: $e';
      throw Exception('메시지 전송 중 오류가 발생했습니다: $e');
    }
  }
}
