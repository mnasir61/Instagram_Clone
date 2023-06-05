import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/divider_widget.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/core/app_entity.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';

class CommentSectionFormWidget extends StatefulWidget {
  final UserEntity currentUser;
  final PostEntity posts;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmit;

  const CommentSectionFormWidget(
      {Key? key, this.controller, this.focusNode, this.onFieldSubmit, required this.currentUser, required this.posts})
      : super(key: key);

  @override
  State<CommentSectionFormWidget> createState() => _CommentSectionFormWidgetState();
}

class _CommentSectionFormWidgetState extends State<CommentSectionFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DividerWidget(),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: profileWidget(imageUrl: widget.currentUser.profileUrl),
                ),
              ),
              horizontalSize(10),
              Expanded(
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.send,
                  focusNode: widget.focusNode,
                  controller: widget.controller,
                  onFieldSubmitted: widget.onFieldSubmit,
                  onTapOutside: (PointerDownEvent event) {
                    widget.focusNode!.unfocus();
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: InputBorder.none,
                      hintText: "Add a comment for ${widget.posts.username}",
                      hintStyle:
                          Styles.titleLine1.copyWith(color: Styles.colorWhiteMid, fontSize: 14)),
                ),
              ),
              Icon(
                FluentIcons.gif_16_regular,
                size: 30,
              )
            ],
          ),
        ),
      ],
    );
  }
}
