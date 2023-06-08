

import 'package:instagram_clone/features/comment/data/remote_data_source/comment_remote_data_source.dart';
import 'package:instagram_clone/features/comment/domain/entity/comment_entity.dart';
import 'package:instagram_clone/features/comment/domain/repository/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource remoteDataSource;

  CommentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createComment(CommentEntity comment) async => remoteDataSource.createComment(comment);

  @override
  Future<void> deleteComment(CommentEntity comment) async => remoteDataSource.deleteComment(comment);

  @override
  Future<void> likeComment(CommentEntity comment) async => remoteDataSource.likeComment(comment);

  @override
  Stream<List<CommentEntity>> readComments(String postId) => remoteDataSource.readComments(postId);

  @override
  Future<void> updateComment(CommentEntity comment) async => remoteDataSource.updateComment(comment);
}
