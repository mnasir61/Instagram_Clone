

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/styles/style.dart';

class UserReplayToCommentWidget extends StatefulWidget {
  final VoidCallback? onTapReplay;
  final String? profileImagePath;
  final String? username;
  final String? time;
  final String? userDescription;
  const UserReplayToCommentWidget({Key? key, this.onTapReplay, this.profileImagePath, this.username, this.time, this.userDescription}) : super(key: key);

  @override
  State<UserReplayToCommentWidget> createState() => _UserReplayToCommentWidgetState();
}

class _UserReplayToCommentWidgetState extends State<UserReplayToCommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        horizontalSize(48),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset("${widget.profileImagePath}"),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          horizontalSize(10),
                          Text(
                            "${widget.username}",
                            style: Styles.titleLine2
                                .copyWith(color: Styles.colorBlack, fontWeight: FontWeight.w800),
                          ),
                          horizontalSize(5),
                          Text(
                            "${widget.time}",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack.withOpacity(.5), fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      verticalSize(7),
                      Row(
                        children: [
                          horizontalSize(10),
                          Container(
                            width: MediaQuery.of(context).size.width * .6,
                            // height: MediaQuery.of(context).size.height,
                            child: Text(
                              "${widget.userDescription}"
                            ),
                          ),
                          horizontalSize(10),
                        ],
                      ),
                      verticalSize(7),
                      Row(
                        children: [
                          horizontalSize(9),
                          GestureDetector(
                            onTap: widget.onTapReplay,
                            child: Text(
                              "Replay",
                              style: Styles.titleLine2.copyWith(
                                  color: Styles.colorBlack.withOpacity(.5),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(FontAwesomeIcons.heart, color: Styles.colorBlack.withOpacity(.5), size: 18),
                      Text(
                        "12",
                        style: Styles.titleLine2.copyWith(
                            color: Styles.colorBlack.withOpacity(.5),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
