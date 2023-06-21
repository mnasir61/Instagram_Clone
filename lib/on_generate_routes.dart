import 'package:flutter/material.dart';
import 'package:instagram_clone/core/app_entity.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_entity/bookmark_entity.dart';
import 'package:instagram_clone/features/chat/presentation/pages/chat_main_page.dart';
import 'package:instagram_clone/features/chat/presentation/pages/new_chat_page.dart';
import 'package:instagram_clone/features/chat/presentation/pages/request_chat_page.dart';
import 'package:instagram_clone/features/chat/presentation/pages/single_chat_page.dart';
import 'package:instagram_clone/features/comment/presentation/comment_section_page.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/notification/notification_page.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/pages/edit_post_page.dart';
import 'package:instagram_clone/features/post/presentation/pages/widgets/upload_post_main_widget.dart';
import 'package:instagram_clone/features/search/presentation/pages/post_detail_page.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/pages/forget_password_page.dart';
import 'package:instagram_clone/features/user/presentation/pages/sign_in_page.dart';
import 'package:instagram_clone/features/user/presentation/pages/sign_up_page.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/follow_unfollow_main_page.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/screens/bookamrk_posts_page.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/screens/edit_profile_page.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/screens/followers_page.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/screens/followings_page.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/single_user_profile_page.dart';

import 'features/app/main_page/presentation/pages/main_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      //Auth Routes ------------------------------------------------------------------
      case PageConsts.signInPage:
        {
          return routeBuilder(child: SignInPage());
        }
      case PageConsts.signUpPage:
        {
          return routeBuilder(child: SignUpPage());
        }
      case PageConsts.forgetPasswordPage:
        {
          return routeBuilder(child: ForgetPasswordPage());
        }
      //mainPage ------------------------------------------------------------------
      case PageConsts.mainPage:
        if (args is String) {
          return routeBuilder(child: MainPage(uid: args));
        } else {
          return routeBuilder(
            child: NoPageFound(),
          );
        }

      //Comment Routes ----------------------------------------------------------------
      case PageConsts.commentSectionPage:
        if (args is AppEntity) {
          return routeBuilder(
              child: CommentSectionPage(
            appEntity: args,
          ));
        } else
          return routeBuilder(child: NoPageFound());
      //Post Routes --------------------------------------------------------------------
      case PageConsts.editPostPage:
        if (args is PostEntity) {
          return routeBuilder(
              child: EditPostPage(
            posts: args,
          ));
        } else
          routeBuilder(child: NoPageFound());

      case PageConsts.uploadPostPage:
        if (args is AppEntity) {
          return routeBuilder(
              child: UploadPostMainWidget(
            appEntity: args,
          ));
        } else
          routeBuilder(child: NoPageFound());
      case PageConsts.postDetailPage:
        if (args is String) {
          return routeBuilder(
              child: PostDetailPage(
            postId: args,
          ));
        } else
          routeBuilder(child: NoPageFound());
      case PageConsts.singleUserProfilePage:
        if (args is String) {
          return routeBuilder(
              child: SingleUserProfilePage(
            otherUserUid: args,
          ));
        } else
          routeBuilder(child: NoPageFound());

      case PageConsts.followersPage:
        if (args is UserEntity) {
          return routeBuilder(child: FollowersPage(user: args));
        } else
          return routeBuilder(child: NoPageFound());
      case PageConsts.followingsPage:
        if (args is UserEntity) {
          return routeBuilder(child: FollowingsPage(user: args));
        } else
          return routeBuilder(child: NoPageFound());
      case PageConsts.followUnfollowSubPage:
        if (args is UserEntity) {
          return routeBuilder(child: FollowUnfollowMainPage(user: args));
        } else
          return routeBuilder(child: NoPageFound());

      //Profile Routes ---------------------------------------------------------------
      case PageConsts.editProfilePage:
        if (args is UserEntity) {
          return routeBuilder(
              child: EditProfilePage(
            currentUser: args,
          ));
        } else
          routeBuilder(child: NoPageFound());
      //Notification Routes ----------------------------------------------------------
      case PageConsts.notificationPage:
        {
          return routeBuilder(child: NotificationPage());
        }

      //Bookmark Routes --------------------------------------------------------------
      case PageConsts.bookMarkPostsPage:
        if (args is BookmarkEntity) {
          return routeBuilder(
              child: BookmarkPostsPage(
            bookmark: args,
          ));
        } else
          return routeBuilder(child: NoPageFound());

      //Chat Routes ------------------------------------------------------------------
      case PageConsts.chatMainPage:
        {
          return routeBuilder(child: ChatMainPage());
        }
      case PageConsts.requestChatPage:
        {
          return routeBuilder(child: RequestChatPage());
        }
      case PageConsts.singleChatPage:
        {
          return routeBuilder(child: SingleChatPage());
        }
      case PageConsts.newChatPage:
        {
          return routeBuilder(child: NewChatPage());
        }
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
