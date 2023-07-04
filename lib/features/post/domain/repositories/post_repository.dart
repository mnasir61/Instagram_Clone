import 'dart:io';

import 'package:instagram_clone/features/post/domain/entities/file_entity.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';


abstract class PostRepository {
  Future<void> createPost(PostEntity post);

  Stream<List<PostEntity>> readPost(PostEntity post);
  Stream<List<PostEntity>> readSinglePost(String postId);

  Future<void> updatePost(PostEntity post);

  Future<void> deletePost(PostEntity post);

  Future<void> likePost(PostEntity post);

  Future<List<FileEntity>> getFiles();
  Future<FileEntity> getSelectedImage(String imagePath);
}
