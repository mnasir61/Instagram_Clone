

import 'package:instagram_clone/features/reels/data/remote_data_sources/reel_remote_data_source.dart';
import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reel_repository.dart';

class ReelRepositoryImpl implements ReelRepository{

  final ReelRemoteDataSource remoteDataSource;

  ReelRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> createNewReel(ReelEntity reelEntity) async=> remoteDataSource.createNewReel(reelEntity);

  @override
  Future<void> deleteReel(ReelEntity reelEntity)async=>remoteDataSource.deleteReel(reelEntity);

  @override
  Stream<List<ReelEntity>> getAllReels(ReelEntity reelEntity) =>remoteDataSource.getAllReels(reelEntity);

  @override
  Stream<List<ReelEntity>> getSingleReel(String reelId) =>remoteDataSource.getSingleReel(reelId);

  @override
  Future<void> updateReel(ReelEntity reelEntity) async=>remoteDataSource.updateReel(reelEntity);

  @override
  Future<void> likeReel(ReelEntity reelEntity) async=>remoteDataSource.likeReel(reelEntity);

}