import 'package:flutter/material.dart';
import 'package:instagram_clone/core/app_entity.dart';
import 'package:instagram_clone/features/comment/presentation/comment_section_page.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/home/presentation/home_page.dart';
import 'package:instagram_clone/features/notification/notification_page.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/pages/edit_post_page.dart';
import 'package:instagram_clone/features/post/presentation/pages/widgets/upload_post_main_widget.dart';
import 'package:instagram_clone/features/search/presentation/pages/post_detail_page.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/pages/sign_in_page.dart';
import 'package:instagram_clone/features/user/presentation/pages/sign_up_page.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/screens/edit_profile_page.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/single_user_profile_page.dart';

import 'features/app/main_page/presentation/pages/main_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConsts.signInPage:
        {
          return routeBuilder(child: SignInPage());
        }
      case PageConsts.signUpPage:
        {
          return routeBuilder(child: SignUpPage());
        }
      case PageConsts.mainPage:
        if (args is String) {
          return routeBuilder(child: MainPage(uid: args));
        } else {
          return routeBuilder(
            child: NoPageFound(),
          );
        }
      case PageConsts.commentSectionPage:
        if (args is AppEntity) {
          return routeBuilder(child: CommentSectionPage(appEntity: args,));
        } else
          return routeBuilder(child: NoPageFound());
      case PageConsts.notificationPage:
        {
          return routeBuilder(child: NotificationPage());
        }
      case PageConsts.editPostPage:
        if (args is PostEntity) {
          return routeBuilder(
              child: EditPostPage(
            posts: args,
          ));
        } else
          routeBuilder(child: NoPageFound());
      case PageConsts.editProfilePage:
        if (args is UserEntity) {
          return routeBuilder(
              child: EditProfilePage(
            currentUser: args,
          ));
        } else
          routeBuilder(child: NoPageFound());
      case PageConsts.uploadPostPage:
        if (args is AppEntity) {
          return routeBuilder(
              child: UploadPostMainWidget(appEntity: args,
          ));
        } else
          routeBuilder(child: NoPageFound());
      case PageConsts.postDetailPage:
        if(args is String){
          return routeBuilder(child: PostDetailPage(postId: args,));
        }else routeBuilder(child: NoPageFound());
      case PageConsts.singleUserProfilePage:
        if(args is String){
          return routeBuilder(child: SingleUserProfilePage(otherUserUid: args,));
        }else routeBuilder(child: NoPageFound());
      default:
        {
          NoPageFound();
        }
    }
    return null;
  }
}

dynamic routeBuilder({required Widget child}) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page not found"),
      ),
      body: Center(
        child: Text("Page not found"),
      ),
    );
  }
}
