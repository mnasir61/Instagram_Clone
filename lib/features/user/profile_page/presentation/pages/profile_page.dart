import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/home_page/data/remote_data_sources/post_remote_data_source_impl.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/widgets/add_new_story.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/widgets/profile_menu_model_sheet_data_widget.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/widgets/profile_widget.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/widgets/story_widget.dart';

class ProfilePage extends StatefulWidget {
  final UserEntity currentUser;
  const ProfilePage({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // String truncatedText = "Story".length > 12 ? "Story".substring(0, 12) + "..." : "Story Text is here";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
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
                      child: profileWidget(
                       imageUrl: widget.currentUser.profileUrl),
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "${widget.currentUser.totalPosts}",
                            style: Styles.titleLine1.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.bold, fontSize: 19),
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
                            "${widget.currentUser.followers}",
                            style: Styles.titleLine1.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.bold, fontSize: 19),
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
                            "${widget.currentUser.followings}",
                            style: Styles.titleLine1.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.bold, fontSize: 19),
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
                "${widget.currentUser.fullName}",
                style: Styles.titleLine2.copyWith(color: Styles.colorBlack, fontWeight: FontWeight.bold),
              ),
              Text(
                "${widget.currentUser.currentUserProfession}",
                style: Styles.titleLine2.copyWith(color: Styles.colorGray1),
              ),
              // Text(
              //   "${widget.currentUser.currentUserBio}",
              //   style: Styles.titleLine2.copyWith(color: Styles.colorBlack),
              // ),
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
                  _singleProfileButtonWidget(context: context, text: "Edit Profile",onTap: (){
                    Navigator.pushNamed(context, PageConsts.editProfilePage,arguments: widget.currentUser);
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
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemCount: 12,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 45,
                    decoration: BoxDecoration(color: Colors.grey),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _singleProfileButtonWidget({required BuildContext context, String? text,VoidCallback? onTap}) {
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

  _appBarWidget() {
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
            onTap: (){
              _profileMenuModelSheet(context);
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

  void _profileMenuModelSheet(BuildContext context) {
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
          onTapToEditPost: () {
            Navigator.pushNamed(context, PageConsts.editPostPage);
          },
        );
      },
    );
  }
}
