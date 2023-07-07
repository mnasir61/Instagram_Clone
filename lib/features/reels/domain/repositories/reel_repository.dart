import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';

abstract class ReelRepository {
  Future<void> createNewReel(ReelEntity reelEntity);

  Future<void> updateReel(ReelEntity reelEntity);

  Future<void> deleteReel(ReelEntity reelEntity);

  Stream<List<ReelEntity>> getAllReels(ReelEntity reelEntity);

  Stream<List<ReelEntity>> getSingleReel(String reelId);

  Future<void> likeReel(ReelEntity reelEntity);


}
