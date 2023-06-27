

import 'package:instagram_clone/features/chat/domain/entities/engaged_user_entity.dart';
import 'package:instagram_clone/features/chat/domain/repositories/chat_repository.dart';

class CreateOneToOneChatUseCase {
  final ChatRepository repository;

  CreateOneToOneChatUseCase({required this.repository});

  Future<String> call(EngagedUserEntity engagedUserEntity) {
    return repository.createOneToOneChatChannel(engagedUserEntity);
  }
}
