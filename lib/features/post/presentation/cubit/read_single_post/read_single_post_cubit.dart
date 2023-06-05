import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/domain/use_cases/read_single_post_usecase.dart';

part 'read_single_post_state.dart';

class ReadSinglePostCubit extends Cubit<ReadSinglePostState> {
  final ReadSinglePostUseCase readSinglePostUseCase;

  ReadSinglePostCubit({required this.readSinglePostUseCase}) : super(ReadSinglePostInitial());

  Future<void> getSinglePost({required String postId}) async {
    emit(ReadSinglePostLoading());
    try {
      final streamResponse = readSinglePostUseCase.call(postId);
      streamResponse.listen((posts) {
        emit(ReadSinglePostLoaded(posts: posts.first));
      });
    } on SocketException catch (e) {
      emit(ReadSinglePostFailure());
    } catch (e) {
      emit(ReadSinglePostFailure());
    }
  }
}
