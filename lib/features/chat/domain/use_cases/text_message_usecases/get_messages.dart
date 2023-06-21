import 'package:instagram_clone/features/chat/domain/entities/text_message_entity.dart';
import 'package:instagram_clone/features/chat/domain/repositories/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase({required this.repository});

  Stream<List<TextMessageEntity>> call(String channelId) {
    return repository.getMessages(channelId);
  }
}
