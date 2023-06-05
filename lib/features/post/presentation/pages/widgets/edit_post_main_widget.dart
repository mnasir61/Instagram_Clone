import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/error_message.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/features/user/domain/use_cases/upload_image_to_storage_usecase.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:instagram_clone/main_injection_container.dart' as di;

class EditPostMainWidget extends StatefulWidget {
  final PostEntity posts;

  const EditPostMainWidget({Key? key, required this.posts}) : super(key: key);

  @override
  State<EditPostMainWidget> createState() => _EditPostMainWidgetState();
}

class _EditPostMainWidgetState extends State<EditPostMainWidget> {
  TextEditingController? _descriptionController;

  bool _isUpdate = false;

  @override
  void initState() {
    _descriptionController = TextEditingController(text: widget.posts.description);
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController!.dispose();
    super.dispose();
  }

  File? _image;
  bool? _uploading = false;

  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });
    } catch (e) {
      toast("some error occurred $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(context),
      backgroundColor: Styles.colorWhite,
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: profileWidget(imageUrl: "${widget.posts.userProfileUrl}"))),
                            horizontalSize(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.posts.username}",
                                  style: Styles.titleLine2
                                      .copyWith(color: Styles.colorBlack, fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  "Add location",
                                  style: Styles.titleLine2.copyWith(color: Colors.blue),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "${timeago.format(widget.posts.createdAt!.toDate())}",
                          style: Styles.titleLine2.copyWith(
                              color: Styles.colorBlack.withOpacity(.5), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    verticalSize(10),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .45,
                    child: profileWidget(imageUrl: widget.posts.postImageUrl, image: _image),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: selectImage,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(.7),
                        ),
                        child: Icon(
                          FluentIcons.edit_16_filled,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSize(10),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: InputBorder.none,
                ),
              ),
              Divider(thickness: 1, color: Colors.blue, height: 0),
            ],
          ),
        ],
      ),
    );
  }

  _appBarWidget(BuildContext context) {
    return AppBar(
      backgroundColor: Styles.colorWhite,
      elevation: 0,
      leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            FontAwesomeIcons.close,
            color: Styles.colorBlack,
            size: 23,
          )),
      title: Text(
        "Edit info",
        style: Styles.headLine
            .copyWith(color: Styles.colorBlack, fontSize: 22, fontWeight: FontWeight.w700),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: GestureDetector(
            onTap: _updatePost,
            child: _isUpdate == true
                ? Center(child: Container(height: 30, width: 30, child: CircularProgressIndicator()))
                : Icon(
                    FontAwesomeIcons.check,
                    color: Colors.blue,
                  ),
          ),
        ),
      ],
    );
  }

  _updatePost() async {
    setState(() {
      _isUpdate = true;
    });
    if (_image == null) {
      _submitUpdatePost(image: widget.posts.postImageUrl!);
    } else {
      di
          .sl<UploadImageToStorageUseCase>()
          .call(_image!, true, "posts")
          .then((imageUrl) => _submitUpdatePost(image: imageUrl));
    }
  }

  _submitUpdatePost({required String image}) {
    BlocProvider.of<PostCubit>(context)
        .updatePost(
            post: PostEntity(
          creatorId: widget.posts.creatorId,
          postId: widget.posts.postId,
          postImageUrl: image,
          description: _descriptionController!.text,
              createdAt: Timestamp.now(),
        ))
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _descriptionController!.clear();
      _isUpdate = false;
      Navigator.pop(context);
    });
  }
}
