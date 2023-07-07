import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ReelEntity extends Equatable {
  final String? reelId;
  final String? creatorId;
  final String? reelVideoUrl;
  final Timestamp? createdAt;
  final String? description;
  final List<String>? likes;
  final num? totalLikes;
  final num? totalComments;
  final num? views;
  final num? totalShares;
  final Duration? reelDuration;
  final List<String>? tags;
  final List<String>? hashTags;
  final String? creatorProfileImage;
  final String? creatorUsername;

  ReelEntity(
      {this.reelId,
      this.creatorId,
      this.reelVideoUrl,
      this.createdAt,
      this.description,
      this.likes,
      this.totalLikes,
      this.totalComments,
      this.views,
      this.totalShares,
      this.reelDuration,
      this.tags,
      this.hashTags,
      this.creatorProfileImage,
      this.creatorUsername});

  @override
  List<Object?> get props => [
        this.reelId,
        creatorId,
        reelVideoUrl,
        createdAt,
        description,
        likes,
        totalLikes,
        totalComments,
        views,
        totalShares,
        reelDuration,
        tags,
        hashTags,
        creatorProfileImage,
        creatorUsername
      ];
}
