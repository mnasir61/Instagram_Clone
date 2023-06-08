
import 'package:instagram_clone/features/reply/domain/entities/reply_entity.dart';

abstract class ReplyRepository {
  Future<void> createReply(ReplyEntity reply);

  Future<void> deleteReply(ReplyEntity reply);

  Future<void> updateReply(ReplyEntity reply);

  Future<void> likeReply(ReplyEntity reply);

  Stream<List<ReplyEntity>> readReply(ReplyEntity reply);
}
