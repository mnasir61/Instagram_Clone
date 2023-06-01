import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/home_page/presentation/widgets/add_new_story_home_widget.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/home_page/presentation/widgets/single_post_widget.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/home_page/presentation/widgets/view_story_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  double _elevation = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _elevation = _scrollController.offset > 0 ? 0.4 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      backgroundColor: Styles.colorWhite,
      body: ListView(
        controller: _scrollController,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSize(10),
                    Row(
                      children: [
                        AddNewStoryHomeWidget(
                            imageUrl: "assets/local/default_profile.png", username: "New"),
                        horizontalSize(15),
                        ViewStoryWidget(
                            imageUrl: "assets/local/default_profile.png", username: "M.Nasir"),
                      ],
                    ),
                  ],
                ),
              ),
              SinglePostWidget(
                userImagePath: "assets/local/default_profile.png",
                usernameText: "John Doe",
                imagePostPath: "assets/local/instagram_post.png",
                totalLikesText: "37 Likes",
                descriptionText:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Nullam euismod justo sed mauris varius, sed posuere risus pharetra.Quisque vehicula nulla nec sem gravida convallis.",
                totalCommentsText: "View all 6 comments",
              ),
            ],
          ),
        ],
      ),
    );
  }

  _appBarWidget() {
    return AppBar(
      backgroundColor: Styles.colorWhite,
      elevation: _elevation,
      title: SvgPicture.asset(
        "assets/main/insta_text_logo.svg",
        height: 31,
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PageConsts.notificationPage);
          },
          child: Icon(
            FontAwesomeIcons.heart,
            color: Styles.colorBlack,
            size: 22,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 15),
          child: Icon(
            FontAwesomeIcons.facebookMessenger,
            color: Styles.colorBlack,
            size: 22,
          ),
        )
      ],
    );
  }
}
