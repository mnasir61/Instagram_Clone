import 'package:instagram_clone/features/home_page/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<void> createPost(PostEntity post);

  Stream<List<PostEntity>> readPost(PostEntity post);

  Future<void> updatePost(PostEntity post);

  Future<void> deletePost(PostEntity post);

  Future<void> likePost(PostEntity post);
}
