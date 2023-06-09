import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/app/main_page/presentation/pages/main_page.dart';
import 'package:instagram_clone/features/comment/presentation/cubit/comment_cubit.dart';
import 'package:instagram_clone/features/post/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/features/post/presentation/cubit/read_single_post/read_single_post_cubit.dart';
import 'package:instagram_clone/features/reply/presentation/cubit/reply_cubit.dart';
import 'package:instagram_clone/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_clone/features/user/presentation/cubit/credentials/credential_cubit.dart';
import 'package:instagram_clone/features/user/presentation/cubit/get_other_single_user/get_other_single_user_cubit.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_users_cubit.dart';
import 'package:instagram_clone/features/user/presentation/pages/sign_in_page.dart';
import 'package:instagram_clone/on_generate_routes.dart';
import 'main_injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(InstagramClone());
}

class InstagramClone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<GetUsersCubit>(
          create: (context) => di.sl<GetUsersCubit>(),
        ),
        BlocProvider<GetSingleUserCubit>(
          create: (context) => di.sl<GetSingleUserCubit>(),
        ),
        BlocProvider<CredentialCubit>(
          create: (context) => di.sl<CredentialCubit>(),
        ),
        BlocProvider<PostCubit>(
          create: (context) => di.sl<PostCubit>(),
        ),
        BlocProvider<CommentCubit>(
          create: (context) => di.sl<CommentCubit>(),
        ),
        BlocProvider<ReadSinglePostCubit>(
          create: (context) => di.sl<ReadSinglePostCubit>(),
        ),
        BlocProvider<ReplyCubit>(
          create: (context) => di.sl<ReplyCubit>(),
        ),
        BlocProvider<GetOtherSingleUserCubit>(
          create: (context) => di.sl<GetOtherSingleUserCubit>(),
        ),
      ],
      child: _materialAppBuilder(),
    );
  }
}

Widget _materialAppBuilder() {
  return MaterialApp(
    title: 'Instagram Clone',
    debugShowCheckedModeBanner: false,
    onGenerateRoute: OnGenerateRoute.route,
    routes: {
      "/": (context) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            if (authState is Authenticated) {
              return MainPage(
                uid: authState.uid,
              );
            } else {
              return SignInPage();
            }
          },
        );
      },
    },
    // home: SignInPage(),
  );
}
