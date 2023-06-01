


import 'package:instagram_clone/features/post_page/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post_page/domain/repositories/post_repository.dart';

class DeletePostUseCase{
  final PostRepository repository;

  DeletePostUseCase({required this.repository});

  Future<void> call(PostEntity post)async{
    return repository.deletePost(post);
  }
}