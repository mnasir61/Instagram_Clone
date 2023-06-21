import 'package:instagram_clone/features/chat/domain/entities/my_chat_entity.dart';
import 'package:instagram_clone/features/chat/domain/repositories/chat_repository.dart';

class GetChatsUseCase {
  final ChatRepository repository;

  GetChatsUseCase({required this.repository});

  Stream<List<MyChatEntity>> call() {
    return repository.getChats();
  }
}
