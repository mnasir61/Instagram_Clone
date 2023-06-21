import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BookmarkEntity extends Equatable {
  final String? postId;
  final String? uid;
  final Timestamp? createdAt;
  final String? postImageUrl;

  BookmarkEntity({
    this.postId,
    this.uid,
    this.createdAt,
    this.postImageUrl,
  });

  @override
  List<Object?> get props => [
        postId,
        uid,
        createdAt,
    postImageUrl,
      ];
}
