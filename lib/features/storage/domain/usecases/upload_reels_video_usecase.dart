import 'dart:io';

import 'package:instagram_clone/features/storage/domain/repository/could_storage_repository.dart';

class UploadReelsVideoUseCase {
  final CloudStorageRepository repository;

  UploadReelsVideoUseCase({required this.repository});

  Future<String> call({required File file}) async {
    return repository.uploadReelsVideo(file: file);
  }
}
