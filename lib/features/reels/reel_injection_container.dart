import 'package:instagram_clone/features/reels/data/remote_data_sources/reel_remote_data_source.dart';
import 'package:instagram_clone/features/reels/data/remote_data_sources/reel_remote_data_source_impl.dart';
import 'package:instagram_clone/features/reels/data/repositories/reel_repositpory_impl.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reel_repository.dart';
import 'package:instagram_clone/features/reels/domain/use_cases/create_new_reel_usecase.dart';
import 'package:instagram_clone/features/reels/domain/use_cases/delete_reel_usecase.dart';
import 'package:instagram_clone/features/reels/domain/use_cases/get_all_reels_usecase.dart';
import 'package:instagram_clone/features/reels/domain/use_cases/like_reel_usecase.dart';
import 'package:instagram_clone/features/reels/domain/use_cases/update_reel_usecase.dart';
import 'package:instagram_clone/features/reels/presentation/cubit/reel_cubit.dart';
import 'package:instagram_clone/main_injection_container.dart';

Future<void> reelInjectionContainer() async {
  //reel cubit
  sl.registerFactory(() => ReelCubit(
      createNewReelUseCase: sl.call(),
      deleteReelUseCase: sl.call(),
      getAllReelsUseCase: sl.call(),
      likeReelUseCase: sl.call(),
      updateReelUseCase: sl.call()));
  //reel use case
  sl.registerLazySingleton<CreateNewReelUseCase>(() => CreateNewReelUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteReelUseCase>(() => DeleteReelUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAllReelsUseCase>(() => GetAllReelsUseCase(repository: sl.call()));
  sl.registerLazySingleton<LikeReelUseCase>(() => LikeReelUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateReelUseCase>(() => UpdateReelUseCase(repository: sl.call()));
  //reel repository
  sl.registerLazySingleton<ReelRepository>(() => ReelRepositoryImpl(remoteDataSource: sl.call()));
  //reel remote data source
  sl.registerLazySingleton<ReelRemoteDataSource>(
      () => ReelRemoteDataSourceImpl(fireStore: sl.call(), firebaseStorage: sl.call()));
  //external
}
