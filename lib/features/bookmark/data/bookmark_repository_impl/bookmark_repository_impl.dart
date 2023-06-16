import 'package:instagram_clone/features/bookmark/data/bookmark_remote_data_source/bookmark_remote_data_source.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_entity/bookmark_entity.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_repository/bookmark_repository.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkRemoteDataSource remoteDataSource;

  BookmarkRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addBookmark(BookmarkEntity bookmark) async => remoteDataSource.addBookmark(bookmark);

  @override
  Stream<List<BookmarkEntity>> getBookmark(BookmarkEntity bookmark) =>
      remoteDataSource.getBookmark(bookmark);

  @override
  Future<void> removeBookmark(BookmarkEntity bookmark) async =>
      remoteDataSource.removeBookmark(bookmark);
}
