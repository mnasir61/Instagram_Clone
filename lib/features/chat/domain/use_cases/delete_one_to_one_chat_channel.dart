

import 'package:instagram_clone/features/chat/domain/entities/my_chat_entity.dart';
import 'package:instagram_clone/features/chat/domain/repositories/chat_repository.dart';

class DeleteOneToOneChatChannelUseCase {
  final ChatRepository repository;

  DeleteOneToOneChatChannelUseCase({required this.repository});

  Future<void> call(String channelId,MyChatEntity myChatEntity) {
    return repository.deleteOneToOneChatChannel(channelId,myChatEntity);
  }
}
