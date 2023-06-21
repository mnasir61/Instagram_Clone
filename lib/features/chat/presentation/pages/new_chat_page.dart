import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({super.key});

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "New message",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "To",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 55, minHeight: 50),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 12,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      margin: EdgeInsets.only(right: 5, top: 10, bottom: 10),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.lightBlueAccent.withOpacity(.9),
                          ],
                        ),
                      ),
                      child: Text(
                        "Nadeem khan",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "Suggested",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 12,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onLongPress: () {},
                  onTap: () {},
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
                                  "Username here",
                                  style: TextStyle(color: Colors.black.withOpacity(.5)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            checkColor: Colors.white,
                            value: _value,
                            shape: CircleBorder(),
                            onChanged: (bool? value) {
                              setState(() {
                                _value = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue,
            ),
            child: Center(
                child: Text(
              "Create chat",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )),
          ),
        ],
      ),
    );
  }
}
