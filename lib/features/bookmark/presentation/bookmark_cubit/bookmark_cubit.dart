import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_entity/bookmark_entity.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_usecases/add_bookmark_usecase.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_usecases/get_bookmark_usecase.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_usecases/remove_bookmark_usecase.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  final AddBookmarkUseCase addBookmarkUseCase;
  final RemoveBookmarkUseCase removeBookmarkUseCase;
  final GetBookmarkUseCase getBookmarkUseCase;

  BookmarkCubit(
      {required this.addBookmarkUseCase,
      required this.removeBookmarkUseCase,
      required this.getBookmarkUseCase})
      : super(BookmarkInitial());

  Future<void> getBookmarks({required BookmarkEntity bookmark}) async {
    emit(BookmarkLoading());
    try {
      final streamResponse = getBookmarkUseCase.call(bookmark);
      streamResponse.listen((bookmarks) {
        emit(BookmarkLoaded(bookmarks: bookmarks));
      });
    } on SocketException {
      emit(BookmarkLoading());
    } catch (e) {
      emit(BookmarkLoading());
    }
  }

  Future<void> addBookmark({required BookmarkEntity bookmark}) async {
    try {
      await addBookmarkUseCase.call(bookmark);
    } on SocketException {
      emit(BookmarkLoading());
    } catch (e) {
      emit(BookmarkLoading());
    }
  }

  Future<void> removeBookmark({required BookmarkEntity bookmark}) async {
    try {
      await removeBookmarkUseCase.call(bookmark);
    } on SocketException {
      emit(BookmarkLoading());
    } catch (e) {
      emit(BookmarkLoading());
    }
  }
}
