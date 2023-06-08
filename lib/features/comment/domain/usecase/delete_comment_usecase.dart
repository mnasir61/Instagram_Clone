


import 'package:instagram_clone/features/comment/domain/entity/comment_entity.dart';
import 'package:instagram_clone/features/comment/domain/repository/comment_repository.dart';

class DeleteCommentUseCase{
  final CommentRepository repository;

  DeleteCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment)async{
    return repository.deleteComment(comment);
  }
}