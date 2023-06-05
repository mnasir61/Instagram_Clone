import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/post/reply/data/models/replay_model.dart';
import 'package:instagram_clone/features/post/reply/domain/entities/reply_entity.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

import 'replay_remote_data_source.dart';

class ReplyRemoteDataSourceImpl implements ReplyRemoteDataSource {
  final FirebaseFirestore fireStore;

  ReplyRemoteDataSourceImpl({required this.fireStore});

  @override
  Future<void> createReply(ReplyEntity reply) async {
    final replyCollection = fireStore
        .collection("posts")
        .doc(reply.postId)
        .collection("comments")
        .doc(reply.commentId)
        .collection("reply");
    final newReply = ReplyModel(
      creatorUid: reply.creatorUid,
      commentId: reply.commentId,
      postId: reply.postId,
      replyId: reply.replyId,
      description: reply.description,
      userProfileUrl: reply.userProfileUrl,
      username: reply.username,
      createdAt: reply.createdAt,
      likes: [],
    ).toDocument();

    try {
      final replyDocRef = await replyCollection.doc(reply.replyId).get();
      if (!replyDocRef.exists) {
        replyCollection.doc(reply.replyId).set(newReply);
      } else {
        replyCollection.doc(reply.replyId).update(newReply);
      }
    } catch (e) {
      print("some error occur");
    }
  }

  @override
  Future<void> deleteReply(ReplyEntity reply) async {
    final replyCollection = fireStore
        .collection("posts")
        .doc(reply.postId)
        .collection("comments")
        .doc(reply.commentId)
        .collection("reply");
    try {
      replyCollection.doc(reply.replyId).delete();
    } catch (e) {
      print("some error occur");
    }
  }

  @override
  Future<void> likeReply(ReplyEntity reply) async {
    final replyCollection = fireStore
        .collection("posts")
        .doc(reply.postId)
        .collection("comments")
        .doc(reply.commentId)
        .collection("reply");
    final currentUid = await di.sl<GetCurrentUidUseCase>().call();
    final replyDocRef = await replyCollection.doc(reply.replyId).get();
    if (replyDocRef.exists) {
      List likes = replyDocRef.get("likes");
      if (likes.contains(currentUid)) {
        replyCollection.doc(reply.replyId).update({
          "likes": FieldValue.arrayRemove([currentUid]),
        });
      } else {
        replyCollection.doc(reply.replyId).update({
          "likes": FieldValue.arrayUnion([currentUid]),
        });
      }
    }
  }

  @override
  Stream<List<ReplyEntity>> readReply(ReplyEntity reply) {
    final replyCollection = fireStore
        .collection("posts")
        .doc(reply.postId)
        .collection("comments")
        .doc(reply.commentId)
        .collection("reply");
    return replyCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((e) => ReplyModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updateReply(ReplyEntity reply)async {
    final replyCollection = fireStore
        .collection("posts")
        .doc(reply.postId)
        .collection("comments")
        .doc(reply.commentId)
        .collection("reply");
    Map<String,dynamic> replyInfo = Map();
    if(reply.description!=""&& reply.description!=null)replyInfo["description"]=reply.description;
    
    replyCollection.doc(reply.replyId).update(replyInfo);
    
  }
}
