

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/app_entity.dart';
import 'package:instagram_clone/features/post/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/features/post/presentation/pages/widgets/upload_post_main_widget.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;
class UploadPost extends StatelessWidget {
  final String selectedImagePath;
  final UserEntity currentUser;
  const UploadPost({Key? key, required this.selectedImagePath, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCubit>(
      create: (context)=>di.sl<PostCubit>(),
        child: UploadPostMainWidget(appEntity: AppEntity(currentUser: currentUser,selectedImagePath: selectedImagePath)));
  }
}
