

import 'package:instagram_clone/features/bookmark/domain/bookmark_entity/bookmark_entity.dart';

abstract class BookmarkRemoteDataSource{

  Future<void> addBookmark(BookmarkEntity bookmark);
  Future<void> removeBookmark(BookmarkEntity bookmark);
  Stream<List<BookmarkEntity>> getBookmark(BookmarkEntity bookmark);
}