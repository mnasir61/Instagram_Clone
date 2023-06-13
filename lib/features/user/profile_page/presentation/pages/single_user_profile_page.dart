import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/post/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/features/user/presentation/cubit/get_other_single_user/get_other_single_user_cubit.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/widgets/single_user_profile_main_widget.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

class SingleUserProfilePage extends StatelessWidget {
  final String otherUserUid;

  const SingleUserProfilePage({Key? key, required this.otherUserUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<PostCubit>(
        create: (context) => di.sl<PostCubit>(),
      ),
    ], child: SingleUserProfileMainWidgetPage(otherUserUid: otherUserUid));
  }
}
