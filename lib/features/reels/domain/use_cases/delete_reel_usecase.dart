import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reel_repository.dart';

class DeleteReelUseCase {
  final ReelRepository repository;

  DeleteReelUseCase({required this.repository});

  Future<void> call(ReelEntity reelEntity) async {
    return repository.deleteReel(reelEntity);
  }
}
