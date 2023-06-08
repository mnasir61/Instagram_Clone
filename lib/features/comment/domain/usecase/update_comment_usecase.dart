
import 'package:instagram_clone/features/comment/domain/entity/comment_entity.dart';
import 'package:instagram_clone/features/comment/domain/repository/comment_repository.dart';

class UpdateCommentUseCase{
  final CommentRepository repository;

  UpdateCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment)async{
    return repository.updateComment(comment);
  }
}