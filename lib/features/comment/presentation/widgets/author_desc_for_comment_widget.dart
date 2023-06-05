

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class AuthorDescriptionForCommentWidget extends StatefulWidget {
  final PostEntity post;

  const AuthorDescriptionForCommentWidget({Key? key, required this.post}) : super(key: key);

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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: profileWidget(imageUrl: "${widget.post.userProfileUrl}"),
                )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      horizontalSize(10),
                      Text(
                        "${widget.post.username}",
                        style: Styles.titleLine2.copyWith(
                            color: Styles.colorBlack, fontWeight: FontWeight.w800),
                      ),
                      horizontalSize(5),
                      Text(
                        "${timeago.format(widget.post.createdAt!.toDate())}",
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
                          "${widget.post.description}",
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
