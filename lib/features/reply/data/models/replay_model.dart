import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/reply/domain/entities/reply_entity.dart';

class ReplyModel extends ReplyEntity {
  final String? creatorUid;
  final String? replyId;
  final String? commentId;
  final String? postId;
  final String? description;
  final String? username;
  final String? userProfileUrl;
  final Timestamp? createdAt;
  final List<String>? likes;

  ReplyModel(
      {this.creatorUid,
      this.replyId,
      this.commentId,
      this.postId,
      this.description,
      this.username,
      this.userProfileUrl,
      this.createdAt,
      this.likes})
      : super(
            creatorUid: creatorUid,
            replyId: replyId,
            commentId: commentId,
            postId: postId,
            description: description,
            username: username,
            userProfileUrl: userProfileUrl,
            createdAt: createdAt,
            likes: likes);

  factory ReplyModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ReplyModel(
      creatorUid: snapshot["creatorUid"],
      replyId: snapshot["replyId"],
      commentId: snapshot["commentId"],
      postId: snapshot["postId"],
      description: snapshot["description"],
      username: snapshot["username"],
      userProfileUrl: snapshot["userProfileUrl"],
      createdAt: snapshot["createdAt"],
      likes: List.from(snap.get("likes")),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "creatorUid": creatorUid,
      "replyId": replyId,
      "commentId": commentId,
      "postId": postId,
      "description": description,
      "username": username,
      "userProfileUrl": userProfileUrl,
      "createdAt": createdAt,
      "likes": likes,
    };
  }
}
