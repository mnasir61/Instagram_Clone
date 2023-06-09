




import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase({ required this.repository});

  Stream<List<UserEntity>> call(UserEntity user) {
    return repository.getUsers(user);
  }
}