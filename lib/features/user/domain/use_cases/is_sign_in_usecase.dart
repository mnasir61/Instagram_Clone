




import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class IsSignInUseCase {
  final UserRepository repository;

  IsSignInUseCase({ required this.repository});

  Future<bool> call()async{
    return await repository.isSignIn();
  }
}