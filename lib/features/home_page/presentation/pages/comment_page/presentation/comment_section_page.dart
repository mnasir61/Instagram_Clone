import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/comment_page/presentation/widgets/author_desc_for_comment_widget.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/comment_page/presentation/widgets/comment_section_form_widget.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/comment_page/presentation/widgets/user_replay_to_comment_widget.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/comment_page/presentation/widgets/users_comments_widget.dart';

class CommentSectionPage extends StatefulWidget {
  const CommentSectionPage({Key? key}) : super(key: key);

  @override
  State<CommentSectionPage> createState() => _CommentSectionPageState();
}

class _CommentSectionPageState extends State<CommentSectionPage> {
  final TextEditingController _replyController = TextEditingController();
  final FocusNode _replyFocusNode = FocusNode();
  bool _showReplies = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      backgroundColor: Styles.colorWhite,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                AuthorDescriptionForCommentWidget(
                  profileImagePath: "assets/local/default_profile.png",
                  authorUsername: "John Doe",
                  time: "10h",
                  authorDescription:
                      "This implementation checks if the given text exceeds the maximum number of lines specified. If it does, it shows a collapsed version of the text with an ellipsis, and a More link. Tapping on the link expands the text to show the full content. If the text does not exceed the maximum lines, it is displayed as is without any expansion functionality.This implementation checks if the given text exceeds the maximum number of lines specified. If it does, it shows a collapsed version of the text with an ellipsis, and a More link. Tapping on the link expands the text to show the full content. If the text does not exceed the maximum lines, it is displayed as is without any expansion functionality.",
                ),
                Container(
                  height: .25,
                  width: MediaQuery.of(context).size.width,
                  color: Styles.colorGray1.withOpacity(.5),
                ),
                verticalSize(10),
                UserCommentWidget(
                    profileImagePath: "assets/local/default_profile.png",
                    username: "Another User",
                    time: "6h",
                    userDescription:
                        "This implementation checks if the given text exceeds the maximum number of lines specified. If it does, it shows a collapsed version of the text with an ellipsis, and a More link. Tapping on the link expands the text to show the full content. If the text does not exceed the maximum lines, it is displayed as is without any expansion functionality.",
                    onTapReplay: () {
                      _replyFocusNode.requestFocus();
                    }),
                Visibility(
                  visible: _showReplies,
                  maintainState: true,
                  child: Column(
                    children: [
                      verticalSize(20),
                      UserReplayToCommentWidget(
                        profileImagePath: "assets/local/default_profile.png",
                        username: "Another Rep User",
                        time: "3h",
                        userDescription:
                            "This implementation checks if the given text exceeds the maximum number of lines specified. If it does, it shows a collapsed version of the text with an ellipsis, and a More link.",
                        onTapReplay: () {
                          _replyFocusNode.requestFocus();
                        },
                      ),
                      verticalSize(20),
                    ],
                  ),
                ),
                verticalSize(15),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showReplies = !_showReplies;
                    });
                  },
                  child: Row(
                    children: [
                      horizontalSize(65),
                      Container(
                        height: .75,
                        width: 40,
                        color: Styles.colorWhiteMid,
                      ),
                      horizontalSize(10),
                      Text(
                        _showReplies ? "hide Replies" : "View 1 more replies",
                        style: Styles.titleLine2.copyWith(
                            color: Styles.colorBlack.withOpacity(.5), fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                verticalSize(10),
              ],
            ),
          ),
          CommentSectionFormWidget(
            controller: _replyController,
            focusNode: _replyFocusNode,
            userUrlPath: "assets/local/default_profile.png",
            hintText: "Add a comment for John Doe",
          ),
        ],
      ),
    );
  }

  _appBarWidget() {
    return AppBar(
      backgroundColor: Styles.colorWhite,
      elevation: 0,
      leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            FontAwesomeIcons.arrowLeft,
            color: Styles.colorBlack,
            size: 23,
          )),
      title: Text(
        "Comments",
        style: Styles.headLine
            .copyWith(color: Styles.colorBlack, fontSize: 22, fontWeight: FontWeight.w700),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: GestureDetector(
            onTap: () {
              //FIXME:
            },
            child: Icon(
              FontAwesomeIcons.paperPlane,
              color: Styles.colorBlack,
            ),
          ),
        ),
      ],
    );
  }
}
