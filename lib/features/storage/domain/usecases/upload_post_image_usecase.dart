import 'dart:io';

import 'package:instagram_clone/features/storage/domain/repository/could_storage_repository.dart';

class UploadPostImageUseCase {
  final CloudStorageRepository repository;

  UploadPostImageUseCase({required this.repository});

  Future<String> call({required File file}) async {
    return repository.uploadPostImage(file: file);
  }
}
