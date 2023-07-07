
import 'dart:io';

abstract class CloudStorageRepository{
  Future<String> uploadProfileImage({required File file});
  Future<String> uploadPostImage({required File file});
  Future<String> uploadReelsVideo({required File file});
}