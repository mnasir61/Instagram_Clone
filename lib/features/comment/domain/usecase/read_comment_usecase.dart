




import 'package:instagram_clone/features/comment/domain/entity/comment_entity.dart';
import 'package:instagram_clone/features/comment/domain/repository/comment_repository.dart';

class ReadCommentUseCase{
  final CommentRepository repository;

  ReadCommentUseCase({required this.repository});

  Stream<List<CommentEntity>> call(String postId){
    return repository.readComments(postId);
  }
}