







import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class SignInWithGoogleUseCase {
  final UserRepository repository;

  SignInWithGoogleUseCase({ required this.repository});

  Future<void> call()async{
    return await repository.signInWithGoogle();
  }
}