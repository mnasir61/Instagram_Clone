

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/divider_widget.dart';
import 'package:instagram_clone/features/global/styles/style.dart';

class CommentSectionFormWidget extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? userUrlPath;
  const CommentSectionFormWidget({Key? key, this.controller, this.focusNode, this.hintText, this.userUrlPath}) : super(key: key);

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
                decoration: BoxDecoration(
                  shape: BoxShape.circle
                ),
                child: Image.asset("${widget.userUrlPath}"),
              ),
              horizontalSize(10),
              Expanded(child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.send,
                focusNode: widget.focusNode,
                controller: widget.controller,
                onFieldSubmitted: (value){
                  _sendComment();
                },
                onTapOutside: (PointerDownEvent event) {
                  widget.focusNode!.unfocus();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  border: InputBorder.none,
                  hintText: "${widget.hintText}",
                  hintStyle: Styles.titleLine1.copyWith(color: Styles.colorWhiteMid,fontSize: 14)
                ),
              ),),
              Icon(FluentIcons.gif_16_regular,size: 30,)
            ],
          ),
        ),
      ],
    );
  }
  void _sendComment() {
    final String comment = widget.controller!.text.trim();
    if (comment.isNotEmpty) {
      widget.controller!.clear();
    }
  }
}
