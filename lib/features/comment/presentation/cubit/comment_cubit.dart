import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/post/comment_page/domain/entity/comment_entity.dart';
import 'package:instagram_clone/features/post/comment_page/domain/usecase/create_comment_usecase.dart';
import 'package:instagram_clone/features/post/comment_page/domain/usecase/delete_comment_usecase.dart';
import 'package:instagram_clone/features/post/comment_page/domain/usecase/like_comment_usecase.dart';
import 'package:instagram_clone/features/post/comment_page/domain/usecase/read_comment_usecase.dart';
import 'package:instagram_clone/features/post/comment_page/domain/usecase/update_comment_usecase.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CreateCommentUseCase createCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;
  final LikeCommentUseCase likeCommentUseCase;
  final ReadCommentUseCase readCommentUseCase;
  final UpdateCommentUseCase updateCommentUseCase;

  CommentCubit(
      {required this.createCommentUseCase,
      required this.deleteCommentUseCase,
      required this.likeCommentUseCase,
      required this.readCommentUseCase,
      required this.updateCommentUseCase})
      : super(CommentInitial());

  Future<void> getComments({required String postId}) async {
    emit(CommentLoading());
    try {
      final streamResponse = readCommentUseCase.call(postId);
      streamResponse.listen((comment) {
        emit(CommentLoaded(comments: comment));
      });
    } on SocketException catch (e) {
      emit(CommentFailure());
    } catch (e) {
      emit(CommentFailure());
    }
  }

  Future<void>createComment({required CommentEntity comment})async{
    try{
      await createCommentUseCase.call(comment);
    }on SocketException catch (e){
      emit(CommentFailure());
    }catch(e){
      emit(CommentFailure());
    }
  }
  Future<void>deleteComment({required CommentEntity comment})async{
    try{
      await deleteCommentUseCase.call(comment);
    }on SocketException catch (e){
      emit(CommentFailure());
    }catch(e){
      emit(CommentFailure());
    }
  }
  Future<void>likeComment({required CommentEntity comment})async{
    try{
      await likeCommentUseCase.call(comment);
    }on SocketException catch (e){
      emit(CommentFailure());
    }catch(e){
      emit(CommentFailure());
    }
  }
  Future<void>updateComment({required CommentEntity comment})async{
    try{
      await updateCommentUseCase.call(comment);
    }on SocketException catch (e){
      emit(CommentFailure());
    }catch(e){
      emit(CommentFailure());
    }
  }
}
