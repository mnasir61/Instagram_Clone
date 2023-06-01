import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/divider_widget.dart';
import 'package:instagram_clone/features/global/styles/style.dart';

class MoreOptionsModelSheetData extends StatelessWidget {
  const MoreOptionsModelSheetData({Key? key}) : super(key: key);

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
                          Icon(FontAwesomeIcons.star),
                          horizontalSize(15),
                          Text(
                            "Add to favorites",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                      Row(
                        children: [
                          Icon(CupertinoIcons.person_badge_minus),
                          horizontalSize(15),
                          Text(
                            "Unfollow",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                      Row(
                        children: [
                          Icon(CupertinoIcons.info),
                          horizontalSize(15),
                          Text(
                            "Why you're seeing this post",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                      Row(
                        children: [
                          Icon(CupertinoIcons.eye_slash),
                          horizontalSize(15),
                          Text(
                            "Hide",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                      Row(
                        children: [
                          Icon(CupertinoIcons.person_alt_circle),
                          horizontalSize(15),
                          Text(
                            "About this account",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                      verticalSize(25),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.exclamationmark_bubble,
                            color: Colors.red,
                          ),
                          horizontalSize(15),
                          Text(
                            "Report",
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
