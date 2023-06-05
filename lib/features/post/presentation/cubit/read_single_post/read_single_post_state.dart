part of 'read_single_post_cubit.dart';

abstract class ReadSinglePostState extends Equatable {
  const ReadSinglePostState();
}

class ReadSinglePostInitial extends ReadSinglePostState {
  @override
  List<Object> get props => [];
}
class ReadSinglePostLoaded extends ReadSinglePostState {
  final PostEntity posts;

  ReadSinglePostLoaded({required this.posts});
  @override
  List<Object> get props => [posts];
}
class ReadSinglePostLoading extends ReadSinglePostState {
  @override
  List<Object> get props => [];
}
class ReadSinglePostFailure extends ReadSinglePostState {
  @override
  List<Object> get props => [];
}
