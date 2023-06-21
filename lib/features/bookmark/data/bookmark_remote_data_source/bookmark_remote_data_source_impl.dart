import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/bookmark/data/bookmark_model/bookmark_model.dart';
import 'package:instagram_clone/features/bookmark/data/bookmark_remote_data_source/bookmark_remote_data_source.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_entity/bookmark_entity.dart';

class BookmarkRemoteDataSourceImpl implements BookmarkRemoteDataSource {
  final FirebaseFirestore fireStore;

  BookmarkRemoteDataSourceImpl({required this.fireStore});

  @override
  Future<void> addBookmark(BookmarkEntity bookmark) async {
    final bookmarkCollection = fireStore.collection("users").doc(bookmark.uid).collection("bookmarks");
    final newBookmark = BookmarkModel(
      postId: bookmark.postId,
      uid: bookmark.uid,
      createdAt: bookmark.createdAt,
      postImageUrl: bookmark.postImageUrl
    ).toDocument();
    try {
      bookmarkCollection.doc(bookmark.postId).get().then((docRef) {
        if (!docRef.exists) {
          bookmarkCollection.doc(bookmark.postId).set(newBookmark);
        } else {
          bookmarkCollection.doc(bookmark.postId).delete();
        }
      });
    } catch (e) {
      print("something wrong during bookmark");
    }
  }

  @override
  Stream<List<BookmarkEntity>> getBookmark(BookmarkEntity bookmark) {
    final bookmarkCollection = fireStore
        .collection("users")
        .doc(bookmark.uid)
        .collection("bookmarks")
        .orderBy("createdAt", descending: true);
    return bookmarkCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((e) => BookmarkModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> removeBookmark(BookmarkEntity bookmark) async {
    final bookmarkCollection = fireStore.collection("users").doc(bookmark.uid).collection("bookmarks");
    try {
      await bookmarkCollection.doc(bookmark.postId).delete();
    } catch (e) {
      print("something wrong while removing bookmark");
    }
  }
}
