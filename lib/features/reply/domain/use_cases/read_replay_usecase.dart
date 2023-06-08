

import 'package:instagram_clone/features/reply/domain/entities/reply_entity.dart';
import 'package:instagram_clone/features/reply/domain/repositories/replay_repository.dart';

class ReadReplyUseCase {
  final ReplyRepository repository;

  ReadReplyUseCase({required this.repository});

  Stream<List<ReplyEntity>> call(ReplyEntity reply) {
    return repository.readReply(reply);
  }
}
