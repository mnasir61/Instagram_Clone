

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/styles/style.dart';

class SearchFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  const SearchFieldWidget({Key? key, this.controller}) : super(key: key);

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(

      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
          prefixIcon: Icon(FontAwesomeIcons.search,size: 20,),
          hintText: "Search",
          border: InputBorder.none
        ),
      ),
    );
  }
}
