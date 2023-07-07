import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';
import 'package:instagram_clone/features/reels/domain/use_cases/create_new_reel_usecase.dart';
import 'package:instagram_clone/features/reels/domain/use_cases/delete_reel_usecase.dart';
import 'package:instagram_clone/features/reels/domain/use_cases/get_all_reels_usecase.dart';
import 'package:instagram_clone/features/reels/domain/use_cases/like_reel_usecase.dart';
import 'package:instagram_clone/features/reels/domain/use_cases/update_reel_usecase.dart';

part 'reel_state.dart';

class ReelCubit extends Cubit<ReelState> {
  final CreateNewReelUseCase createNewReelUseCase;
  final DeleteReelUseCase deleteReelUseCase;
  final GetAllReelsUseCase getAllReelsUseCase;
  final LikeReelUseCase likeReelUseCase;
  final UpdateReelUseCase updateReelUseCase;

  ReelCubit(
      {required this.createNewReelUseCase,
      required this.deleteReelUseCase,
      required this.getAllReelsUseCase,
      required this.likeReelUseCase,
      required this.updateReelUseCase})
      : super(ReelInitial());

  Future<void> createNewReel({required ReelEntity reelEntity}) async {
    try {
      await createNewReelUseCase.call(reelEntity);
    } on SocketException {
      emit(ReelFailure());
    } catch (e) {
      emit(ReelFailure());
    }
  }

  Future<void> deleteReel({required ReelEntity reelEntity}) async {
    try {
      await deleteReelUseCase.call(reelEntity);
    } on SocketException {
      emit(ReelFailure());
    } catch (e) {
      emit(ReelFailure());
    }
  }

  Future<void> getAllReels({required ReelEntity reelEntity}) async {
    emit(ReelLaoding());
    try {
      final streamResponse = getAllReelsUseCase.call(reelEntity);
      streamResponse.listen((reels) {
        emit(ReelLoaded(reels: reels));
      });
    } on SocketException {
      emit(ReelFailure());
    } catch (e) {
      emit(ReelFailure());
    }
  }

  Future<void> likeReel({required ReelEntity reelEntity}) async {
    try {
      await likeReelUseCase.call(reelEntity);
    } on SocketException {
      emit(ReelFailure());
    } catch (e) {
      emit(ReelFailure());
    }
  }

  Future<void> updateReel({required ReelEntity reelEntity}) async {
    try {
      await updateReelUseCase.call(reelEntity);
    } on SocketException {
      emit(ReelFailure());
    } catch (e) {
      emit(ReelFailure());
    }
  }
}
