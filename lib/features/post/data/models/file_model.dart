import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/post/domain/entities/file_entity.dart';

class FileModel extends FileEntity {
  final List<String>? files;
  final String? folder;
  final String? imagePath;

  FileModel({this.imagePath, this.files, this.folder})
      : super(files: files, folder: folder, imagePath: imagePath);

  factory FileModel.fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return FileModel(
      folder: snap["folder"],
      imagePath: snap["imagePath"],
      files: List<String>.from(snap["files"]),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "folder": folder,
      "imagePath": imagePath,
      "files": files,
    };
  }
}