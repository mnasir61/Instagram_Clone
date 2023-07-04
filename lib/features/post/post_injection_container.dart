import 'package:instagram_clone/features/post/data/remote_data_sources/post_remote_data_source.dart';
import 'package:instagram_clone/features/post/data/remote_data_sources/post_remote_data_source_impl.dart';
import 'package:instagram_clone/features/post/data/repositories/post_repository_impl.dart';
import 'package:instagram_clone/features/post/domain/repositories/post_repository.dart';
import 'package:instagram_clone/features/post/domain/use_cases/create_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/use_cases/delete_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/use_cases/get_file_usecase.dart';
import 'package:instagram_clone/features/post/domain/use_cases/get_selected_image_usecase.dart';
import 'package:instagram_clone/features/post/domain/use_cases/get_selected_image_usecase.dart';
import 'package:instagram_clone/features/post/domain/use_cases/like_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/use_cases/read_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/use_cases/read_single_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/use_cases/update_post_usecase.dart';
import 'package:instagram_clone/features/post/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/features/post/presentation/cubit/read_single_post/read_single_post_cubit.dart';
import 'package:instagram_clone/main_injection_container.dart';

Future<void> postInjectionContainer() async {
  //Cubit Registration
  sl.registerFactory(() => PostCubit(
      createPostUseCase: sl.call(),
      deletePostUseCase: sl.call(),
      readPostUseCase: sl.call(),
      likePostUseCase: sl.call(),
      updatePostUseCase: sl.call(),
      getFileUseCase: sl.call(), getSelectedImageUseCase: sl.call()));

  //Single Post Cubit
  sl.registerFactory(() => ReadSinglePostCubit(readSinglePostUseCase: sl.call()));

//Use Cases Registration
  sl.registerLazySingleton<CreatePostUseCase>(() => CreatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeletePostUseCase>(() => DeletePostUseCase(repository: sl.call()));
  sl.registerLazySingleton<ReadPostUseCase>(() => ReadPostUseCase(repository: sl.call()));
  sl.registerLazySingleton<LikePostUseCase>(() => LikePostUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdatePostUseCase>(() => UpdatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton<ReadSinglePostUseCase>(() => ReadSinglePostUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetFileUseCase>(() => GetFileUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetSelectedImageUseCase>(() => GetSelectedImageUseCase(repository: sl.call()));
  //Repository Registration
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(remoteDataSource: sl.call()));
//Remote Data Source Registration
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(fireStore: sl.call(), firebaseStorage: sl.call()));
}
