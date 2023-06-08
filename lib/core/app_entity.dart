import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/reply/domain/entities/reply_entity.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';

class AppEntity {
  final UserEntity? currentUser;
  final PostEntity? postEntity;

  final String? otherUser;
  final String? uid;
  final String? postId;
  final String? selectedImagePath;

  AppEntity({this.otherUser, this.selectedImagePath, this.currentUser, this.postEntity, this.uid, this.postId});
}
