

import 'dart:io';

abstract class CloudStorageRemoteDataSource{
  Future<String> uploadProfileImage({required File file});
  Future<String> uploadPostImage({required File file});
}