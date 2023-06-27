import 'package:instagram_clone/features/chat/domain/entities/my_chat_entity.dart';
import 'package:instagram_clone/features/chat/domain/repositories/chat_repository.dart';

class GetMyChatUseCase {
  final ChatRepository repository;

  GetMyChatUseCase({required this.repository});

  Stream<List<MyChatEntity>> call(String uid) {
    return repository.getMyChats(uid);
  }
}
