import 'dart:io';

import 'package:instagram_clone/features/post_page/data/remote_data_sources/post_remote_data_source.dart';
import 'package:instagram_clone/features/post_page/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post_page/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createPost(PostEntity post) async => remoteDataSource.createPost(post);

  @override
  Future<void> deletePost(PostEntity post) async => remoteDataSource.deletePost(post);

  @override
  Future<void> likePost(PostEntity post) async => remoteDataSource.likePost(post);

  @override
  Stream<List<PostEntity>> readPost(PostEntity post) => remoteDataSource.readPost(post);

  @override
  Future<void> updatePost(PostEntity post) async => remoteDataSource.updatePost(post);

}
