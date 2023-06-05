


import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/domain/repositories/post_repository.dart';

class UpdatePostUseCase{
  final PostRepository repository;

  UpdatePostUseCase({required this.repository});

  Future<void> call(PostEntity post)async{
    return repository.updatePost(post);
  }
}