import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
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

  PostEntity({
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
  });

  @override
  List<Object?> get props => [
        postId,
        creatorId,
        username,
        description,
        postImageUrl,
        likes,
        totalLikes,
        totalComments,
        createdAt,
        userProfileUrl,
      ];
}
