import 'package:instagram_clone/features/reply/data/remote_data_sources/replay_remote_data_source.dart';
import 'package:instagram_clone/features/reply/data/remote_data_sources/replay_remote_data_source_impl.dart';
import 'package:instagram_clone/features/reply/data/repositories/post_repository_impl.dart';
import 'package:instagram_clone/features/reply/domain/repositories/replay_repository.dart';
import 'package:instagram_clone/features/reply/domain/use_cases/create_replay_usecase.dart';
import 'package:instagram_clone/features/reply/domain/use_cases/delete_replay_usecase.dart';
import 'package:instagram_clone/features/reply/domain/use_cases/delete_replay_usecase.dart';
import 'package:instagram_clone/features/reply/domain/use_cases/like_replay_usecase.dart';
import 'package:instagram_clone/features/reply/domain/use_cases/like_replay_usecase.dart';
import 'package:instagram_clone/features/reply/domain/use_cases/read_replay_usecase.dart';
import 'package:instagram_clone/features/reply/domain/use_cases/read_replay_usecase.dart';
import 'package:instagram_clone/features/reply/domain/use_cases/update_replay_usecase.dart';
import 'package:instagram_clone/features/reply/domain/use_cases/update_replay_usecase.dart';
import 'package:instagram_clone/features/reply/presentation/cubit/reply_cubit.dart';
import 'package:instagram_clone/main_injection_container.dart';

Future<void> replyInjectionContainer() async {
  //Cubit registration
  sl.registerFactory<ReplyCubit>(() => ReplyCubit(
      createReplyUseCase: sl.call(),
      deleteReplyUseCase: sl.call(),
      updateReplyUseCase: sl.call(),
      readReplyUseCase: sl.call(),
      likeReplyUseCase: sl.call()));
  //UseCase Registration

  sl.registerLazySingleton<CreateReplyUseCase>(() => CreateReplyUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteReplyUseCase>(() => DeleteReplyUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateReplyUseCase>(() => UpdateReplyUseCase(repository: sl.call()));
  sl.registerLazySingleton<ReadReplyUseCase>(() => ReadReplyUseCase(repository: sl.call()));
  sl.registerLazySingleton<LikeReplyUseCase>(() => LikeReplyUseCase(repository: sl.call()));
  //Repo Registration
  sl.registerLazySingleton<ReplyRepository>(() => ReplyRepositoryImpl(remoteDataSource: sl.call()));
  //Remote Data Registration
  sl.registerLazySingleton<ReplyRemoteDataSource>(
      () => ReplyRemoteDataSourceImpl(fireStore: sl.call()));
}
