import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInitial());
}
