import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';

class PostPage extends StatefulWidget {
  final UserEntity currentUser;

  const PostPage({Key? key, required this.currentUser}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<FileModel>? files;
  FileModel? selectedModel;
  String? selectedImage;
  BoxFit fitMode = BoxFit.contain;

  final image2 = ValueNotifier<String?>("");

  @override
  void initState() {
    super.initState();
    getDirectories().then((directoryData) {
      setState(() {
        files = directoryData;
        if (files != null && files!.isNotEmpty) {
          selectedModel = files![0];
          image2.value = selectedModel!.files![0];
          selectedImage = selectedModel!.files![0];
        }
      });
    });
  }

  Future<List<FileModel>> getDirectories() async {
    var imagePath = await StoragePath.imagesPath;
    var files = jsonDecode(imagePath!) as List;
    return files.map<FileModel>((e) => FileModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.clear,
          size: 28,
          color: Colors.black,
        ),
        title: Text(
          "New post",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageConsts.uploadPostPage, arguments: {
                  'selectedImagePath': selectedImage,
                  'currentUser': widget.currentUser,
                });
              },
              child: Icon(FontAwesomeIcons.arrowRight, color: colorBlue, size: 20)
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            child: ValueListenableBuilder<String?>(
              valueListenable: image2,
              builder: (BuildContext context, String? image, Widget? child) {
                if (image != null && image.isNotEmpty) {
                  return Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRect(
                          child: InteractiveViewer(
                            child: Image.file(
                              File(image),
                              fit: fitMode,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                fitMode = fitMode == BoxFit.cover ? BoxFit.contain : BoxFit.cover;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(.5),
                              ),
                              child: Icon(
                                Icons.code_rounded,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: ValueListenableBuilder<String?>(
                    valueListenable: image2,
                    builder: (context, value, child) {
                      if (files == null || files!.isEmpty) {
                        return CircularProgressIndicator();
                      } else {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton<FileModel>(
                            value: selectedModel,
                            onChanged: (FileModel? newValue) {
                              setState(() {
                                selectedModel = newValue;
                                selectedImage =
                                    newValue?.files?.isNotEmpty == true ? newValue!.files![0] : null;
                                image2.value = selectedImage;
                              });
                            },
                            items: getItems(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: (_, index) {
                  var file = selectedModel?.files?[index] ?? "";
                  return GestureDetector(
                    child: Image.file(
                      File(file),
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      selectedImage = file;
                      image2.value = selectedImage;
                    },
                  );
                },
                itemCount: selectedModel?.files?.length ?? 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<FileModel>> getItems() {
    return files?.map((value) {
          return DropdownMenuItem<FileModel>(
            child: Text(
              value.folder! ?? "",
              style: Styles.titleLine1
                  .copyWith(color: colorBlue, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            value: value,
          );
        }).toList() ??
        [];
  }
}

class FileModel {
  List<String>? files;
  String? folder;

  FileModel({this.files, this.folder});

  FileModel.fromJson(Map<String, dynamic> json) {
    files = json['files'].cast<String>();
    folder = json['folderName'];
  }
}
