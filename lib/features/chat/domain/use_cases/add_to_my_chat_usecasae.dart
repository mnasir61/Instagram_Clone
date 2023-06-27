import 'package:instagram_clone/features/chat/domain/entities/my_chat_entity.dart';
import 'package:instagram_clone/features/chat/domain/repositories/chat_repository.dart';

class AddToMyChatUseCase {
  final ChatRepository repository;

  AddToMyChatUseCase({required this.repository});

  Future<void> call(MyChatEntity myChat) {
    return repository.addToMyChat(myChat);
  }
}
