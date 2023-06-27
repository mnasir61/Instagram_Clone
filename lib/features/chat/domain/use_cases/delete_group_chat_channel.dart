import 'package:instagram_clone/features/chat/domain/entities/group_entity.dart';
import 'package:instagram_clone/features/chat/domain/repositories/chat_repository.dart';

class DeleteGroupChatUseCase {
  final ChatRepository repository;

  DeleteGroupChatUseCase({required this.repository});

  Future<void> call(String channelId) {
    return repository.deleteGroupChatChannel(channelId);
  }
}
