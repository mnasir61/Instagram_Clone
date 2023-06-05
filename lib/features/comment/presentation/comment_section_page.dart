import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/core/error_message.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/core/app_entity.dart';
import 'package:instagram_clone/features/post/comment_page/domain/entity/comment_entity.dart';
import 'package:instagram_clone/features/post/comment_page/presentation/cubit/comment_cubit.dart';
import 'package:instagram_clone/features/post/comment_page/presentation/widgets/author_desc_for_comment_widget.dart';
import 'package:instagram_clone/features/post/comment_page/presentation/widgets/comment_and_replies_widget.dart';
import 'package:instagram_clone/features/post/comment_page/presentation/widgets/comment_section_form_widget.dart';
import 'package:instagram_clone/features/post/presentation/cubit/read_single_post/read_single_post_cubit.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:uuid/uuid.dart';

class CommentSectionPage extends StatefulWidget {
  final AppEntity appEntity;

  const CommentSectionPage({Key? key, required this.appEntity}) : super(key: key);

  @override
  State<CommentSectionPage> createState() => _CommentSectionPageState();
}

class _CommentSectionPageState extends State<CommentSectionPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _replyController = TextEditingController();
  final FocusNode _replyFocusNode = FocusNode();

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.appEntity.uid!);
    BlocProvider.of<CommentCubit>(context).getComments(postId: widget.appEntity.postId!);
    BlocProvider.of<ReadSinglePostCubit>(context).getSinglePost(postId: widget.appEntity.postId!);
    super.initState();
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
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
                            Expanded(
                              child: ListView(
                                children: [
                                  AuthorDescriptionForCommentWidget(
                                    post: singlePost,
                                  ),
                                  Container(
                                    height: .25,
                                    width: MediaQuery.of(context).size.width,
                                    color: Styles.colorGray1.withOpacity(.5),
                                  ),
                                  verticalSize(10),
                                  ListView.builder(
                                    itemCount: commentState.comments.length,
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final singleComment = commentState.comments[index];
                                      return Column(
                                        children: [
                                          CommentsAndRepliesWidget(
                                            comment: singleComment,
                                            onTapReply: () {
                                              _replyFocusNode.requestFocus();
                                            },
                                            onLikeListener: () {
                                              _likeComment(comment: commentState.comments[index]);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: CommentSectionFormWidget(
                                posts: singlePost,
                                currentUser: singleUser,
                                controller: _replyController,
                                focusNode: _replyFocusNode,
                                onFieldSubmit: (value) {
                                  _sendComment(singleUser);
                                },
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

  void _sendComment(UserEntity currentUser) {
    final String comment = _replyController.text.trim();
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
          description: _replyController.text,
        ),
      )
          .then((value) {
        setState(() {
          _replyController.clear();
        });
      });
    }
  }

  void _deleteComment(String commentId) {
    BlocProvider.of<CommentCubit>(context).deleteComment(comment: CommentEntity(commentId: commentId));
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

  _likeComment({required CommentEntity comment}) {
    BlocProvider.of<CommentCubit>(context).likeComment(
      comment: CommentEntity(
        commentId: comment.commentId,
        postId: comment.postId,
      ),
    );
  }
}
