

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/styles/style.dart';

class AuthorDescriptionForCommentWidget extends StatefulWidget {
  final String? profileImagePath;
  final String? authorUsername;
  final String? time;
  final String? authorDescription;
  const AuthorDescriptionForCommentWidget({Key? key, this.profileImagePath, this.authorUsername, this.time, this.authorDescription}) : super(key: key);

  @override
  State<AuthorDescriptionForCommentWidget> createState() => _AuthorDescriptionForCommentWidgetState();
}

class _AuthorDescriptionForCommentWidgetState extends State<AuthorDescriptionForCommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        "${widget.authorUsername}",
                        style: Styles.titleLine2.copyWith(
                            color: Styles.colorBlack, fontWeight: FontWeight.w800),
                      ),
                      horizontalSize(5),
                      Text(
                        "${widget.time}",
                        style: Styles.titleLine2.copyWith(
                            color: Styles.colorBlack.withOpacity(.5),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  verticalSize(7),
                  Row(
                    children: [
                      horizontalSize(10),
                      Container(
                        width: MediaQuery.of(context).size.width * .7,
                        // height: MediaQuery.of(context).size.height,
                        child: ExpandableText(
                          "${widget.authorDescription}",
                          maxLines: 10,
                          expandText: "more",
                          collapseText: "less",
                          animation: true,
                          collapseOnTextTap: true,
                          linkColor: Styles.colorBlack.withOpacity(.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          verticalSize(10),
        ],
      ),
    );
  }
}
