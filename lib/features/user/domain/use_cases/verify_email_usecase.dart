









import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

class VerifyEmailUseCase {
  final UserRepository repository;

  VerifyEmailUseCase({ required this.repository});

  Future<void> call(String? emailPinCode)async{
    return await repository.verifyEmail(emailPinCode!);
  }
}
