import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/chat/domain/entities/my_chat_entity.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/get_my_chats_usecase.dart';

part 'my_chat_state.dart';

class MyChatCubit extends Cubit<MyChatState> {
  final GetMyChatUseCase getMyChatUseCase;

  MyChatCubit({required this.getMyChatUseCase}) : super(MyChatInitial());

  Future<void> getMyChat({required String uid}) async {
    emit(MyChatLoading());
    try {
      final myChat = getMyChatUseCase.call(uid);
      myChat.listen((myChatData) {
        emit(MyChatLoaded(myChat: myChatData));
      });
    } on SocketException {
      emit(MyChatFailure());
    } catch (e) {
      emit(MyChatFailure());
    }
  }
}
