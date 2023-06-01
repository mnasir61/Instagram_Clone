import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/divider_widget.dart';
import 'package:instagram_clone/features/global/styles/style.dart';

class CurrentUserMoreOptionsModelSheetData extends StatefulWidget {
  final VoidCallback onTapToEditPost;
  const CurrentUserMoreOptionsModelSheetData({Key? key, required this.onTapToEditPost}) : super(key: key);

  @override
  State<CurrentUserMoreOptionsModelSheetData> createState() => _CurrentUserMoreOptionsModelSheetDataState();
}

class _CurrentUserMoreOptionsModelSheetDataState extends State<CurrentUserMoreOptionsModelSheetData> {
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
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 1, color: Styles.colorBlack)),
                            child: Icon(
                              FontAwesomeIcons.bookmark,
                              size: 28,
                            ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(CupertinoIcons.archivebox),
                          horizontalSize(15),
                          Text(
                            "Archive",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                      Row(
                        children: [
                          Icon(CupertinoIcons.heart_slash),
                          horizontalSize(15),
                          Text(
                            "Hide like count",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.commentSlash),
                          horizontalSize(15),
                          Text(
                            "Turn off commenting",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                      GestureDetector(
                        onTap: widget.onTapToEditPost,
                        child: Row(
                          children: [
                            Icon(FluentIcons.edit_16_regular),
                            horizontalSize(15),
                            Text(
                              "Edit",
                              style: Styles.titleLine2.copyWith(
                                  color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      verticalSize(25),
                      Row(
                        children: [
                          Icon(CupertinoIcons.pin),
                          horizontalSize(15),
                          Text(
                            "Pin to your profile",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                      Row(
                        children: [
                          Icon(
                            Icons.share_outlined,
                          ),
                          horizontalSize(15),
                          Text(
                            "Post to other apps...",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.delete_simple,
                            color: Colors.red,
                          ),
                          horizontalSize(15),
                          Text(
                            "Delete",
                            style: Styles.titleLine2.copyWith(
                                color: Colors.red, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
