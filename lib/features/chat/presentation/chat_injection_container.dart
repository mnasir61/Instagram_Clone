import 'package:instagram_clone/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:instagram_clone/features/chat/data/data_sources/chat_remote_data_source_impl.dart';
import 'package:instagram_clone/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:instagram_clone/features/chat/domain/repositories/chat_repository.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/add_to_my_chat_usecasae.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/create_one_to_one_chat_usecase.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/delete_one_to_one_chat_channel.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/delete_single_message.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/get_channel_id_usecase.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/get_messages_usecase.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/get_my_chats_usecase.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/send_text_message_usecase.dart';
import 'package:instagram_clone/features/chat/presentation/cubit/communication/communication_cubit.dart';
import 'package:instagram_clone/features/chat/presentation/cubit/my_chat/my_chat_cubit.dart';
import 'package:instagram_clone/main_injection_container.dart';

Future<void> chatInjectionContainer() async {
  //Cubit
  sl.registerFactory<CommunicationCubit>(() => CommunicationCubit(
      addToMyChatUseCase: sl.call(),
      createOneToOneChatUseCase: sl.call(),
      deleteOneToOneChatChannelUseCase: sl.call(),
      deleteSingleMessageUseCase: sl.call(),
      getChannelIdUseCase: sl.call(),
      getMessagesUseCase: sl.call(),
      getMyChatUseCase: sl.call(),
      sendTextMessageUseCase: sl.call()));

  sl.registerFactory<MyChatCubit>(() => MyChatCubit(getMyChatUseCase: sl.call()));
  //UseCase
  sl.registerLazySingleton<AddToMyChatUseCase>(() => AddToMyChatUseCase(repository: sl.call()));
  sl.registerLazySingleton<CreateOneToOneChatUseCase>(
      () => CreateOneToOneChatUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteOneToOneChatChannelUseCase>(
      () => DeleteOneToOneChatChannelUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteSingleMessageUseCase>(
      () => DeleteSingleMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetChannelIdUseCase>(() => GetChannelIdUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetMessagesUseCase>(() => GetMessagesUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetMyChatUseCase>(() => GetMyChatUseCase(repository: sl.call()));
  sl.registerLazySingleton<SendTextMessageUseCase>(
      () => SendTextMessageUseCase(repository: sl.call()));

  //Repository
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(remoteDataSource: sl.call()));
  //RemoteData
  sl.registerLazySingleton<ChatRemoteDataSource>(() => ChatRemoteDataSourceImpl(fireStore: sl.call()));
  //External
}
