

import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reel_repository.dart';

class LikeReelUseCase{
 final ReelRepository repository;

  LikeReelUseCase({required this.repository});

  Future<void> call(ReelEntity reelEntity)async{
    return repository.likeReel(reelEntity);
  }
}