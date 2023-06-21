import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/chat/presentation/widgets/chat_text_fom_widget.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';

class SingleChatPage extends StatelessWidget {
  const SingleChatPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: profileWidget(imageUrl: "assets/local/default_profile"),
              ),
            ),
            horizontalSize(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nadeem Khan",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Active yesterday",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(.5)),
                ),
              ],
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(CupertinoIcons.phone),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                FluentIcons.video_48_regular,
                size: 26,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 10),
              child: Icon(CupertinoIcons.flag),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.grey.withOpacity(.4)),
                    child: Text("Malayalam Sangam MN"),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: colorBlue),
                    child: Text("Malayalam ",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
          ChatTextFormWidget(),
        ],
      ),
    );
  }
}
