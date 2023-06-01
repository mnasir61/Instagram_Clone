import 'package:instagram_clone/features/home_page/data/remote_data_sources/post_remote_data_source.dart';
import 'package:instagram_clone/features/home_page/data/remote_data_sources/post_remote_data_source_impl.dart';
import 'package:instagram_clone/features/home_page/data/repositories/post_repository_impl.dart';
import 'package:instagram_clone/features/home_page/domain/repositories/post_repository.dart';
import 'package:instagram_clone/features/home_page/domain/use_cases/create_post_usecase.dart';
import 'package:instagram_clone/features/home_page/domain/use_cases/delete_post_usecase.dart';
import 'package:instagram_clone/features/home_page/domain/use_cases/like_post_usecase.dart';
import 'package:instagram_clone/features/home_page/domain/use_cases/read_post_usecase.dart';
import 'package:instagram_clone/features/home_page/domain/use_cases/update_post_usecase.dart';
import 'package:instagram_clone/features/home_page/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/main_injection_container.dart';

Future<void> postInjectionContainer() async {
  //Cubit Registration
  sl.registerFactory(() => PostCubit(
      createPostUseCase: sl.call(),
      deletePostUseCase: sl.call(),
      readPostUseCase: sl.call(),
      likePostUseCase: sl.call(),
      updatePostUseCase: sl.call()));
//Use Cases Registration
  sl.registerLazySingleton<CreatePostUseCase>(() => CreatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeletePostUseCase>(() => DeletePostUseCase(repository: sl.call()));
  sl.registerLazySingleton<ReadPostUseCase>(() => ReadPostUseCase(repository: sl.call()));
  sl.registerLazySingleton<LikePostUseCase>(() => LikePostUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdatePostUseCase>(() => UpdatePostUseCase(repository: sl.call()));
//Repository Registration
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(remoteDataSource: sl.call()));
//Remote Data Source Registration
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(fireStore: sl.call(), firebaseStorage: sl.call()));
}
