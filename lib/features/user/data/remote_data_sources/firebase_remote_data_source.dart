





import 'dart:io';

import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  Future<void> signInUser(UserEntity user);
  Future<void> signInWithGoogle();

  Future<void> getCreateCurrentUser(UserEntity user);

  Future<String> getCurrentUid();

  Future<void> signUpUser(UserEntity user);

  Future<void> forgotPassword(String email);

  Future<void> verifyEmail(String? emailPinCode);

  Future<bool> isSignIn();

  Future<void> signOut();

  Future<void> updateUser(UserEntity user);
  Stream<List<UserEntity>> getUsers(UserEntity user);
  Stream<List<UserEntity>> getSingleUser(String uid);
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName);
}
