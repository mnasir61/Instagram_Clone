import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/comment_page/presentation/comment_section_page.dart';
import 'package:instagram_clone/features/post_page/presentation/pages/post_page.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/pages/sign_in_page.dart';
import 'package:instagram_clone/features/user/presentation/pages/sign_up_page.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/screens/edit_profile_page.dart';

import 'features/app/main_page/presentation/pages/main_page.dart';
import 'features/home_page/presentation/pages/edit_post_page.dart';
import 'features/home_page/presentation/pages/notification_page/notification_page.dart';
import 'features/post_page/presentation/pages/upload_post_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConsts.signInPage:
        {
          return routeBuilder(child:SignInPage());
        }
      case PageConsts.signUpPage:
        {
          return routeBuilder(child:SignUpPage());
        }
      case PageConsts.mainPage:
        if (args is String) {
          return routeBuilder(child: MainPage(uid: args));
        } else {
          return routeBuilder(child: NoPageFound(),
          );
        }
      case PageConsts.commentSectionPage:
        {
          return routeBuilder(child:CommentSectionPage());
        }
      case PageConsts.notificationPage:
        {
          return routeBuilder(child:NotificationPage());
        }
      case PageConsts.editPostPage:
        {
          return routeBuilder(child:EditPostPage());
        }
      case PageConsts.editProfilePage:
        if(args is UserEntity){
          return routeBuilder(child:EditProfilePage(currentUser: args,));
        }else routeBuilder(child: NoPageFound());
      case PageConsts.uploadPostPage:
        if (args is Map<String, dynamic> && args.containsKey('selectedImagePath') && args.containsKey('currentUser')) {
          final selectedImagePath = args['selectedImagePath'] as String;
          final currentUser = args['currentUser'] as UserEntity;
          return routeBuilder(child:UploadPostPage( selectedImagePath: selectedImagePath,
            currentUser: currentUser,));
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
