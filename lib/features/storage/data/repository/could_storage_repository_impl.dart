import 'dart:io';

import 'package:instagram_clone/features/storage/data/remote_data_source/cloud_storage_remote_data_source.dart';
import 'package:instagram_clone/features/storage/domain/repository/could_storage_repository.dart';

class CloudStorageRepositoryImpl implements CloudStorageRepository {
  final CloudStorageRemoteDataSource remoteDataSource;

  CloudStorageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> uploadPostImage({required File file}) async =>
      remoteDataSource.uploadPostImage(file: file);

  @override
  Future<String> uploadProfileImage({required File file}) async =>
      remoteDataSource.uploadProfileImage(file: file);

  @override
  Future<String> uploadReelsVideo({required File file}) =>
      remoteDataSource.uploadReelsVideo(file: file);
}
