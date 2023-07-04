import 'dart:io';

import 'package:instagram_clone/features/post/data/remote_data_sources/post_remote_data_source.dart';
import 'package:instagram_clone/features/post/domain/entities/file_entity.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/domain/repositories/post_repository.dart';

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

  @override
  Stream<List<PostEntity>> readSinglePost(String postId) =>remoteDataSource.readSinglePost(postId);

  @override
  Future<List<FileEntity>> getFiles()async=>remoteDataSource.getFiles();

  @override
  Future<FileEntity> getSelectedImage(String imagePath) async=>remoteDataSource.getSelectedImage(imagePath);

}
