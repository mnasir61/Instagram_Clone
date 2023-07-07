import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';
import 'package:instagram_clone/features/reels/domain/use_cases/get_single_reel_usecase.dart';

part 'get_single_reel_state.dart';

class GetSingleReelCubit extends Cubit<GetSingleReelState> {
  final GetSingleReelUseCase getSingleReelUseCase;

  GetSingleReelCubit({required this.getSingleReelUseCase}) : super(GetSingleReelInitial());

  Future<void> getSingleReel({required String reelId}) async {
    try {
      final streamResponse = getSingleReelUseCase.call(reelId);
      streamResponse.listen((reel) {
        emit(GetSingleReelLoaded(reel: reel.first));
      });
    } on SocketException {
      emit(GetSingleReelFailure());
    } catch (e) {
      emit(GetSingleReelFailure());
    }
  }
}
