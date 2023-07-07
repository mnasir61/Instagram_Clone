import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reel_repository.dart';

class GetSingleReelUseCase {
  final ReelRepository repository;

  GetSingleReelUseCase({required this.repository});

  Stream<List<ReelEntity>> call(String reelId) {
    return repository.getSingleReel(reelId);
  }
}
