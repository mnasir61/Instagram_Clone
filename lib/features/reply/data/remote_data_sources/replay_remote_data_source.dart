



import 'package:instagram_clone/features/post/reply/domain/entities/reply_entity.dart';

abstract class ReplyRemoteDataSource {
  Future<void> createReply(ReplyEntity reply);

  Future<void> deleteReply(ReplyEntity reply);

  Future<void> updateReply(ReplyEntity reply);

  Future<void> likeReply(ReplyEntity reply);

  Stream<List<ReplyEntity>> readReply(ReplyEntity reply);
}