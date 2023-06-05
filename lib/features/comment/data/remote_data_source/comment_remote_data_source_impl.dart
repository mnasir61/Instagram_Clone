import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/post/comment_page/data/models/comment_models.dart';
import 'package:instagram_clone/features/post/comment_page/data/remote_data_source/comment_remote_data_source.dart';
import 'package:instagram_clone/features/post/comment_page/domain/entity/comment_entity.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:instagram_clone/main_injection_container.dart'as di;
class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final FirebaseFirestore fireStore;

  CommentRemoteDataSourceImpl({required this.fireStore});

  @override
  Future<void> createComment(CommentEntity comment) async {
    final commentCollection = fireStore.collection("posts").doc(comment.postId).collection("comments");
    final newComment = CommentModel(
      description: comment.description,
      username: comment.username,
      totalReplies: comment.totalReplies,
      commentId: comment.commentId,
      postId: comment.postId,
      likes: [],
      userProfileUrl: comment.userProfileUrl,
      creatorId: comment.creatorId,
      createdAt: comment.createdAt,
    ).toDocument();

    try {
      final commentDocRef = await commentCollection.doc(comment.commentId).get();
      if (!commentDocRef.exists) {
        commentCollection.doc(comment.commentId).set(newComment).then((value) {
          final postCollection = fireStore.collection("posts").doc(comment.postId);
          postCollection.get().then((value) {
            if (value.exists) {
              final totalComments = value.get("totalComments");
              postCollection.update({"totalComments": totalComments + 1});
            }
          });
        });
      } else {
        commentCollection.doc(comment.commentId).update(newComment);
      }
    } catch (e) {
      print("some error occur $e");
    }
  }

  @override
  Future<void> deleteComment(CommentEntity comment) async {
    final commentCollection = fireStore.collection("posts").doc(comment.postId).collection("comments");
    try {
      commentCollection.doc(comment.commentId).delete().then((value) {
        final postCollection = fireStore.collection("posts").doc(comment.postId);
        postCollection.get().then((value) {
          if (value.exists) {
            final totalComments = value.get("totalComments");
            postCollection.update({"totalComments": totalComments - 1});
          }
        });
      });
    } catch (e) {
      print("some error occur $e");
    }
  }

  @override
  Future<void> likeComment(CommentEntity comment) async {
    final commentCollection = fireStore.collection("posts").doc(comment.postId).collection("comments");
    final currentUid = await di.sl<GetCurrentUidUseCase>().call();
    final commentDocRef = await commentCollection.doc(comment.commentId).get();
    if(commentDocRef.exists){
      List likes = commentDocRef.get("likes");
      if(likes.contains(currentUid)){
        commentCollection.doc(comment.commentId).update({
          "likes": FieldValue.arrayRemove([currentUid]),
        });
      }else {
        commentCollection.doc(comment.commentId).update({
          "likes":FieldValue.arrayUnion([currentUid]),
        });
      }
    }
  }

  @override
  Stream<List<CommentEntity>> readComments(String postId) {
    final commentCollection = fireStore.collection("posts").doc(postId).collection("comments").orderBy("createdAt",descending: true);
    return commentCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => CommentModel.fromSnapshot(e)).toList());

  }

  @override
  Future<void> updateComment(CommentEntity comment)async {
    final commentCollection = fireStore.collection("posts").doc(comment.postId).collection("comments");
    Map<String,dynamic> commentInfo = Map();

    if(comment.description!=""&& comment.description!=null)commentInfo["description"]=comment.description;

    commentCollection.doc(comment.commentId).update(commentInfo);
  }
}
