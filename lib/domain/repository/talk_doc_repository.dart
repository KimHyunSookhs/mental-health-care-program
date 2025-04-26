abstract class TalkDocRepository {
  Future<void> setSystemPrompt(String prompt);

  Stream<String> sendMessage(String message);
}
