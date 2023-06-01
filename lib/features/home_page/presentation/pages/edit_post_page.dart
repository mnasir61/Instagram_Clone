import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/divider_widget.dart';
import 'package:instagram_clone/features/global/styles/style.dart';

class EditPostPage extends StatefulWidget {
  const EditPostPage({Key? key}) : super(key: key);

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  TextEditingController editInfoController = TextEditingController();

  @override
  void dispose() {
    editInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(context),
      backgroundColor: Styles.colorWhite,
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset("assets/local/default_profile.png"),
                            ),
                            horizontalSize(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "user_dead0_o",
                                  style: Styles.titleLine2
                                      .copyWith(color: Styles.colorBlack, fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  "Add location",
                                  style: Styles.titleLine2.copyWith(color: Colors.blue),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "105w",
                          style: Styles.titleLine2.copyWith(
                              color: Styles.colorBlack.withOpacity(.5), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    verticalSize(10),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .45,
                child: Image.asset(
                  "assets/local/instagram_post.png",
                  fit: BoxFit.cover,
                ),
              ),
              verticalSize(10),
              TextFormField(
                controller: editInfoController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: InputBorder.none,
                ),
              ),
              Divider(thickness: 1, color: Colors.blue, height: 0),
            ],
          ),
        ],
      ),
    );
  }

  _appBarWidget(BuildContext context) {
    return AppBar(
      backgroundColor: Styles.colorWhite,
      elevation: 0,
      leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            FontAwesomeIcons.close,
            color: Styles.colorBlack,
            size: 23,
          )),
      title: Text(
        "Edit info",
        style: Styles.headLine
            .copyWith(color: Styles.colorBlack, fontSize: 22, fontWeight: FontWeight.w700),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Icon(
            FontAwesomeIcons.check,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
