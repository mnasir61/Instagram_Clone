import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/home_page/presentation/widgets/show_bottom_model_sheet_widgets_data/current_user_more_options_show_bottom_model_sheet_widget_data.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/home_page/presentation/widgets/show_bottom_model_sheet_widgets_data/more_options_show_bottom_model_sheet_widget_data.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/home_page/presentation/widgets/show_bottom_model_sheet_widgets_data/share_show_bottom_model_sheet_widget.dart';
import 'package:instagram_clone/features/post_page/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/widgets/profile_widget.dart';
import 'package:timeago/timeago.dart' as timeago;


class SinglePostWidget extends StatefulWidget {
  final PostEntity posts;

  const SinglePostWidget(
      {Key? key,
      required this.posts})
      : super(key: key);

  @override
  State<SinglePostWidget> createState() => _SinglePostWidgetState();
}

class _SinglePostWidgetState extends State<SinglePostWidget> {
  bool isExpanded = false;
  final int maxLines = 2;
  bool _isLike = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSize(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: profileWidget(imageUrl: "${widget.posts.userProfileUrl}"),
                        )
                      ),
                      horizontalSize(10),
                      Text(
                        "${widget.posts.username}",
                        style: Styles.titleLine2
                            .copyWith(color: Styles.colorBlack, fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      _currentUserMoreOptionsShowBottomModelSheet(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.transparent,
                      child: Icon(
                        FontAwesomeIcons.ellipsisVertical,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        verticalSize(15),
        Container(
          height: .25,
          width: MediaQuery.of(context).size.width,
          color: Styles.colorGray1.withOpacity(.5),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .35,
          // decoration: BoxDecoration(color: Colors.grey),
          child: profileWidget(imageUrl: "${widget.posts.postImageUrl}"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSize(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLike = !_isLike;
                          });
                        },
                        child: _isLike == true
                            ? Icon(Icons.favorite, color: Colors.red, size: 28)
                            : Icon(Icons.favorite_border, size: 28),
                      ),
                      horizontalSize(15),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, PageConsts.commentSectionPage);
                          },
                          child: Icon(FontAwesomeIcons.comment)),
                      horizontalSize(15),
                      GestureDetector(
                          onTap: () {
                            _shareShowBottomModelSheet(context);
                          },
                          child: Icon(FontAwesomeIcons.paperPlane)),
                    ],
                  ),
                  GestureDetector(onTap: () {}, child: Icon(FontAwesomeIcons.bookmark)),
                ],
              ),
              verticalSize(10),
              Text(
                "${widget.posts.totalLikes} Likes",
                style:
                    Styles.titleLine2.copyWith(color: Styles.colorBlack, fontWeight: FontWeight.w500),
              ),
              verticalSize(5),
              ExpandableText(
                "${widget.posts.description}",
                expandText: 'more',
                collapseText: "less",
                maxLines: 2,
                linkColor: Styles.colorBlack.withOpacity(.5),
                animation: true,
                collapseOnTextTap: true,
                prefixText: widget.posts.username,
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
              verticalSize(5),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PageConsts.commentSectionPage);
                },
                child: Text(
                  "View all ${widget.posts.totalComments} Comments",
                  style: Styles.titleLine2.copyWith(color: Styles.colorGray1),
                ),
              ),
              verticalSize(5),
              Text(
                "${timeago.format(widget.posts.createdAt!.toDate())}",
                style: Styles.titleLine2.copyWith(color: Styles.colorGray1),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _moreOptionShowBottomModelSheetWidget(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return MoreOptionsModelSheetData();
      },
    );
  }

  void _shareShowBottomModelSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return ShareShowBottomModelSheetWidgetData();
      },
    );
  }

  void _currentUserMoreOptionsShowBottomModelSheet(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return CurrentUserMoreOptionsModelSheetData(
          onTapToEditPost: () {
            Navigator.pushNamed(context, PageConsts.editPostPage,arguments: widget.posts);
          },
        );
      },
    );
  }
}
