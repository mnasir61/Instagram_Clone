import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_other_single_user_usecase.dart';

part 'get_other_single_user_state.dart';

class GetOtherSingleUserCubit extends Cubit<GetOtherSingleUserState> {
  final GetOtherSingleUserUseCase getOtherSingleUserUseCase;

  GetOtherSingleUserCubit({required this.getOtherSingleUserUseCase}) : super(GetSingleOtherUserInitial());

  Future<void> getOtherSingleUser({required String otherUid}) async {
    emit(GetSingleOtherUserLoading());
    try {
      final streamResponse = getOtherSingleUserUseCase.call(otherUid);
      streamResponse.listen((users) {
        emit(GetSingleOtherUserLoaded(otherUser: users.first));
      });
    } on SocketException catch (e) {
      emit(GetSingleOtherUserFailure());
    } catch (e) {
      emit(GetSingleOtherUserFailure());
    }
  }
}
