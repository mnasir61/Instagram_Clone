import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/divider_widget.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';

class ChatTextFormWidget extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? isHintText;
  final void Function(String)? onFieldSubmit;

  const ChatTextFormWidget(
      {Key? key, this.controller, this.focusNode, this.onFieldSubmit, this.isHintText = false})
      : super(key: key);

  @override
  State<ChatTextFormWidget> createState() => _CommentSectionFormWidgetState();
}

class _CommentSectionFormWidgetState extends State<ChatTextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey.withOpacity(.2),
          ),
          child: Row(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.lightBlue),
                  child: Icon(
                    CupertinoIcons.camera_fill,
                    color: Colors.white,
                  )),
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      border: InputBorder.none,
                      hintText: widget.isHintText == false ? "Message..." : "Add a Reply",
                      hintStyle:
                          Styles.titleLine1.copyWith(color: Styles.colorWhiteMid, fontSize: 14)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(CupertinoIcons.mic),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(FluentIcons.image_48_regular),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0,right: 5),
                child: Icon(CupertinoIcons.add_circled),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
