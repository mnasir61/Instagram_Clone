



import 'package:instagram_clone/features/chat/domain/entities/text_message_entity.dart';
import 'package:instagram_clone/features/chat/domain/repositories/chat_repository.dart';

class SendTextMessageUseCase {
  final ChatRepository repository;

  SendTextMessageUseCase({required this.repository});

  Future<void> call(TextMessageEntity textMessageEntity,String channelId) {
    return repository.sendTextMessage(textMessageEntity,channelId);
  }
}
