import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reel_repository.dart';

class GetAllReelsUseCase {
  final ReelRepository repository;

  GetAllReelsUseCase({required this.repository});

  Stream<List<ReelEntity>> call(ReelEntity reelEntity) {
    return repository.getAllReels(reelEntity);
  }
}
