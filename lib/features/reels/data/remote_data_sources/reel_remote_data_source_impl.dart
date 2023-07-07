import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/features/global/const/firebase_const.dart';
import 'package:instagram_clone/features/reels/data/models/reel_model.dart';
import 'package:instagram_clone/features/reels/data/remote_data_sources/reel_remote_data_source.dart';
import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

class ReelRemoteDataSourceImpl implements ReelRemoteDataSource {
  final FirebaseFirestore fireStore;
  final FirebaseStorage firebaseStorage;

  ReelRemoteDataSourceImpl({required this.fireStore, required this.firebaseStorage});

  @override
  Future<void> createNewReel(ReelEntity reelEntity) async {
    final reelCollection = fireStore.collection(FirebaseConst.reels);
    final newReel = ReelModel(
      reelId: reelEntity.reelId,
      creatorUsername: reelEntity.creatorUsername,
      creatorProfileImage: reelEntity.creatorProfileImage,
      hashTags: reelEntity.hashTags,
      tags: reelEntity.tags,
      reelDuration: reelEntity.reelDuration,
      totalShares: 0,
      views: 0,
      totalComments: 0,
      totalLikes: 0,
      likes: [],
      description: reelEntity.description,
      createdAt: reelEntity.createdAt,
      reelVideoUrl: reelEntity.reelVideoUrl,
      creatorId: reelEntity.creatorId,
    ).toDocument();

    try {
      final reelDocRef = await reelCollection.doc(reelEntity.reelId).get();
      if (!reelDocRef.exists) {
        reelCollection.doc(reelEntity.reelId).set(newReel).then((value) {
          final userCollection = fireStore.collection(FirebaseConst.users).doc(reelEntity.creatorId);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalReels = value.get("totalReels");
              userCollection.update({"totalReels": totalReels + 1});
            }
          });
        });
      } else {
        reelCollection.doc(reelEntity.reelId).update(newReel);
      }
    } catch (e) {
      print("reel cannot create: $e");
    }
  }

  @override
  Future<void> deleteReel(ReelEntity reelEntity) async {
    final reelCollection = fireStore.collection(FirebaseConst.reels);
    try {
      reelCollection.doc(reelEntity.reelId).delete().then((value) {
        final userCollection = fireStore.collection(FirebaseConst.users).doc(reelEntity.creatorId);
        userCollection.get().then((value) {
          if (value.exists) {
            final totalReels = value.get("totalReels");
            userCollection.update({"totalReels": totalReels - 1});
          }
        });
      });
    } catch (e) {
      print("reel cannot delete: $e");
    }
  }

  @override
  Stream<List<ReelEntity>> getAllReels(ReelEntity reelEntity) {
    final reelCollection =
        fireStore.collection(FirebaseConst.reels).orderBy("createdAt", descending: true);
    return reelCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((e) => ReelModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<ReelEntity>> getSingleReel(String reelId) {
    final reelCollection = fireStore
        .collection(FirebaseConst.reels)
        .orderBy("createdAt", descending: true)
        .where("reelId", isEqualTo: reelId);
    return reelCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((e) => ReelModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updateReel(ReelEntity reelEntity) async {
    final reelCollection = fireStore.collection(FirebaseConst.reels);
    Map<String, dynamic> reelInfo = Map();
    if (reelEntity.description != "" && reelEntity.description != null)
      reelInfo["description"] = reelEntity.description;
    if (reelEntity.reelVideoUrl != "" && reelEntity.reelVideoUrl != null)
      reelInfo["reelVideoUrl"] = reelEntity.reelVideoUrl;
    reelCollection.doc(reelEntity.reelId).update(reelInfo);
  }

  @override
  Future<void> likeReel(ReelEntity reelEntity) async {
    final reelCollection = fireStore.collection(FirebaseConst.reels);
    final currentUid = await di.sl<GetCurrentUidUseCase>().call();
    final reelRef = await reelCollection.doc(reelEntity.reelId).get();
    if (reelRef.exists) {
      List likes = reelRef.get("likes");
      final totalLikes = reelRef.get("totalLikes");
      if (likes.contains(currentUid)) {
        reelCollection.doc(reelEntity.reelId).update({
          "likes": FieldValue.arrayRemove([currentUid]),
          "totalLikes": totalLikes - 1,
        });
      } else {
        reelCollection.doc(reelEntity.reelId).update({
          "likes": FieldValue.arrayUnion([currentUid]),
          "totalLikes": totalLikes + 1,
        });
      }
    }
  }
}
