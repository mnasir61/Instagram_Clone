import 'package:instagram_clone/features/comment/data/remote_data_source/comment_remote_data_source.dart';
import 'package:instagram_clone/features/comment/data/remote_data_source/comment_remote_data_source_impl.dart';
import 'package:instagram_clone/features/comment/data/repository/comment_repository_impl.dart';
import 'package:instagram_clone/features/comment/domain/repository/comment_repository.dart';
import 'package:instagram_clone/features/comment/domain/usecase/create_comment_usecase.dart';
import 'package:instagram_clone/features/comment/domain/usecase/delete_comment_usecase.dart';
import 'package:instagram_clone/features/comment/domain/usecase/like_comment_usecase.dart';
import 'package:instagram_clone/features/comment/domain/usecase/read_comment_usecase.dart';
import 'package:instagram_clone/features/comment/domain/usecase/update_comment_usecase.dart';
import 'package:instagram_clone/main_injection_container.dart';

import 'presentation/cubit/comment_cubit.dart';

Future<void> commentInjectionContainer() async {
  //cubit Registration
  sl.registerFactory<CommentCubit>(() => CommentCubit(
      createCommentUseCase: sl.call(),
      deleteCommentUseCase: sl.call(),
      likeCommentUseCase: sl.call(),
      readCommentUseCase: sl.call(),
      updateCommentUseCase: sl.call()));
  //UseCase Registration
  sl.registerLazySingleton<CreateCommentUseCase>(() => CreateCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteCommentUseCase>(() => DeleteCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateCommentUseCase>(() => UpdateCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton<LikeCommentUseCase>(() => LikeCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton<ReadCommentUseCase>(() => ReadCommentUseCase(repository: sl.call()));
  //Repository Registration
  sl.registerLazySingleton<CommentRepository>(
      () => CommentRepositoryImpl(remoteDataSource: sl.call()));
  //RemoteDataSource Registration
  sl.registerLazySingleton<CommentRemoteDataSource>(
      () => CommentRemoteDataSourceImpl(fireStore: sl.call()));
}
