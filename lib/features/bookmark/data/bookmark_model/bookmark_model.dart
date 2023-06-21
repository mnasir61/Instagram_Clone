import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_entity/bookmark_entity.dart';

class BookmarkModel extends BookmarkEntity {
  final String? postId;
  final String? uid;
  final Timestamp? createdAt;
  final String? postImageUrl;

  BookmarkModel( {this.postImageUrl,this.postId, this.uid, this.createdAt})
      : super(
          postId: postId,
          uid: uid,
          createdAt: createdAt,
    postImageUrl: postImageUrl
        );

  factory BookmarkModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    return BookmarkModel(
      postId: snap["postId"],
      uid: snap["uid"],
      createdAt: snap["createdAt"],
      postImageUrl: snap["postImageUrl"],
    );
  }

  Map<String, dynamic> toDocument() => {
        "postId": postId,
        "uid": uid,
        "createdAt": createdAt,
        "postImageUrl": postImageUrl,
      };
}
