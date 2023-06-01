









import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class UpdateUserUseCase {
  final UserRepository repository;

  UpdateUserUseCase({ required this.repository});

  Future<void> call(UserEntity user)async{
    return await repository.updateUser(user);
  }
}
