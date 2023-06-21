import 'package:instagram_clone/features/storage/data/remote_data_source/cloud_storage_remote_data_source.dart';
import 'package:instagram_clone/features/storage/data/remote_data_source/cloud_storage_remote_data_source_impl.dart';
import 'package:instagram_clone/features/storage/data/repository/could_storage_repository_impl.dart';
import 'package:instagram_clone/features/storage/domain/repository/could_storage_repository.dart';
import 'package:instagram_clone/features/storage/domain/usecases/upload_post_image_usecase.dart';
import 'package:instagram_clone/features/storage/domain/usecases/upload_profile_image_usecase.dart';
import 'package:instagram_clone/main_injection_container.dart';

Future<void> storageInjectionContainer() async {
  //UseCases
  sl.registerLazySingleton<UploadProfileImageUseCase>(
      () => UploadProfileImageUseCase(repository: sl.call()));
  sl.registerLazySingleton<UploadPostImageUseCase>(
      () => UploadPostImageUseCase(repository: sl.call()));
  //RemoteDataSource
  sl.registerLazySingleton<CloudStorageRemoteDataSource>(
      () => CloudStorageRemoteDataSourceImpl(storage: sl.call()));

  //Repository
  sl.registerLazySingleton<CloudStorageRepository>(
      () => CloudStorageRepositoryImpl(remoteDataSource: sl.call()));
}
