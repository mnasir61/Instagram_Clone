

import 'package:instagram_clone/features/bookmark/domain/bookmark_entity/bookmark_entity.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_repository/bookmark_repository.dart';

class RemoveBookmarkUseCase {

  final BookmarkRepository repository;

  const RemoveBookmarkUseCase({required this.repository});

  Future<void> call(BookmarkEntity bookmark) async {
    return repository.removeBookmark(bookmark);
  }
}