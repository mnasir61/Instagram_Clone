import 'package:instagram_clone/features/chat/domain/entities/group_entity.dart';
import 'package:instagram_clone/features/chat/domain/repositories/chat_repository.dart';

class GetCreateGroupChatUseCase {
  final ChatRepository repository;

  GetCreateGroupChatUseCase({required this.repository});

  Future<void> call(GroupEntity groupEntity) {
    return repository.getCreateGroupChat(groupEntity);
  }
}
