import 'package:instagram_clone/features/chat/domain/entities/engaged_user_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/text_message_entity.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';

class AppEntity {
  final String? channelId;
  final String? senderUid;
  final String? recipientUid;
  final String? recipientName;
  final String? senderName;
  final String? senderProfileUrl;
  final String? recipientProfileUrl;

  final String? messageId;

  final EngagedUserEntity? engagedUserEntity;
  final TextMessageEntity? textMessageEntity;
  final UserEntity? currentUser;
  final PostEntity? postEntity;
  final UserEntity? recipientUser;

  final String? otherUser;
  final String? uid;
  final String? postId;
  final String? selectedImagePath;



  AppEntity(
      {this.channelId,
      this.senderUid,
      this.recipientUid,
      this.recipientName,
      this.senderName,
      this.senderProfileUrl,
      this.recipientProfileUrl,
      this.messageId,
      this.engagedUserEntity,
      this.textMessageEntity,
      this.recipientUser,
      this.otherUser,
      this.selectedImagePath,
      this.currentUser,
      this.postEntity,
      this.uid,
      this.postId});
}
