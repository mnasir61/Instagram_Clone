import 'package:instagram_clone/features/home_page/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/home_page/domain/repositories/post_repository.dart';

class ReadPostUseCase {
  final PostRepository repository;

  ReadPostUseCase({required this.repository});

  Stream<List<PostEntity>> call(PostEntity post) {
    return repository.readPost(post);
  }
}
