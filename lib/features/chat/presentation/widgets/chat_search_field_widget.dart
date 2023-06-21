

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/styles/style.dart';

class ChatSearchFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  const ChatSearchFieldWidget({Key? key, this.controller}) : super(key: key);

  @override
  State<ChatSearchFieldWidget> createState() => _ChatSearchFieldWidgetState();
}

class _ChatSearchFieldWidgetState extends State<ChatSearchFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(

      // width: MediaQuery.of(context).size.width*.8,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 3),
            prefixIcon: Icon(FontAwesomeIcons.search,size: 17,),
            hintText: "Search",
            border: InputBorder.none
        ),
      ),
    );
  }
}
