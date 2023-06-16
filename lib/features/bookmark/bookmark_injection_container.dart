import 'package:instagram_clone/features/bookmark/data/bookmark_remote_data_source/bookmark_remote_data_source.dart';
import 'package:instagram_clone/features/bookmark/data/bookmark_remote_data_source/bookmark_remote_data_source_impl.dart';
import 'package:instagram_clone/features/bookmark/data/bookmark_repository_impl/bookmark_repository_impl.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_repository/bookmark_repository.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_usecases/add_bookmark_usecase.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_usecases/get_bookmark_usecase.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_usecases/remove_bookmark_usecase.dart';
import 'package:instagram_clone/features/bookmark/presentation/bookmark_cubit/bookmark_cubit.dart';
import 'package:instagram_clone/main_injection_container.dart';

Future<void> bookmarkInjectionContainer() async {
  //bookmark Cubit
  sl.registerFactory(() => BookmarkCubit(
      addBookmarkUseCase: sl.call(), removeBookmarkUseCase: sl.call(), getBookmarkUseCase: sl.call()));
  //bookmark UseCase
  sl.registerLazySingleton<AddBookmarkUseCase>(() => AddBookmarkUseCase(repository: sl.call()));
  sl.registerLazySingleton<RemoveBookmarkUseCase>(() => RemoveBookmarkUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetBookmarkUseCase>(() => GetBookmarkUseCase(repository: sl.call()));
  //bookmark repository
  sl.registerLazySingleton<BookmarkRepository>(
      () => BookmarkRepositoryImpl(remoteDataSource: sl.call()));
  //bookmark RemoteDataSource
  sl.registerLazySingleton<BookmarkRemoteDataSource>(
      () => BookmarkRemoteDataSourceImpl(fireStore: sl.call()));
  //External Data
}
