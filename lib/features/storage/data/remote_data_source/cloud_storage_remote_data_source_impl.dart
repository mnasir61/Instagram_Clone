import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/features/storage/data/remote_data_source/cloud_storage_remote_data_source.dart';
import 'package:video_compress/video_compress.dart';

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
    final compressedFile = await _compressVideo(file);
    final ref =
        storage.ref().child("reels/${DateTime.now().microsecondsSinceEpoch}${getNameOnly(file.path)}");

    final uploadTask = ref.putFile(compressedFile!);
    final videoUrl = (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    // if (compressedFile != null && compressedFile != file) {
    //   await compressedFile.delete();
    // }

    return videoUrl;
  }

  Future<File?> _compressVideo(File file) async {
    final info = await VideoCompress.compressVideo(
      file.path,
      quality: VideoQuality.LowQuality,
      deleteOrigin: false,
    );

    if (info != null && info.filesize != null) {
      return info.file!;
    } else {
      return file;
    }
  }

  static String getNameOnly(String path) {
    return path.split("/").last.split("&").last.split("?").first;
  }
}
