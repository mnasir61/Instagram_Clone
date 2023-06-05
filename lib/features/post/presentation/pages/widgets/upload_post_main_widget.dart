import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/core/app_entity.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/features/user/domain/use_cases/upload_image_to_storage_usecase.dart';
import 'package:uuid/uuid.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

class UploadPostMainWidget extends StatefulWidget {
  final AppEntity appEntity;

  const UploadPostMainWidget({
    Key? key, required this.appEntity,

  }) : super(key: key);

  @override
  State<UploadPostMainWidget> createState() => _UploadPostMainWidgetState();
}

class _UploadPostMainWidgetState extends State<UploadPostMainWidget> {
  TextEditingController _descController = TextEditingController();
  bool _isUpdating = false;
  late File imageFile;

  @override
  void initState() {
    imageFile = File("${widget.appEntity.selectedImagePath}");
    super.initState();
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "New post",
          style: Styles.titleLine1.copyWith(color: Colors.black, fontSize: 20),
        ),
        elevation: 0,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(FontAwesomeIcons.arrowLeft, color: Colors.black, size: 20)),
        actions: [
          GestureDetector(
            onTap: _submitPost,
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: _isUpdating == true
                  ? Center(child: Container(height: 30, width: 30, child: CircularProgressIndicator()))
                  : Icon(FontAwesomeIcons.arrowRight, color: colorBlue, size: 20),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Image.file(imageFile),
            SizedBox(height: 10),
            TextFormField(
              controller: _descController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  hintText: "Add something..."),
            ),
          ],
        ),
      ),
    );
  }

  _submitPost() async {
    setState(() {
      _isUpdating = true;
    });

    final imageUrl = await di.sl<UploadImageToStorageUseCase>().call(imageFile, false, "posts");
    _createSubmitPost(image: imageUrl);
  }

  _createSubmitPost({required String image}) {
    final postCubit = BlocProvider.of<PostCubit>(context);
    final currentUser = widget.appEntity.currentUser;

    final post = PostEntity(
      description: _descController.text,
      createdAt: Timestamp.now(),
      creatorId: currentUser?.uid,
      likes: [],
      postId: Uuid().v1(),
      postImageUrl: image,
      totalComments: 0,
      totalLikes: 0,
      username: currentUser?.username,
      userProfileUrl: currentUser?.profileUrl,
    );

    postCubit.createPost(post: post).then((value) => _clear());
  }

  _clear() {
    setState(() {
      _isUpdating = false;
      _descController.clear();
      Navigator.pop(context);
    });
  }
}
