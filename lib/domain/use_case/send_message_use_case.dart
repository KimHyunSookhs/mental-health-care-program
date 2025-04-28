import '../repository/talk_doc_repository.dart';

class SendMessageUseCase {
  final TalkDocRepository repository;

  SendMessageUseCase({required this.repository});

  Stream<String> execute(String message) {
    return repository.sendMessage(message);
  }
}
