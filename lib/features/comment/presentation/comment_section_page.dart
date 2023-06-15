import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/core/app_entity.dart';
import 'package:instagram_clone/core/error_message.dart';
import 'package:instagram_clone/features/comment/domain/entity/comment_entity.dart';
import 'package:instagram_clone/features/comment/presentation/cubit/comment_cubit.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/post/presentation/cubit/read_single_post/read_single_post_cubit.dart';
import 'package:instagram_clone/features/reply/domain/entities/reply_entity.dart';
import 'package:instagram_clone/features/reply/presentation/cubit/reply_cubit.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;
import 'package:uuid/uuid.dart';

import 'widgets/author_desc_for_comment_widget.dart';
import 'widgets/comment_and_replies_widget.dart';
import 'widgets/comment_section_form_widget.dart';

class CommentSectionPage extends StatefulWidget {
  final AppEntity appEntity;

  const CommentSectionPage({Key? key, required this.appEntity}) : super(key: key);

  @override
  State<CommentSectionPage> createState() => _CommentSectionPageState();
}

class _CommentSectionPageState extends State<CommentSectionPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _replyController = TextEditingController();
  bool _showReplyField = false;

  final FocusNode _replyFocusNode = FocusNode();

  CommentEntity? selectedComment;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.appEntity.uid!);
    BlocProvider.of<CommentCubit>(context).getComments(postId: widget.appEntity.postId!);
    BlocProvider.of<ReadSinglePostCubit>(context).getSinglePost(postId: widget.appEntity.postId!);
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
    _replyController.dispose();
    _replyFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      backgroundColor: Styles.colorWhite,
      body: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, singleUserState) {
          if (singleUserState is GetSingleUserLoaded) {
            final singleUser = singleUserState.singleUser;
            return BlocBuilder<ReadSinglePostCubit, ReadSinglePostState>(
              builder: (context, singlePostState) {
                if (singlePostState is ReadSinglePostLoaded) {
                  final singlePost = singlePostState.posts;
                  return BlocBuilder<CommentCubit, CommentState>(
                    builder: (context, commentState) {
                      if (commentState is CommentLoaded) {
                        return Column(
                          children: [
                            AuthorDescriptionForCommentWidget(
                              post: singlePost,
                            ),
                            verticalSize(5),
                            Container(
                              height: .25,
                              width: MediaQuery.of(context).size.width,
                              color: Styles.colorGray1.withOpacity(.5),
                            ),
                            commentState.comments.length == 0
                                ? _noCommentsWidget()
                                : Expanded(
                                    child: ListView.builder(
                                      itemCount: commentState.comments.length,
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final singleComment = commentState.comments[index];
                                        return BlocProvider<ReplyCubit>(
                                          create: (context) => di.sl<ReplyCubit>(),
                                          child: CommentsAndRepliesWidget(
                                            currentUser: singleUser,
                                            comment: singleComment,
                                            onTapReply: () {
                                              setState(() {
                                                _showReplyField = true;
                                                selectedComment = singleComment;
                                              });
                                              _replyFocusNode.requestFocus();
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            _showReplyField
                                ? FocusScope(
                                    child: Form(
                                      key: _formKey,
                                      child: CommentSectionFormWidget(
                                          isHintText: true,
                                          currentUser: singleUser,
                                          controller: _replyController,
                                          focusNode: _replyFocusNode,
                                          onFieldSubmit: (value) {
                                            _createReplay(
                                                currentUser: singleUser, comment: selectedComment!);
                                            setState(() {
                                              _showReplyField = false;
                                              _replyController.clear();
                                            });
                                          }),
                                    ),
                                  )
                                : FocusScope(
                                    child: Form(
                                      key: _formKey,
                                      child: CommentSectionFormWidget(
                                        isHintText: false,
                                        currentUser: singleUser,
                                        controller: _commentController,
                                        focusNode: _replyFocusNode,
                                        onFieldSubmit: (value) {
                                          _sendComment(singleUser);
                                        },
                                      ),
                                    ),
                                  ),
                          ],
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  _createReplay({required UserEntity currentUser, required CommentEntity comment}) {
    final String reply = _replyController.text.trim();
    if (reply.isEmpty) {
      toast("Empty reply cannot be sent.");
      return;
    } else {
      BlocProvider.of<ReplyCubit>(context)
          .createReply(
              reply: ReplyEntity(
        replyId: Uuid().v1(),
        createdAt: Timestamp.now(),
        likes: [],
        username: currentUser.username,
        userProfileUrl: currentUser.profileUrl,
        creatorUid: currentUser.uid,
        postId: comment.postId,
        commentId: comment.commentId,
        description: _replyController.text,
      ))
          .then((value) {
        setState(() {
          _replyController.clear();
          print("Reply Created");
        });
      });
    }
  }

  void _sendComment(UserEntity currentUser) {
    final String comment = _commentController.text.trim();
    if (comment.isEmpty) {
      toast("Empty comment cannot be sent.");
      return;
    } else {
      BlocProvider.of<CommentCubit>(context)
          .createComment(
        comment: CommentEntity(
          totalReplies: 0,
          commentId: Uuid().v1(),
          createdAt: Timestamp.now(),
          likes: [],
          username: currentUser.username,
          userProfileUrl: currentUser.profileUrl,
          creatorId: currentUser.uid,
          postId: widget.appEntity.postId,
          description: _commentController.text,
        ),
      )
          .then((value) {
        setState(() {
          _commentController.clear();
        });
      });
    }
  }

  _appBarWidget() {
    return AppBar(
      backgroundColor: Styles.colorWhite,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          FontAwesomeIcons.arrowLeft,
          color: Styles.colorBlack,
          size: 23,
        ),
      ),
      title: Text(
        "Comments",
        style: Styles.headLine
            .copyWith(color: Styles.colorBlack, fontSize: 22, fontWeight: FontWeight.w700),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: GestureDetector(
            onTap: () {},
            child: Icon(
              FontAwesomeIcons.paperPlane,
              color: Styles.colorBlack,
            ),
          ),
        ),
      ],
    );
  }

  _noCommentsWidget() {
    return Center(
      child: Column(
        children: [
          verticalSize(200),
          Text(
            "Be the first",
            style: Styles.titleLine1.copyWith(fontSize: 25, color: Colors.black.withOpacity(.3)),
          ),
        ],
      ),
    );
  }
}
