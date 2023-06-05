
import 'package:instagram_clone/features/post/reply/domain/entities/reply_entity.dart';
import 'package:instagram_clone/features/post/reply/domain/repositories/replay_repository.dart';

class CreateReplyUseCase {
  final ReplyRepository repository;

  CreateReplyUseCase({required this.repository});

  Future<void> call(ReplyEntity reply) async {
    return repository.createReply(reply);
  }
}
