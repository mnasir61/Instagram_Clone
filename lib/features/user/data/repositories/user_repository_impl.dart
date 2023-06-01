import 'dart:io';

import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';

import '../remote_data_sources/firebase_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> forgotPassword(String email) async => remoteDataSource.forgotPassword(email);

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<String> getCurrentUid() async => remoteDataSource.getCurrentUid();

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signInUser(UserEntity user) async => remoteDataSource.signInUser(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUpUser(UserEntity user) async => remoteDataSource.signUpUser(user);

  @override
  Future<void> verifyEmail(String? emailPinCode) async => remoteDataSource.verifyEmail(emailPinCode);

  @override
  Future<void> signInWithGoogle() async => remoteDataSource.signInWithGoogle();

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) => remoteDataSource.getSingleUser(uid);

  @override
  Stream<List<UserEntity>> getUsers() => remoteDataSource.getUsers();

  @override
  Future<void> updateUser(UserEntity user) async => remoteDataSource.updateUser(user);

  @override
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName) async =>
      remoteDataSource.uploadImageToStorage(file, isPost, childName);
}
