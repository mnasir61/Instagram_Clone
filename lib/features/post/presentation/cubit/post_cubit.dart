import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/domain/use_cases/create_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/use_cases/delete_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/use_cases/like_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/use_cases/read_post_usecase.dart';
import 'package:instagram_clone/features/post/domain/use_cases/update_post_usecase.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final CreatePostUseCase createPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final ReadPostUseCase readPostUseCase;
  final LikePostUseCase likePostUseCase;
  final UpdatePostUseCase updatePostUseCase;

  PostCubit({
    required this.createPostUseCase,
    required this.deletePostUseCase,
    required this.readPostUseCase,
    required this.likePostUseCase,
    required this.updatePostUseCase,
  }) : super(PostInitial());

  Future<void> getPosts({required PostEntity post}) async {
    emit(PostLoading());
    try {
      final streamResponse = readPostUseCase.call(post);
      streamResponse.listen((posts) {
        emit(PostLoaded(posts: posts));
      });
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> likePost({required PostEntity post}) async {
    // emit(PostLoading());
    try {
      await likePostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> deletePost({required PostEntity post}) async {
    // emit(PostLoading());
    try {
      await deletePostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> createPost({required PostEntity post}) async {
    // emit(PostLoading());
    try {
      await createPostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> updatePost({required PostEntity post}) async {
    // emit(PostLoading());
    try {
      await updatePostUseCase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }
}
