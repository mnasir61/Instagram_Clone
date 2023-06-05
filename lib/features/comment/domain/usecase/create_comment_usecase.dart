


import 'package:instagram_clone/features/post/comment_page/domain/entity/comment_entity.dart';
import 'package:instagram_clone/features/post/comment_page/domain/repository/comment_repository.dart';

class CreateCommentUseCase{
  final CommentRepository repository;

  CreateCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment)async{
    return repository.createComment(comment);
  }
}