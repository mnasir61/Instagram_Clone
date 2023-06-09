




import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class GetOtherSingleUserUseCase {
  final UserRepository repository;

  GetOtherSingleUserUseCase({ required this.repository});

  Stream<List<UserEntity>> call(String otherUid) {
    return repository.getOtherSingleUser(otherUid);
  }
}