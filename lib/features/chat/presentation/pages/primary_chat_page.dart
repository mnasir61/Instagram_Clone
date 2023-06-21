import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/divider_widget.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';

class PrimaryChatPage extends StatelessWidget {
  const PrimaryChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onLongPress: () {
            _userOptionPage(context);
          },
          onTap: () {
            Navigator.pushNamed(context, PageConsts.singleChatPage);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: profileWidget(imageUrl: "assets/local/default_profile"),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            maxRadius: 6,
                            minRadius: 6,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    horizontalSize(15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Muhammad Nasir",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        verticalSize(2),
                        Text(
                          "Active 5h ago",
                          style: TextStyle(color: Colors.black.withOpacity(.5)),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(
                  CupertinoIcons.camera,
                  color: Colors.black.withOpacity(.5),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _userOptionPage(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Text(
                          "Selected Username",
                          style: TextStyle(fontWeight: FontWeight.w800),
                        )),
                    DividerWidget(),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            "Move to General",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            "Mark as unread",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            "Flag",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            "Delete",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            "Mute messages",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            "Mute calls",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ),
                    verticalSize(30),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
