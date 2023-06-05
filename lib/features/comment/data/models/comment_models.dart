import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/post/comment_page/domain/entity/comment_entity.dart';

class CommentModel extends CommentEntity {
  final String? description;
  final String? commentId;
  final String? postId;
  final String? username;
  final String? creatorId;
  final String? userProfileUrl;
  final Timestamp? createdAt;
  final List<String>? likes;
  final num? totalReplies;

  CommentModel(
      {this.description,
      this.commentId,
      this.postId,
      this.username,
      this.creatorId,
      this.userProfileUrl,
      this.createdAt,
      this.likes,
      this.totalReplies})
      : super(
            description: description,
            commentId: commentId,
            postId: postId,
            username: username,
            createdAt: createdAt,
            creatorId: creatorId,
            userProfileUrl: userProfileUrl,
            likes: likes,
            totalReplies: totalReplies);

  factory CommentModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CommentModel(
      description: snapshot["description"],
      commentId: snapshot["commentId"],
      postId: snapshot["postId"],
      username: snapshot["username"],
      createdAt: snapshot["createdAt"],
      creatorId: snapshot["creatorId"],
      userProfileUrl: snapshot["userProfileUrl"],
      likes: List.from(snap.get("likes")),
      totalReplies: snapshot["totalReplies"],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "description": description,
      "commentId": commentId,
      "postId": postId,
      "username": username,
      "createdAt": createdAt,
      "creatorId": creatorId,
      "userProfileUrl": userProfileUrl,
      "likes": likes,
      "totalReplies": totalReplies,
    };
  }
}
