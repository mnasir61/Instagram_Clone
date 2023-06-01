import 'package:instagram_clone/features/user/data/repositories/user_repository_impl.dart';
import 'package:instagram_clone/features/user/domain/repositories/user_repository.dart';
import 'package:instagram_clone/main_injection_container.dart';

import '../data/remote_data_sources/firebase_remote_data_source.dart';
import '../data/remote_data_sources/firebase_remote_data_source_impl.dart';
import '../domain/use_cases/forgot_password_usecase.dart';
import '../domain/use_cases/get_create_current_user_usecase.dart';
import '../domain/use_cases/get_current_uid_usecase.dart';
import '../domain/use_cases/get_single_user_usecase.dart';
import '../domain/use_cases/get_users_usecase.dart';
import '../domain/use_cases/is_sign_in_usecase.dart';
import '../domain/use_cases/sign_in_usercase.dart';
import '../domain/use_cases/sign_in_wih_google_use_case.dart';
import '../domain/use_cases/sign_out_usecase.dart';
import '../domain/use_cases/sign_up_usecase.dart';
import '../domain/use_cases/update_user_usecase.dart';
import '../domain/use_cases/verify_email_usecase.dart';
import 'cubit/auth/auth_cubit.dart';
import 'cubit/credentials/credential_cubit.dart';
import 'cubit/user/get_single_user/get_single_user_cubit.dart';
import 'cubit/user/get_users_cubit.dart';

Future<void> userInjectionContainer() async {
  //Cubit
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      getCurrentUidUseCase: sl.call(), isSignInUseCase: sl.call(), signOutUseCase: sl.call()));

  sl.registerFactory<CredentialCubit>(() => CredentialCubit(
      signUpUseCase: sl.call(),
      signInUseCase: sl.call(),
      forgotPasswordUseCase: sl.call(),
      signInWithGoogleUseCase: sl.call()));

  sl.registerFactory<GetUsersCubit>(() => GetUsersCubit(
        getUsersUseCase: sl.call(),
        updateUserUseCase: sl.call(),
      ));

  sl.registerFactory<GetSingleUserCubit>(() => GetSingleUserCubit(
        getSingleUserUseCase: sl.call(),
      ));
  //UseCases
  sl.registerLazySingleton<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(() => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<VerifyEmailUseCase>(() => VerifyEmailUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInWithGoogleUseCase>(
      () => SignInWithGoogleUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetSingleUserUseCase>(() => GetSingleUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetUsersUseCase>(() => GetUsersUseCase(repository: sl.call()));

  sl.registerLazySingleton<UpdateUserUseCase>(() => UpdateUserUseCase(repository: sl.call()));

  //Repository

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        remoteDataSource: sl.call(),
      ));

  //RemoteDataSource
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() => FirebaseRemoteDataSourceImpl(
      fireStore: sl.call(), firebaseAuth: sl.call(), googleSignIn: sl.call()));
}
