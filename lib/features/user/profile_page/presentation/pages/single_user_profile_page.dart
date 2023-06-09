import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_other_single_user_usecase.dart';
import 'package:instagram_clone/features/user/presentation/cubit/get_other_single_user/get_other_single_user_cubit.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_users_cubit.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/widgets/add_new_story.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/widgets/story_widget.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

class SingleUserProfilePage extends StatefulWidget {
  final String otherUserUid;

  const SingleUserProfilePage({Key? key, required this.otherUserUid}) : super(key: key);

  @override
  State<SingleUserProfilePage> createState() => _SingleUserProfilePage();
}

class _SingleUserProfilePage extends State<SingleUserProfilePage> {
  String _currentUid = "";

  @override
  void initState() {
    // BlocProvider.of<GetOtherSingleUserCubit>(context)
    //     .getOtherSingleUser(otherUid: widget.otherUserUid);
    BlocProvider.of<PostCubit>(context).getPosts(post: PostEntity());
    BlocProvider.of<GetOtherSingleUserCubit>(context)
        .getOtherSingleUser(otherUid: widget.otherUserUid);
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserEntity>>(
        stream: di.sl<GetOtherSingleUserUseCase>().call(widget.otherUserUid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final otherSingleUserData = snapshot.data?.first;
            return Scaffold(
              appBar: _appBarWidget(otherSingleUserData: otherSingleUserData!),
              backgroundColor: Styles.colorWhite,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSize(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: profileWidget(imageUrl: otherSingleUserData.profileUrl),
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "${otherSingleUserData.totalPosts}",
                                    style: Styles.titleLine1.copyWith(
                                        color: Styles.colorBlack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                  verticalSize(2),
                                  Text(
                                    "Posts",
                                    style: Styles.titleLine2.copyWith(
                                        color: Styles.colorBlack.withOpacity(.9),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              horizontalSize(30),
                              Column(
                                children: [
                                  Text(
                                    "${otherSingleUserData.totalFollowers}",
                                    style: Styles.titleLine1.copyWith(
                                        color: Styles.colorBlack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                  verticalSize(2),
                                  Text(
                                    "Followers",
                                    style: Styles.titleLine2.copyWith(
                                        color: Styles.colorBlack.withOpacity(.9),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              horizontalSize(30),
                              Column(
                                children: [
                                  Text(
                                    "${otherSingleUserData.totalFollowings}",
                                    style: Styles.titleLine1.copyWith(
                                        color: Styles.colorBlack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                  verticalSize(2),
                                  Text(
                                    "Following",
                                    style: Styles.titleLine2.copyWith(
                                        color: Styles.colorBlack.withOpacity(.9),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              horizontalSize(15),
                            ],
                          ),
                        ],
                      ),
                      verticalSize(10),
                      Text(
                        "${otherSingleUserData.fullName == "" ? otherSingleUserData.username : otherSingleUserData.fullName}",
                        style: Styles.titleLine2
                            .copyWith(color: Styles.colorBlack, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${otherSingleUserData.currentUserProfession}",
                        style: Styles.titleLine2.copyWith(color: Styles.colorGray1),
                      ),
                      // Text(
                      //   "${widget.currentUser.currentUserBio}",
                      //   style: Styles.titleLine2.copyWith(color: Styles.colorBlack),
                      // ),
                      SizedBox(height: 2),
                      ExpandableText(
                        "${otherSingleUserData.currentUserBio}",
                        expandText: 'more',
                        collapseText: "less",
                        maxLines: 4,
                        linkColor: Styles.colorBlack.withOpacity(.5),
                        animation: true,
                        collapseOnTextTap: true,
                        // prefixText: widget.usernameText,
                        // onPrefixTap: () => showProfile(widget.usernameText),
                        prefixStyle: TextStyle(fontWeight: FontWeight.bold),
                        // onHashtagTap: (name) => showHashtag(name),
                        hashtagStyle: TextStyle(
                          color: Color(0xFF066A9E),
                        ),
                        // onMentionTap: (username) => showProfile(username),
                        mentionStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                        // onUrlTap: (url) => launchUrl(url),
                        urlStyle: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      verticalSize(10),
                      otherSingleUserData.uid == _currentUid
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _singleProfileButtonWidget(
                                    context: context,
                                    textColor: Styles.colorBlack,
                                    backgroundColor: Styles.colorWhiteMid.withOpacity(.3),
                                    buttonsPerRow: 3,
                                    text: "Edit Profile",
                                    onTap: () {
                                      Navigator.pushNamed(context, PageConsts.editProfilePage,
                                          arguments: otherSingleUserData);
                                    }),
                                _singleProfileButtonWidget(
                                    textColor: Styles.colorBlack,
                                    backgroundColor: Styles.colorWhiteMid.withOpacity(.3),
                                    buttonsPerRow: 3,
                                    context: context,
                                    text: "Share Profile"),
                                _singleProfileButtonWidget(
                                    textColor: Styles.colorBlack,
                                    backgroundColor: Styles.colorWhiteMid.withOpacity(.3),
                                    buttonsPerRow: 3,
                                    context: context,
                                    text: "Contact"),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _singleProfileButtonWidget(
                                    textColor: otherSingleUserData.followers!.contains(_currentUid)
                                        ? Colors.black
                                        : Colors.white,
                                    backgroundColor:
                                        otherSingleUserData.followers!.contains(_currentUid)
                                            ? Styles.colorWhiteMid.withOpacity(.3)
                                            : colorBlue,
                                    context: context,
                                    buttonsPerRow: 2,
                                    text: otherSingleUserData.followers!.contains(_currentUid)
                                        ? "Following..."
                                        : "Follow",
                                    onTap: () {
                                      BlocProvider.of<GetUsersCubit>(context).followUnfollow(
                                          user: UserEntity(
                                              uid: _currentUid, otherUid: widget.otherUserUid));
                                    }),
                                _singleProfileButtonWidget(
                                    textColor: Styles.colorBlack,
                                    backgroundColor: Styles.colorWhiteMid.withOpacity(.3),
                                    buttonsPerRow: 2,
                                    context: context,
                                    text: "Message"),
                              ],
                            ),
                      verticalSize(25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          StoryWidget(imageUrl: "assets/local/default_profile.png", username: "Nasir"),
                          horizontalSize(20),
                          AddNewStory(),
                        ],
                      ),
                      verticalSize(25),

                      verticalSize(15),
                      BlocBuilder<PostCubit, PostState>(
                        builder: (context, postState) {
                          if (postState is PostLoaded) {
                            final posts = postState.posts
                                .where((post) => post.creatorId == widget.otherUserUid)
                                .toList();
                            return GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
                              itemCount: posts.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, PageConsts.postDetailPage,
                                        arguments: posts[index].postId);
                                  },
                                  child: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width * 45,
                                    child: profileWidget(imageUrl: posts[index].postImageUrl),
                                  ),
                                );
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  _singleProfileButtonWidget({
    required BuildContext context,
    String? text,
    VoidCallback? onTap,
    int buttonsPerRow = 0,
    Color? backgroundColor,
    Color? textColor,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth / buttonsPerRow * 0.9;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 33,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "$text",
            style: Styles.titleLine2.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  _appBarWidget({required UserEntity otherSingleUserData}) {
    return AppBar(
      backgroundColor: Styles.colorWhite,
      elevation: 0,
      leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          )),
      title: Text(
        "${otherSingleUserData.username}",
        style: Styles.headLine.copyWith(color: Styles.colorBlack, fontWeight: FontWeight.bold),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 15),
          child: Icon(
            // FluentSystemIcons.ic_fluent_add_circle_regular,
            FontAwesomeIcons.bell,
            color: Styles.colorBlack,
            // size: 25,
          ),
        ),
      ],
    );
  }

// void _profileMenuModelSheet(BuildContext context, UserEntity currentUser) {
//   showModalBottomSheet(
//     useSafeArea: true,
//     showDragHandle: true,
//     isScrollControlled: true,
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//     ),
//     builder: (BuildContext context) {
//       return ProfileMenuModelSheetDataWidget(
//
//         onTapToEditPost: () {
//           Navigator.pushNamed(context, PageConsts.editPostPage, arguments: currentUser);
//         },
//       );
//     },
//   );
// }
}
