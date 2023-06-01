import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_single_user_usecase.dart';

part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  final GetSingleUserUseCase getSingleUserUseCase;
  GetSingleUserCubit({
    required this.getSingleUserUseCase
}) : super(GetSingleUserInitial());

  Future<void> getSingleUser({required String uid}) async {
    try {

      final streamResponse = getSingleUserUseCase.call(uid);
      streamResponse.listen((users) {
        if(users.isNotEmpty) {
          emit(GetSingleUserLoaded(singleUser: users.first));
        }
      });

    } on SocketException catch (_) {
      emit(GetSingleUserFailure());
    } catch (_) {
      emit(GetSingleUserFailure());
    }
  }
}
