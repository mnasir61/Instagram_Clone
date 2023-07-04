import 'package:equatable/equatable.dart';

class FileEntity extends Equatable {
  final List<String>? files;
  final String? folder;
  final String? imagePath;

  FileEntity( {this.imagePath,this.files, this.folder});

  @override
  List<Object?> get props => [files, folder,imagePath];
}
