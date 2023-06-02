import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/features/post_page/data/models/post_model.dart';
import 'package:instagram_clone/features/post_page/data/remote_data_sources/post_remote_data_source.dart';
import 'package:instagram_clone/features/post_page/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final FirebaseFirestore fireStore;
  final FirebaseStorage firebaseStorage;

  PostRemoteDataSourceImpl( {required this.fireStore, required this.firebaseStorage});

  @override
  Future<void> createPost(PostEntity post) async {
    final postCollectionRef = fireStore.collection("post");
    final newPost = PostModel(
      postId: post.postId,
      username: post.username,
      description: post.description,
      userProfileUrl: post.userProfileUrl,
      creatorId: post.creatorId,
      createdAt: post.createdAt,
      postImageUrl: post.postImageUrl,
      likes: [],
      totalComments: 0,
      totalLikes: 0,
    ).toDocument();
    try {
      final postDocRef = await postCollectionRef.doc(post.postId).get();

      if (!postDocRef.exists) {
        postCollectionRef.doc(post.postId).set(newPost);
      } else {
        postCollectionRef.doc(post.postId).update(newPost);
      }
    } catch (e) {
      print("User cannot created: $e");
    }
  }

  @override
  Future<void> deletePost(PostEntity post) async {
    final postCollectionRef = fireStore.collection("post");
    try {
      postCollectionRef.doc(post.postId).delete();
    } catch (e) {
      print("post cannot delete: $e");
    }
  }

  @override
  Future<void> likePost(PostEntity post) async {
    final postCollectionRef = fireStore.collection("post");
    final currentUid = await di.sl<GetCurrentUidUseCase>().call();
    final postRef = await postCollectionRef.doc(post.postId).get();
    if (postRef.exists) {
      List likes = postRef.get("likes");
      final totalLikes = postRef.get("totalLikes");
      if (likes.contains(currentUid)) {
        postCollectionRef.doc(post.postId).update({
          "likes": FieldValue.arrayRemove([currentUid]),
          "totalLikes": totalLikes - 1
        });
      } else {
        postCollectionRef.doc(post.postId).update({
          "likes": FieldValue.arrayUnion([currentUid]),
          "totalLikes": totalLikes + 1
        });
      }
    }
  }

  @override
  Stream<List<PostEntity>> readPost(PostEntity post) {
    final postCollectionRef = fireStore.collection("post").orderBy("createdAt", descending: true);
    return postCollectionRef
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((e) => PostModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updatePost(PostEntity post) async {
    final postCollectionRef = fireStore.collection("post");
    Map<String, dynamic> postInfo = Map();
    if (post.description != "" && post.description != null) postInfo["description"] = post.description;
    if (post.postImageUrl != "" && post.postImageUrl != null) postInfo["postImageUrl"] = post.postImageUrl;

    postCollectionRef.doc(post.postId).update(postInfo);
  }
}
