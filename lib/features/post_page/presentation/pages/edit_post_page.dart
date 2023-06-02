import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/post_page/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post_page/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/features/post_page/presentation/pages/widgets/edit_post_main_widget.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

class EditPostPage extends StatelessWidget {
  final PostEntity posts;

  const EditPostPage({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCubit>(
      create: (context) => di.sl<PostCubit>(),
      child: EditPostMainWidget(
        posts: posts,
      ),
    );
  }
}
