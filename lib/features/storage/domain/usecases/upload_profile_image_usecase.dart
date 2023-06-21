import 'dart:io';

import 'package:instagram_clone/features/storage/domain/repository/could_storage_repository.dart';

class UploadProfileImageUseCase {
  final CloudStorageRepository repository;

  UploadProfileImageUseCase({required this.repository});

  Future<String> call({required File file}) async {
    return repository.uploadProfileImage(file: file);
  }
}
