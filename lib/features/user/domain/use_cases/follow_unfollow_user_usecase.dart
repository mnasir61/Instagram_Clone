



import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class FollowUnfollowUserUseCase {
  final UserRepository repository;

  FollowUnfollowUserUseCase({ required this.repository});

  Future<void> call(UserEntity user)async{
    return await repository.followUnfollowUser(user);
  }
}