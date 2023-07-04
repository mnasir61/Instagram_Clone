part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}
class PostLoaded extends PostState {
  final List<PostEntity> posts;

  PostLoaded({required this.posts});
  @override
  List<Object> get props => [posts];
}
class PostLoading extends PostState {
  @override
  List<Object> get props => [];
}
class PostFailure extends PostState {
  @override
  List<Object> get props => [];
}
class PostSelectedImageLoaded extends PostState {
  final FileEntity selectedImage;

  PostSelectedImageLoaded({ required this.selectedImage}); // New property
  @override
  List<Object> get props => [selectedImage];
}
class PostLoadedImage extends PostState {
  final List<FileEntity> files;

  PostLoadedImage({required this.files}); // New property
  @override
  List<Object> get props => [files];
}


