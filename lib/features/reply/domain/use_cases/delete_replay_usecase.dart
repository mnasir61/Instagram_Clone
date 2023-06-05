import 'package:instagram_clone/features/post/reply/domain/entities/reply_entity.dart';
import 'package:instagram_clone/features/post/reply/domain/repositories/replay_repository.dart';

class DeleteReplyUseCase {
  final ReplyRepository repository;

  DeleteReplyUseCase({required this.repository});

  Future<void> call(ReplyEntity reply) async {
    return repository.deleteReply(reply);
  }
}
