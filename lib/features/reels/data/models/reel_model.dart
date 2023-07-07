import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';

class ReelModel extends ReelEntity {
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

  ReelModel(
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
      this.creatorUsername})
      : super(
            reelId: reelId,
            creatorId: creatorId,
            reelVideoUrl: reelVideoUrl,
            createdAt: createdAt,
            description: description,
            likes: likes,
            totalLikes: totalLikes,
            totalComments: totalComments,
            views: views,
            totalShares: totalShares,
            reelDuration: reelDuration,
            tags: tags,
            hashTags: hashTags,
            creatorProfileImage: creatorProfileImage,
            creatorUsername: creatorUsername);

  factory ReelModel.fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return ReelModel(
      reelId: snap["reelId"],
      creatorId: snap["creatorId"],
      reelVideoUrl: snap["reelVideoUrl"],
      createdAt: snap["createdAt"],
      description: snap["description"],
      likes: List.from(snapshot.get("likes")),
      totalLikes: snap["totalLikes"],
      totalComments: snap["totalComments"],
      views: snap["views"],
      totalShares: snap["totalShares"],
      reelDuration: snap["reelDuration"],
      tags: List.from(snapshot.get("tags")),
      hashTags: List.from(snapshot.get("hashTags")),
      creatorProfileImage: snap["creatorProfileImage"],
      creatorUsername: snap["creatorUsername"],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "reelId": reelId,
      "creatorId": creatorId,
      "reelVideoUrl": reelVideoUrl,
      "createdAt": createdAt,
      "description": description,
      "likes": likes,
      "totalLikes": totalLikes,
      "totalComments": totalComments,
      "views": views,
      "totalShares": totalShares,
      "reelDuration": reelDuration,
      "tags": tags,
      "hashTags": hashTags,
      "creatorProfileImage": creatorProfileImage,
      "creatorUsername": creatorUsername,
    };
  }
}
