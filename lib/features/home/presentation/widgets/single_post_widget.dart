import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/core/app_entity.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/features/post/presentation/pages/widgets/like_animation_widget.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/widgets/profile_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:instagram_clone/main_injection_container.dart' as di;

import 'show_bottom_model_sheet_widgets_data/current_user_more_options_show_bottom_model_sheet_widget_data.dart';
import 'show_bottom_model_sheet_widgets_data/more_options_show_bottom_model_sheet_widget_data.dart';
import 'show_bottom_model_sheet_widgets_data/share_show_bottom_model_sheet_widget.dart';

class SinglePostWidget extends StatefulWidget {
  final PostEntity posts;

  const SinglePostWidget({Key? key, required this.posts}) : super(key: key);

  @override
  State<SinglePostWidget> createState() => _SinglePostWidgetState();
}

class _SinglePostWidgetState extends State<SinglePostWidget> {
  bool isExpanded = false;
  final int maxLines = 2;
  bool _isLike = false;

  bool _isLikeAnimating = false;
  String _currentUid = "";

  @override
  void initState() {
    super.initState();
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
  }

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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PageConsts.singleUserProfilePage,arguments: widget.posts.creatorId);
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: profileWidget(
                              imageUrl: "${widget.posts.userProfileUrl}",
                            ),
                          ),
                        ),
                        horizontalSize(10),
                        Text(
                          "${widget.posts.username}",
                          style: Styles.titleLine2.copyWith(
                            color: Styles.colorBlack,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.posts.creatorId==_currentUid? _currentUserMoreOptionsShowBottomModelSheet(context):_moreOptionShowBottomModelSheetWidget(
                          context);
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
        GestureDetector(
          onDoubleTap: () {
            _likePost();
            setState(() {
              _isLikeAnimating = true;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .35,
                child: profileWidget(
                  imageUrl: "${widget.posts.postImageUrl}",
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: _isLikeAnimating ? 1 : 0,
                child: LikeAnimationWidget(
                  duration: Duration(milliseconds: 300),
                  isLikeAnimation: _isLikeAnimating,
                  onLikeFinish: () {
                    setState(() {
                      _isLikeAnimating = false;
                    });
                  },
                  child: Icon(
                    Icons.favorite,
                    size: 75,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
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
                        onTap: _likePost,
                        child: Icon(
                          widget.posts.likes?.contains(_currentUid) == true
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: widget.posts.likes?.contains(_currentUid) == true
                              ? Colors.red
                              : Styles.colorBlack,
                          size: 28,
                        ),
                      ),
                      horizontalSize(15),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            PageConsts.commentSectionPage,
                            arguments: AppEntity(uid: _currentUid, postId: widget.posts.postId),
                          );
                        },
                        child: Icon(FontAwesomeIcons.comment),
                      ),
                      horizontalSize(15),
                      GestureDetector(
                        onTap: () {
                        _shareShowBottomModelSheet(context);
                        },
                        child: Icon(FontAwesomeIcons.paperPlane),
                      ),
                    ],
                  ),
                  GestureDetector(onTap: () {}, child: Icon(FontAwesomeIcons.bookmark)),
                ],
              ),
              verticalSize(10),
              Text(
                "${widget.posts.totalLikes} Likes",
                style: Styles.titleLine2.copyWith(
                  color: Styles.colorBlack,
                  fontWeight: FontWeight.w500,
                ),
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
                prefixStyle: TextStyle(fontWeight: FontWeight.bold),
                hashtagStyle: TextStyle(
                  color: Color(0xFF066A9E),
                ),
                mentionStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                urlStyle: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              verticalSize(5),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PageConsts.commentSectionPage,
                    arguments: AppEntity(uid: _currentUid, postId: widget.posts.postId),
                  );
                },
                child: Text(
                  "View all ${widget.posts.totalComments} Comments",
                  style: Styles.titleLine2.copyWith(color: Styles.colorGray1),
                ),
              ),
              verticalSize(5),
              Text(
                "${timeago.format(widget.posts.createdAt?.toDate() ?? DateTime.now())}",
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
            Navigator.pushNamed(context, PageConsts.editPostPage, arguments: widget.posts)
                .then((value) {
              Future.delayed(Duration(milliseconds: 300));
              Navigator.pop(context);
            });
          },
          onTapToDeletePost: _deletePost,
        );
      },
    );
  }

  _deletePost() {
    BlocProvider.of<PostCubit>(context)
        .deletePost(
            post: PostEntity(
          postId: widget.posts.postId,
        ))
        .then((value) => Navigator.pop(context));
  }

  _likePost() {
    BlocProvider.of<PostCubit>(context).likePost(
        post: PostEntity(
      postId: widget.posts.postId,
    ));
  }
}
