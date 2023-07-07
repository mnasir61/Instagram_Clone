import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/reels/presentation/widgets/comment_form_widget.dart';

class CommentsModelSheetWidget extends StatefulWidget {
  const CommentsModelSheetWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CommentsModelSheetWidget> createState() =>
      _CommentsModelSheetWidgetState();
}

class _CommentsModelSheetWidgetState extends State<CommentsModelSheetWidget> {
  TextEditingController _commentController = TextEditingController();
  bool _showReplies = false;
  bool _hasReplies = false;

  void toggleRepliesVisibility() {
    setState(() {
      _showReplies = !_showReplies;
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
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
                Column(
                  children: [
                    Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onLongPress: () {},
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage("assets/local/default_profile.png")
                                          )
                                        ),
                                      ),
                                      horizontalSize(10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${"username"}",
                                                style: Styles.titleLine2.copyWith(
                                                    color: Styles.colorBlack,
                                                    fontWeight: FontWeight.w800),
                                              ),
                                              horizontalSize(5),
                                              Text(
                                                "${"time"}",
                                                style: Styles.titleLine2.copyWith(
                                                    color: Styles.colorBlack
                                                        .withOpacity(.5),
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          verticalSize(5),
                                          Container(
                                            width:
                                            MediaQuery.of(context).size.width *
                                                .6,
                                            child: Text("${"description"}"),
                                          ),
                                          verticalSize(5),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Text(
                                              "Reply",
                                              style: Styles.titleLine2.copyWith(
                                                  color: Styles.colorBlack
                                                      .withOpacity(.5),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {},
                                            child: Icon(
                                              Icons.favorite_outline,
                                              color: Styles.colorBlack
                                                  .withOpacity(.5),
                                              size: 20,
                                            ),
                                          ),
                                          Text(
                                            "${"Likes"}",
                                            style: Styles.titleLine2.copyWith(
                                                color: Styles.colorBlack
                                                    .withOpacity(.5),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          child: ListView.builder(
                            physics: ScrollPhysics(),
                            itemCount: 2,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Visibility(
                                    visible: _showReplies,
                                    maintainState: true,
                                    child: InkWell(
                                      onLongPress: () {},
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 60.0, right: 14, top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image: AssetImage("assets/local/default_profile.png")
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                horizontalSize(10),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${"rep username"}",
                                                          style: Styles.titleLine2
                                                              .copyWith(
                                                            color: Styles.colorBlack,
                                                            fontWeight:
                                                            FontWeight.w800,
                                                          ),
                                                        ),
                                                        horizontalSize(5),
                                                        Text(
                                                          "${"rep time"}",
                                                          style: Styles.titleLine2
                                                              .copyWith(
                                                            color: Styles.colorBlack
                                                                .withOpacity(.5),
                                                            fontWeight:
                                                            FontWeight.w500,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    verticalSize(5),
                                                    Container(
                                                      width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          .6,
                                                      child: Text(
                                                          "${"rep description"}"),
                                                    ),
                                                    verticalSize(5),
                                                    GestureDetector(
                                                      child: Text(
                                                        "Reply",
                                                        style: Styles.titleLine2
                                                            .copyWith(
                                                          color: Styles.colorBlack
                                                              .withOpacity(.5),
                                                          fontWeight:
                                                          FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    verticalSize(10),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: Styles.colorBlack
                                                        .withOpacity(.5),
                                                    size: 20,
                                                  ),
                                                ),
                                                Text(
                                                  "${"likes"}",
                                                  style: Styles.titleLine2.copyWith(
                                                    color: Styles.colorBlack
                                                        .withOpacity(.5),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        if (_hasReplies)
                          GestureDetector(
                            onTap: () {
                              toggleRepliesVisibility();
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
                                  _showReplies ? "Hide Replies" : "View more reply",
                                  style: Styles.titleLine2.copyWith(
                                      color: Styles.colorBlack.withOpacity(.5),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        if (!_hasReplies) SizedBox(height: 0, width: 0),
                        verticalSize(10),
                      ],
                    ),
                  ],
                ),
                CommentFormWidget(
                  isHintText: false,
                  controller: _commentController,
                  onFieldSubmit: (value) {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
