import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  final String? postId;
  final String? creatorId;
  final String? username;
  final String? description;
  final String? postImageUrl;
  final List<String>? likes;
  final num? totalLikes;
  final num? totalComments;
  final Timestamp? createdAt;
  final String? userProfileUrl;

  PostModel({
    this.postId,
    this.creatorId,
    this.username,
    this.description,
    this.postImageUrl,
    this.likes,
    this.totalLikes,
    this.totalComments,
    this.createdAt,
    this.userProfileUrl,
  }) : super(
            postId: postId,
            creatorId: creatorId,
            username: username,
            description: description,
            postImageUrl: postImageUrl,
            likes: likes,
            totalLikes: totalLikes,
            totalComments: totalComments,
            createdAt: createdAt,
            userProfileUrl: userProfileUrl);

  factory PostModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
      postId: snapshot['postId'],
      creatorId: snapshot['creatorId'],
      username: snapshot['username'],
      description: snapshot['description'],
      postImageUrl: snapshot['postImageUrl'],
      likes: List.from(snap.get("likes")),
      totalLikes: snapshot['totalLikes'],
      totalComments: snapshot['totalComments'],
      createdAt: snapshot['createdAt'],
      userProfileUrl: snapshot['userProfileUrl'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "postId": postId,
      "creatorId": creatorId,
      "username": username,
      "description": description,
      "postImageUrl": postImageUrl,
      "likes": likes,
      "totalLikes": totalLikes,
      "totalComments": totalComments,
      "createdAt": createdAt,
      "userProfileUrl": userProfileUrl,
    };
  }
}
