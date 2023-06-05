

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable{

  final String? description;
  final String? commentId;
  final String? postId;
  final String? username;
  final String? creatorId;
  final String? userProfileUrl;
  final Timestamp? createdAt;
  final List<String>? likes;
  final num? totalReplies;

  CommentEntity(
      {this.description,
      this.commentId,
      this.postId,
      this.username,
      this.creatorId,
      this.userProfileUrl,
      this.createdAt,
      this.likes,
      this.totalReplies});


  @override
  List<Object?> get props => [this.description,
    commentId,
    postId,
    username,
    creatorId,
    userProfileUrl,
    createdAt,
    likes,
    totalReplies];

}