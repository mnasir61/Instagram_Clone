import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/styles/style.dart';

class ChatTextFormWidget extends StatefulWidget {
  final TextEditingController? messageController;
  final bool? isHintText;
  final void Function(String)? onFieldSubmit;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final VoidCallback? sendMessage;

  const ChatTextFormWidget({
    Key? key,
    this.messageController,
    this.onFieldSubmit,
    this.isHintText = false,
    this.textInputAction,
    this.validator,
    this.sendMessage,
  }) : super(key: key);

  @override
  State<ChatTextFormWidget> createState() => _ChatTextFormWidgetState();
}

class _ChatTextFormWidgetState extends State<ChatTextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.lightBlue,
            ),
            child: widget.messageController!.text.isNotEmpty
                ? Icon(
                    CupertinoIcons.search,
                    color: Colors.white,
                  )
                : Icon(
                    CupertinoIcons.camera_fill,
                    color: Colors.white,
                  ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              textInputAction: widget.textInputAction,
              controller: widget.messageController,
              onFieldSubmitted: widget.onFieldSubmit,
              validator: widget.validator,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                border: InputBorder.none,
                hintText: "Message...",
                hintStyle: Styles.titleLine1.copyWith(color: Styles.colorWhiteMid, fontSize: 14),
              ),
            ),
          ),
          widget.messageController!.text.isNotEmpty
              ? GestureDetector(
                  onTap: widget.sendMessage,
                  child: Text("Send",
                      style: TextStyle(color: colorBlue, fontWeight: FontWeight.w600, fontSize: 16)),
                )
              : Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(CupertinoIcons.mic),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(FluentIcons.image_48_regular),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5),
                      child: Icon(CupertinoIcons.add_circled),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
