import 'package:instagram_clone/features/chat/domain/entities/group_entity.dart';
import 'package:instagram_clone/features/chat/domain/repositories/chat_repository.dart';

class GetGroupsUseCase {
  final ChatRepository repository;

  GetGroupsUseCase({required this.repository});

  Stream<List<GroupEntity>> call() {
    return repository.getGroups();
  }
}
