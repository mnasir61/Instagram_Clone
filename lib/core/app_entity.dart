import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';

class AppEntity {
  final UserEntity? currentUser;
  final PostEntity? postEntity;

  final String? uid;
  final String? postId;
  final String? selectedImagePath;

  AppEntity({this.selectedImagePath, this.currentUser, this.postEntity, this.uid, this.postId});
}
