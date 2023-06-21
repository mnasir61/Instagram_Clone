import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/use_cases/follow_unfollow_user_usecase.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_users_usecase.dart';
import 'package:instagram_clone/features/user/domain/use_cases/update_user_usecase.dart';
part 'get_users_state.dart';

class GetUsersCubit extends Cubit<GetUsersState> {
  final UpdateUserUseCase updateUserUseCase;
  final GetUsersUseCase getUsersUseCase;
  final FollowUnfollowUserUseCase followUnfollowUserUseCase;
  GetUsersCubit({
    required this.followUnfollowUserUseCase,
    required this.getUsersUseCase,
    required this.updateUserUseCase
}) : super(GetUsersInitial());

  Future<void> getAllUsers({required UserEntity user}) async {
    try {

      final streamResponse = getUsersUseCase.call(user);
      streamResponse.listen((users) {

          emit(GetUsersLoaded(users: users));
      });

    } on SocketException catch (_) {
      emit(GetUsersFailure());
    } catch (_) {
      emit(GetUsersFailure());
    }
  }

  Future<void> updateUser({required UserEntity user}) async {
    try {
      await updateUserUseCase.call(user);
    } on SocketException catch (_) {
      emit(GetUsersFailure());
    } catch (_) {
      emit(GetUsersFailure());
    }
  }

  Future<void> followUnfollow({required UserEntity user}) async {
    try {
      await followUnfollowUserUseCase.call(user);
    } on SocketException catch (_) {
      emit(GetUsersFailure());
    } catch (_) {
      emit(GetUsersFailure());
    }
  }
}
