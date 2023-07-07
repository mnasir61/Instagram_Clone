import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reel_repository.dart';

class UpdateReelUseCase {
  final ReelRepository repository;

  UpdateReelUseCase({required this.repository});

  Future<void> call(ReelEntity reelEntity) async {
    return repository.updateReel(reelEntity);
  }
}
