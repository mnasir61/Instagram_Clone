import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/error_message.dart';
import 'package:instagram_clone/features/comment/domain/entity/comment_entity.dart';
import 'package:instagram_clone/features/comment/presentation/cubit/comment_cubit.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/reply/domain/entities/reply_entity.dart';
import 'package:instagram_clone/features/reply/presentation/cubit/reply_cubit.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;
import 'package:timeago/timeago.dart' as timeago;

class CommentsAndRepliesWidget extends StatefulWidget {
  final CommentEntity comment;
  final UserEntity? currentUser;
  final VoidCallback? onTapReply;
  final VoidCallback? onLongPress;
  final VoidCallback? onSingleTap;
  final bool? onLongPressTrue;

  CommentsAndRepliesWidget({
    Key? key,
    this.onTapReply,
    required this.comment,
    this.onLongPress,
    this.onSingleTap,
    this.onLongPressTrue = false,
    this.currentUser,
  }) : super(key: key);

  @override
  State<CommentsAndRepliesWidget> createState() => _CommentsAndRepliesWidgetState();
}

class _CommentsAndRepliesWidgetState extends State<CommentsAndRepliesWidget> {
  String _currentUid = "";

  void toggleRepliesVisibility() {
    setState(() {
      _showReplies = !_showReplies;
    });
  }

  bool _hasReplies = false;
  bool _showReplies = false;

  @override
  void initState() {
    super.initState();

    di.sl<GetCurrentUidUseCase>().call().then((value) {
      _currentUid = value;
    });

    BlocProvider.of<ReplyCubit>(context).readReply(
        reply: ReplyEntity(
      postId: widget.comment.postId,
      commentId: widget.comment.commentId,
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onLongPress: () {
            _deleteCommentBottomModelSheet();
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
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
                        child: profileWidget(imageUrl: widget.comment.userProfileUrl),
                      ),
                    ),
                    horizontalSize(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${widget.comment.username}",
                              style: Styles.titleLine2
                                  .copyWith(color: Styles.colorBlack, fontWeight: FontWeight.w800),
                            ),
                            horizontalSize(5),
                            Text(
                              "${timeago.format(widget.comment.createdAt!.toDate())}",
                              style: Styles.titleLine2.copyWith(
                                  color: Styles.colorBlack.withOpacity(.5),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        verticalSize(5),
                        Container(
                          width: MediaQuery.of(context).size.width * .6,
                          child: Text("${widget.comment.description}"),
                        ),
                        verticalSize(5),
                        GestureDetector(
                          onTap: widget.onTapReply,
                          child: Text(
                            "Reply",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack.withOpacity(.5), fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        GestureDetector(
                          onTap:(){
                            _likeComment(comment: widget.comment);
                          },
                          child: Icon(
                            widget.comment.likes!.contains(_currentUid)
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: widget.comment.likes!.contains(_currentUid)
                                ? Colors.red
                                : Styles.colorBlack.withOpacity(.5),
                            size: 20,
                          ),
                        ),
                        Text(
                          "${widget.comment.likes!.length}",
                          style: Styles.titleLine2.copyWith(
                              color: Styles.colorBlack.withOpacity(.5),
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<ReplyCubit, ReplyState>(
          builder: (context, replyState) {
            if (replyState is ReplyLoaded) {
              final reply = replyState.replies
                  .where((element) => element.commentId == widget.comment.commentId)
                  .toList();
              _hasReplies = reply.isNotEmpty;
              return Column(
                children: [
                  ListView.builder(
                    physics: ScrollPhysics(),
                    itemCount: reply.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final replies = reply[index];
                      return Column(
                        children: [
                          BlocProvider(
                            create: (context) => di.sl<ReplyCubit>(),
                            child: Visibility(
                              visible: _showReplies,
                              maintainState: true,
                              child: InkWell(
                                onLongPress: () {
                                  _deleteReplyBottomModelSheet(reply: replies);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 60.0, top: 10, right: 15),
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
                                              child: profileWidget(imageUrl: replies.userProfileUrl),
                                            ),
                                          ),
                                          horizontalSize(10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${replies.username}",
                                                    style: Styles.titleLine2.copyWith(
                                                      color: Styles.colorBlack,
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                  horizontalSize(5),
                                                  Text(
                                                    "${timeago.format(replies.createdAt!.toDate())}",
                                                    style: Styles.titleLine2.copyWith(
                                                      color: Styles.colorBlack.withOpacity(.5),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              verticalSize(5),
                                              Container(
                                                width: MediaQuery.of(context).size.width * .6,
                                                child: Text("${replies.description}"),
                                              ),
                                              verticalSize(5),
                                              GestureDetector(
                                                onTap: widget.onTapReply,
                                                child: Text(
                                                  "Reply",
                                                  style: Styles.titleLine2.copyWith(
                                                    color: Styles.colorBlack.withOpacity(.5),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  _likeReply(reply: replies);
                                                },
                                                child: Icon(
                                                  replies.likes!.contains(_currentUid)
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: replies.likes!.contains(_currentUid)
                                                      ? Colors.red
                                                      : Styles.colorBlack.withOpacity(.5),
                                                  size: 20,
                                                ),
                                              ),
                                              Text(
                                                "${replies.likes?.length}",
                                                style: Styles.titleLine2.copyWith(
                                                  color: Styles.colorBlack.withOpacity(.5),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      verticalSize(15),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
                            _showReplies
                                ? "Hide Replies"
                                : "View ${reply.length} ${reply.length == 1 ? 'more reply' : 'more replies'}",
                            style: Styles.titleLine2.copyWith(
                                color: Styles.colorBlack.withOpacity(.5), fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  if (!_hasReplies) SizedBox(height: 0, width: 0),
                  verticalSize(10),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }

  void _deleteCommentBottomModelSheet() {
    showModalBottomSheet(
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .08),
              child: Column(
                children: [
                  InkWell(
                    onTap: _deleteComment,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          Icon(FluentIcons.delete_12_regular),
                          horizontalSize(10),
                          Text(
                            "Delete Comment",
                            style: Styles.titleLine1.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _deleteReplyBottomModelSheet({required ReplyEntity reply}) {
    showModalBottomSheet(
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .08),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      _deleteReplay(replyEntity: reply);
                      print("replay: $reply");
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          Icon(FluentIcons.delete_12_regular),
                          horizontalSize(10),
                          Text(
                            "Delete reply",
                            style: Styles.titleLine1.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  _likeReply({required ReplyEntity reply}) {
    BlocProvider.of<ReplyCubit>(context).likeReply(
      reply: ReplyEntity(commentId: reply.commentId, postId: reply.postId, replyId: reply.replyId),
    );
  }

  _deleteReplay({required ReplyEntity replyEntity}) {
    BlocProvider.of<ReplyCubit>(context)
        .deleteReply(
            reply: ReplyEntity(
                postId: replyEntity.postId,
                commentId: replyEntity.commentId,
                replyId: replyEntity.replyId))
        .then((value) {
      setState(() {
        Navigator.pop(context);
      });
    });
  }

  _deleteComment() {
    BlocProvider.of<CommentCubit>(context)
        .deleteComment(
            comment: CommentEntity(commentId: widget.comment.commentId, postId: widget.comment.postId))
        .then((value) {
      setState(() {
        Navigator.pop(context);
      });
    });
  }

  _likeComment({required CommentEntity comment}) {
    BlocProvider.of<CommentCubit>(context).likeComment(
      comment: CommentEntity(
        commentId: comment.commentId,
        postId: comment.postId,
      ),
    );
  }
}
