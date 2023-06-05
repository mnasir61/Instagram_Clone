
import 'package:instagram_clone/features/post/reply/domain/entities/reply_entity.dart';
import 'package:instagram_clone/features/post/reply/domain/repositories/replay_repository.dart';

class LikeReplyUseCase {
  final ReplyRepository repository;

  LikeReplyUseCase({required this.repository});

  Future<void> call(ReplyEntity reply) async {
    return repository.likeReply(reply);
  }
}
