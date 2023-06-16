part of 'bookmark_cubit.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();
}

class BookmarkInitial extends BookmarkState {
  @override
  List<Object> get props => [];
}

class BookmarkLoading extends BookmarkState {
  @override
  List<Object> get props => [];
}

class BookmarkLoaded extends BookmarkState {
  final List<BookmarkEntity> bookmarks;

  BookmarkLoaded({required this.bookmarks});

  @override
  List<Object> get props => [bookmarks];
}

class BookmarkFailure extends BookmarkState {
  @override
  List<Object> get props => [];
}
