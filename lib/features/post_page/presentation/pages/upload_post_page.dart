import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';

class UploadPostPage extends StatelessWidget {
  final String selectedImagePath;
  final UserEntity currentUser;

  const UploadPostPage({
    Key? key,
    required this.selectedImagePath,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File imageFile = File(selectedImagePath);
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Selected Image Path:",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Image.file(imageFile),
          ],
        ),
      ),
    );
  }
}
