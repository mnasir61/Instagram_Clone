import 'package:instagram_clone/features/chat/domain/entities/engaged_user_entity.dart';
import 'package:instagram_clone/features/chat/domain/repositories/chat_repository.dart';

class GetChannelIdUseCase {
  final ChatRepository repository;

  GetChannelIdUseCase({required this.repository});

  Future<String> call(EngagedUserEntity engagedUserEntity) {
    return repository.getChannelId(engagedUserEntity);
  }
}
