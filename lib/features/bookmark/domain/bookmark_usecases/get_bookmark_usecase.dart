import 'package:instagram_clone/features/bookmark/domain/bookmark_entity/bookmark_entity.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_repository/bookmark_repository.dart';

class GetBookmarkUseCase {
  final BookmarkRepository repository;

  const GetBookmarkUseCase({required this.repository});

  Stream<List<BookmarkEntity>> call(BookmarkEntity bookmark) {
    return repository.getBookmark(bookmark);
  }
}
