import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/styles/style.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      backgroundColor: Styles.colorWhite,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New",
                        style: Styles.titleLine1
                            .copyWith(color: Styles.colorBlack, fontWeight: FontWeight.bold),
                      ),
                      verticalSize(10),
                      Row(
                        children: [
                          Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(shape: BoxShape.circle),
                                child: Image.asset("assets/local/default_profile.png"),
                              ),
                              horizontalSize(10),
                              Container(
                                width: MediaQuery.of(context).size.width*.8,
                                child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                      "another_user ",
                                      style: Styles.titleLine2.copyWith(color: Styles.colorBlack,fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          "and 95 others follow you, but you don't follow them back.and 95 others follow you, but you don't follow them back.and 95 others follow you, but you don't follow them back.and 95 others follow you, but you don't follow them back.and 95 others follow you, but you don't follow them back.and 95 others follow you, but you don't follow them back. ",
                                      style: Styles.titleLine2.copyWith(color: Styles.colorBlack),
                                    ),
                                    TextSpan(
                                      text:
                                      "11h",
                                      style: Styles.titleLine2.copyWith(color: Styles.colorBlack.withOpacity(.6),fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
          )),
      title: Text(
        "Notifications",
        style: Styles.headLine
            .copyWith(color: Styles.colorBlack, fontSize: 22, fontWeight: FontWeight.w700),
      ),
    );
  }
}
