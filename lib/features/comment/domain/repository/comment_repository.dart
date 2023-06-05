
import 'package:instagram_clone/features/post/comment_page/domain/entity/comment_entity.dart';

abstract class CommentRepository {
  Future<void> createComment(CommentEntity comment);

  Stream<List<CommentEntity>> readComments(String postId);

  Future<void> updateComment(CommentEntity comment);

  Future<void> deleteComment(CommentEntity comment);

  Future<void> likeComment(CommentEntity comment);
}
