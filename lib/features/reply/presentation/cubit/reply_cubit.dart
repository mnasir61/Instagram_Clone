import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/post/reply/domain/entities/reply_entity.dart';
import 'package:instagram_clone/features/post/reply/domain/use_cases/create_replay_usecase.dart';
import 'package:instagram_clone/features/post/reply/domain/use_cases/delete_replay_usecase.dart';
import 'package:instagram_clone/features/post/reply/domain/use_cases/like_replay_usecase.dart';
import 'package:instagram_clone/features/post/reply/domain/use_cases/read_replay_usecase.dart';
import 'package:instagram_clone/features/post/reply/domain/use_cases/update_replay_usecase.dart';

part 'reply_state.dart';

class ReplyCubit extends Cubit<ReplyState> {
  final CreateReplyUseCase createReplyUseCase;
  final DeleteReplyUseCase deleteReplyUseCase;
  final UpdateReplyUseCase updateReplyUseCase;
  final ReadReplyUseCase readReplyUseCase;
  final LikeReplyUseCase likeReplyUseCase;

  ReplyCubit(
      {required this.createReplyUseCase,
      required this.deleteReplyUseCase,
      required this.updateReplyUseCase,
      required this.readReplyUseCase,
      required this.likeReplyUseCase})
      : super(ReplyInitial());

  Future<void> createReply({required ReplyEntity reply}) async {
    try {
      await createReplyUseCase.call(reply);
    } on SocketException catch (e) {
      emit(ReplyFailure());
    } catch (e) {
      emit(ReplyFailure());
    }
  }

  Future<void> deleteReply({required ReplyEntity reply}) async {
    try {
      await deleteReplyUseCase.call(reply);
    } on SocketException catch (e) {
      emit(ReplyFailure());
    } catch (e) {
      emit(ReplyFailure());
    }
  }

  Future<void> updateReply({required ReplyEntity reply}) async {
    try {
      await updateReplyUseCase.call(reply);
    } on SocketException catch (e) {
      emit(ReplyFailure());
    } catch (e) {
      emit(ReplyFailure());
    }
  }

  Future<void> likeReply({required ReplyEntity reply}) async {
    try {
      await likeReplyUseCase.call(reply);
    } on SocketException catch (e) {
      emit(ReplyFailure());
    } catch (e) {
      emit(ReplyFailure());
    }
  }

  Future<void> readReply({required ReplyEntity reply}) async {
    emit(ReplyLoading());
    try {
      final streamResponse = readReplyUseCase.call(reply);
      streamResponse.listen((reply) {
        emit(ReplyLoaded(replies: reply));
      });
    } on SocketException catch (e) {
      emit(ReplyFailure());
    } catch (e) {
      emit(ReplyFailure());
    }
  }
}
