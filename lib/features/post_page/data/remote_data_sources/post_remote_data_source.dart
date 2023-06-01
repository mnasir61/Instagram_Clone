import 'dart:io';

import 'package:instagram_clone/features/post_page/domain/entities/post_entity.dart';



abstract class PostRemoteDataSource {
  Future<void> createPost(PostEntity post);

  Stream<List<PostEntity>> readPost(PostEntity post);

  Future<void> updatePost(PostEntity post);

  Future<void> deletePost(PostEntity post);

  Future<void> likePost(PostEntity post);

}