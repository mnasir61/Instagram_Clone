



import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class ForgotPasswordUseCase {
  final UserRepository repository;

  ForgotPasswordUseCase({ required this.repository});

  Future<void> call(String email)async{
    return await repository.forgotPassword(email);
  }
}