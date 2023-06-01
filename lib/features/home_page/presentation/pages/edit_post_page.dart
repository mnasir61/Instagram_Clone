import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/post_page/domain/entities/post_entity.dart';
import 'package:timeago/timeago.dart' as timeago;
class EditPostPage extends StatefulWidget {
  final PostEntity posts;

  const EditPostPage({Key? key, required this.posts}) : super(key: key);

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  TextEditingController _editInfoController = TextEditingController();

  bool _isUpdate= false;

  @override
  void initState() {
    _editInfoController =TextEditingController(text: widget.posts.description);
    super.initState();
  }
  @override
  void dispose() {
    _editInfoController.dispose();
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
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: profileWidget(imageUrl: "${widget.posts.userProfileUrl}"))),
                            horizontalSize(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.posts.username}",
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
                          "${timeago.format(widget.posts.createdAt!.toDate())}",
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
                child: profileWidget(imageUrl: "${widget.posts.postImageUrl}")
              ),
              verticalSize(10),
              TextFormField(
                controller: _editInfoController,
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
