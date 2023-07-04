



import 'package:instagram_clone/features/post/domain/entities/file_entity.dart';
import 'package:instagram_clone/features/post/domain/repositories/post_repository.dart';

class GetFileUseCase{
  final PostRepository repository;

  GetFileUseCase({required this.repository});

  Future<List<FileEntity>> call()async{
    return repository.getFiles();
  }
}