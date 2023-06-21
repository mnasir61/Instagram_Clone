import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_entity/bookmark_entity.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_single_user_usecase.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/widgets/add_new_story.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/widgets/profile_menu_model_sheet_data_widget.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/widgets/profile_widget.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/widgets/story_widget.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

class ProfilePage extends StatefulWidget {
  final UserEntity currentUser;

  const ProfilePage({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    BlocProvider.of<PostCubit>(context).getPosts(post: PostEntity());
    super.initState();
  }
  ValueNotifier<BookmarkEntity> bookmarkNotifier = ValueNotifier<BookmarkEntity>(BookmarkEntity());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(bookmarkNotifier),
      backgroundColor: Styles.colorWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
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
                      child: profileWidget(imageUrl: widget.currentUser.profileUrl),
                    ),
                  ),
                  StreamBuilder<List<UserEntity>>(
                      stream: di.sl<GetSingleUserUseCase>().call(widget.currentUser.uid!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData == false) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.data!.isEmpty) {
                          return Container();
                        }
                        final singleUserData = snapshot.data!.first;
                        return Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "${widget.currentUser.totalPosts}",
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
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, PageConsts.followUnfollowSubPage,
                                    arguments: widget.currentUser);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "${singleUserData.totalFollowers}",
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
                            ),
                            horizontalSize(30),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, PageConsts.followUnfollowSubPage,
                                    arguments: widget.currentUser);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "${singleUserData.totalFollowings}",
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
                            ),
                            horizontalSize(15),
                          ],
                        );
                      }),
                ],
              ),
              verticalSize(10),
              Text(
                "${widget.currentUser.fullName!.isEmpty ? widget.currentUser.username : widget.currentUser.fullName}",
                style:
                    Styles.titleLine2.copyWith(color: Styles.colorBlack, fontWeight: FontWeight.bold),
              ),
              Text(
                "${widget.currentUser.currentUserProfession}",
                style: Styles.titleLine2.copyWith(color: Styles.colorGray1),
              ),
              SizedBox(height: 2),
              ExpandableText(
                "${widget.currentUser.currentUserBio}",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _singleProfileButtonWidget(
                      context: context,
                      text: "Edit Profile",
                      onTap: () {
                        Navigator.pushNamed(context, PageConsts.editProfilePage,
                            arguments: widget.currentUser);
                      }),
                  _singleProfileButtonWidget(context: context, text: "Share Profile"),
                  _singleProfileButtonWidget(context: context, text: "Contact"),
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
                        .where((post) => post.creatorId == widget.currentUser.uid)
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

  _singleProfileButtonWidget({required BuildContext context, String? text, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 33,
        width: MediaQuery.of(context).size.width * .3,
        decoration: BoxDecoration(
          color: Styles.colorWhiteMid.withOpacity(.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "$text",
            style: Styles.titleLine2
                .copyWith(color: Styles.colorBlack, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );
  }

  _appBarWidget(ValueNotifier<BookmarkEntity> bookmarkNotifier) {
    return AppBar(
      backgroundColor: Styles.colorWhite,
      elevation: 0,
      title: Text(
        "${widget.currentUser.username}",
        style: Styles.headLine.copyWith(color: Styles.colorBlack, fontWeight: FontWeight.bold),
      ),
      actions: [
        Icon(
          // FluentSystemIcons.ic_fluent_add_circle_regular,
          FontAwesomeIcons.squarePlus,
          color: Styles.colorBlack,
          // size: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 15),
          child: GestureDetector(
            onTap: () {
              _profileMenuModelSheet(context,bookmarkNotifier.value);
            },
            child: Icon(
              FontAwesomeIcons.bars,
              color: Styles.colorBlack,
              size: 22,
            ),
          ),
        )
      ],
    );
  }

  void _profileMenuModelSheet(BuildContext context,BookmarkEntity bookmark) {
    showModalBottomSheet(
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return ProfileMenuModelSheetDataWidget(
          bookmark: bookmarkNotifier.value,
          onTapToEditPost: () {
            Navigator.pushNamed(context, PageConsts.editPostPage);
          },
        );
      },
    );
  }
}
