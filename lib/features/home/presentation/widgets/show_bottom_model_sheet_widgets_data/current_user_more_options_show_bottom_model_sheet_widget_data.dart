import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_entity/bookmark_entity.dart';
import 'package:instagram_clone/features/bookmark/presentation/bookmark_cubit/bookmark_cubit.dart';
import 'package:instagram_clone/features/global/divider_widget.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

class CurrentUserMoreOptionsModelSheetData extends StatefulWidget {
  final PostEntity posts;
  final BookmarkEntity bookmarks;
  final VoidCallback onTapToEditPost;
  final VoidCallback onTapToDeletePost;

  // final VoidCallback onTapBookmarkPost;

  const CurrentUserMoreOptionsModelSheetData(
      {Key? key,
      required this.onTapToEditPost,
      required this.onTapToDeletePost,
      required this.posts,
      required this.bookmarks})
      : super(key: key);

  @override
  State<CurrentUserMoreOptionsModelSheetData> createState() =>
      _CurrentUserMoreOptionsModelSheetDataState();
}

class _CurrentUserMoreOptionsModelSheetDataState extends State<CurrentUserMoreOptionsModelSheetData> {
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: _bookMarkPost,
                            child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 1, color: Styles.colorBlack)),
                                child: Icon(
                                  widget.posts.postId == widget.bookmarks.postId
                                      ? FontAwesomeIcons.solidBookmark
                                      : FontAwesomeIcons.bookmark,
                                  size: 28,
                                )),
                          ),
                          verticalSize(5),
                          Text(
                            "Save",
                            style: Styles.titleLine2.copyWith(color: Styles.colorBlack),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 1, color: Styles.colorBlack)),
                            child: Icon(
                              CupertinoIcons.qrcode_viewfinder,
                              size: 28,
                            ),
                          ),
                          verticalSize(5),
                          Text(
                            "QR code",
                            style: Styles.titleLine2.copyWith(color: Styles.colorBlack),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                verticalSize(30),
                DividerWidget(),
                verticalSize(20),
                Column(
                  children: [
                    _modelSheetButton(onTap: () {}, icon: CupertinoIcons.archivebox, text: "Archive"),
                    _modelSheetButton(
                        onTap: () {}, icon: CupertinoIcons.heart_slash, text: "Hide likes count"),
                    _modelSheetButton(
                        onTap: () {},
                        icon: FontAwesomeIcons.commentSlash,
                        text: "Turn off commenting"),
                    _modelSheetButton(
                        onTap: widget.onTapToEditPost,
                        icon: FluentIcons.edit_16_regular,
                        text: "Edit"),
                    _modelSheetButton(
                        onTap: () {}, icon: CupertinoIcons.pin, text: "Pin to your profile"),
                    _modelSheetButton(
                        onTap: () {}, icon: Icons.share_outlined, text: "Post to other apps..."),
                    _modelSheetButton(
                        onTap: widget.onTapToDeletePost,
                        icon: CupertinoIcons.delete_simple,
                        text: "Delete"),
                    // Row(
                    //   children: [
                    //     Icon(
                    //       CupertinoIcons.delete_simple,
                    //       color: Colors.red,
                    //     ),
                    //     horizontalSize(15),
                    //     Text(
                    //       "Delete",
                    //       style: Styles.titleLine2.copyWith(
                    //           color: Colors.red, fontWeight: FontWeight.w500, fontSize: 16),
                    //     ),
                    //   ],
                    // ),
                    verticalSize(25),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _modelSheetButton({VoidCallback? onTap, IconData? icon, String? text}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Icon(
              icon,
              color: "$text" == "Delete" ? Colors.red : Colors.black,
            ),
            horizontalSize(15),
            Text(
              "$text",
              style: Styles.titleLine2.copyWith(
                color: "$text" == "Delete" ? Colors.red : Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _bookMarkPost() {
    BlocProvider.of<BookmarkCubit>(context)
        .addBookmark(
            bookmark: BookmarkEntity(
          createdAt: Timestamp.now(),
          uid: _currentUid,
          postId: widget.posts.postId,
          postImageUrl: widget.posts.postImageUrl,
        ))
        .then((value) => Navigator.pop(context));
  }
}
