import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/home_page/presentation/widgets/show_bottom_model_sheet_widgets_data/current_user_more_options_show_bottom_model_sheet_widget_data.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/home_page/presentation/widgets/show_bottom_model_sheet_widgets_data/more_options_show_bottom_model_sheet_widget_data.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/home_page/presentation/widgets/show_bottom_model_sheet_widgets_data/share_show_bottom_model_sheet_widget.dart';

class SinglePostWidget extends StatefulWidget {
  final String? userImagePath;
  final String? usernameText;
  final String? imagePostPath;
  final String? totalLikesText;
  final String? descriptionText;
  final String? totalCommentsText;

  const SinglePostWidget(
      {Key? key,
      this.userImagePath,
      this.usernameText,
      this.imagePostPath,
      this.totalLikesText,
      this.descriptionText,
      this.totalCommentsText})
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
        verticalSize(5),
        Container(
          height: .25,
          width: MediaQuery.of(context).size.width,
          color: Styles.colorGray1.withOpacity(.5),
        ),
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
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset("${widget.userImagePath}"),
                      ),
                      horizontalSize(10),
                      Text(
                        "${widget.usernameText}",
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
          child: Image.asset("${widget.imagePostPath}", fit: BoxFit.cover),
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
                        child: _isLike==true?Icon(Icons.favorite,color: Colors.red,size: 28):Icon(Icons.favorite_border,size: 28),
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
                "${widget.totalLikesText}",
                style:
                    Styles.titleLine2.copyWith(color: Styles.colorBlack, fontWeight: FontWeight.w500),
              ),
              verticalSize(5),
              ExpandableText(
                "${widget.descriptionText}",
                expandText: 'more',
                collapseText: "less",
                maxLines: 2,
                linkColor: Styles.colorBlack.withOpacity(.5),
                animation: true,
                collapseOnTextTap: true,
                prefixText: widget.usernameText,
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
                  "${widget.totalCommentsText}",
                  style: Styles.titleLine2.copyWith(color: Styles.colorGray1),
                ),
              ),
              verticalSize(5),
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
            Navigator.pushNamed(context, PageConsts.editPostPage);
          },
        );
      },
    );
  }
}
