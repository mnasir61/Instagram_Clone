



import 'package:instagram_clone/features/post/domain/entities/file_entity.dart';
import 'package:instagram_clone/features/post/domain/repositories/post_repository.dart';

class GetSelectedImageUseCase{
  final PostRepository repository;

  GetSelectedImageUseCase({required this.repository});

  Future<FileEntity> call(String imagePath)async{
    return repository.getSelectedImage(imagePath);
  }
}