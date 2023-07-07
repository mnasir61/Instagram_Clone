part of 'reel_cubit.dart';

abstract class ReelState extends Equatable {
  const ReelState();
}

class ReelInitial extends ReelState {
  @override
  List<Object> get props => [];
}

class ReelLoaded extends ReelState {
  final List<ReelEntity> reels;

  ReelLoaded({required this.reels});

  @override
  List<Object> get props => [reels];
}

class ReelLaoding extends ReelState {
  @override
  List<Object> get props => [];
}

class ReelFailure extends ReelState {
  @override
  List<Object> get props => [];
}
