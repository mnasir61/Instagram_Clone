



import 'package:instagram_clone/features/chat/domain/repositories/chat_repository.dart';

class DeleteSingleMessageUseCase {
  final ChatRepository repository;

  DeleteSingleMessageUseCase({required this.repository});

  Future<void> call(String messageId) {
    return repository.deleteSingleMessage(messageId);
  }
}
