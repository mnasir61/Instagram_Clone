
import 'package:instagram_clone/features/post/reply/data/remote_data_sources/replay_remote_data_source.dart';
import 'package:instagram_clone/features/post/reply/domain/entities/reply_entity.dart';
import 'package:instagram_clone/features/post/reply/domain/repositories/replay_repository.dart';

class ReplyRepositoryImpl implements ReplyRepository{
  final ReplyRemoteDataSource remoteDataSource;

  ReplyRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> createReply(ReplyEntity reply) async=>remoteDataSource.createReply(reply);

  @override
  Future<void> deleteReply(ReplyEntity reply) async=>remoteDataSource.deleteReply(reply);

  @override
  Future<void> likeReply(ReplyEntity reply)async=>remoteDataSource.likeReply(reply);

  @override
  Stream<List<ReplyEntity>> readReply(ReplyEntity reply) =>remoteDataSource.readReply(reply);

  @override
  Future<void> updateReply(ReplyEntity reply) async=>remoteDataSource.updateReply(reply);
  
}