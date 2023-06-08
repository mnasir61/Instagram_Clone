



import 'package:instagram_clone/features/comment/domain/entity/comment_entity.dart';
import 'package:instagram_clone/features/comment/domain/repository/comment_repository.dart';

class CreateCommentUseCase{
  final CommentRepository repository;

  CreateCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment)async{
    return repository.createComment(comment);
  }
}