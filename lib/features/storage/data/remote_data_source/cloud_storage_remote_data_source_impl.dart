import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/features/storage/data/remote_data_source/cloud_storage_remote_data_source.dart';

class CloudStorageRemoteDataSourceImpl implements CloudStorageRemoteDataSource {
  final FirebaseStorage storage;

  CloudStorageRemoteDataSourceImpl({required this.storage});

  @override
  Future<String> uploadPostImage({required File file}) async {
    final ref =
        storage.ref().child("post/${DateTime.now().microsecondsSinceEpoch}${getNameOnly(file.path)}");
    final uploadTask = ref.putFile(file);
    final imageUrl = (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    return imageUrl;
  }

  @override
  Future<String> uploadProfileImage({required File file}) async {
    final ref = storage
        .ref()
        .child("profile/${DateTime.now().microsecondsSinceEpoch}${getNameOnly(file.path)}");
    final uploadTask = ref.putFile(file);
    final imageUrl = (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    return imageUrl;
  }

  @override
  Future<String> uploadReelsVideo({required File file}) async {
    final ref = storage
        .ref()
        .child("reels/${DateTime.now().microsecondsSinceEpoch}${getNameOnly(file.path)}");
    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    final videoUrl = await snapshot.ref.getDownloadURL();
    return videoUrl;
  }

  static String getNameOnly(String path) {
    return path.split("/").last.split("&").last.split("?").first;
  }
}
