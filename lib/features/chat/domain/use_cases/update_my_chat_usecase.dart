import 'package:instagram_clone/features/chat/domain/entities/my_chat_entity.dart';
import 'package:instagram_clone/features/chat/domain/repositories/chat_repository.dart';

class UpdateMyChatUseCase {
  final ChatRepository repository;

  UpdateMyChatUseCase({required this.repository});

  Future<void> call(MyChatEntity myChatEntity) {
    return repository.updateMyChat(myChatEntity);
  }
}
