import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

import 'widgets/add_new_story_home_widget.dart';
import 'widgets/single_post_widget.dart';
import 'widgets/view_story_widget.dart';

class HomePage extends StatefulWidget {
  final UserEntity currentUser;

  const HomePage({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  double _elevation = 0;

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_scrollListener);
  }

  //
  // @override
  // void dispose() {
  //   _scrollController.removeListener(_scrollListener);
  //   _scrollController.dispose();
  //   super.dispose();
  // }
  //
  // void _scrollListener() {
  //   setState(() {
  //     _elevation = _scrollController.offset > 0 ? 0.4 : 0;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      backgroundColor: Styles.colorWhite,
      body: BlocProvider<PostCubit>(
        create: (context) => di.sl<PostCubit>()..getPosts(post: PostEntity()),
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, postState) {
            if (postState is PostLoaded) {
              final posts = postState.posts;
              return ListView(
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
                      verticalSize(5),
                      Container(
                        height: .25,
                        width: MediaQuery.of(context).size.width,
                        color: Styles.colorGray1.withOpacity(.5),
                      ),
                      postState.posts.isEmpty
                          ? _noPostWidget()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: postState.posts.length,
                              itemBuilder: (context, index) {
                                final singlePosts = posts[index];
                                return BlocProvider<PostCubit>(
                                  create: (context) => di.sl<PostCubit>(),
                                  child: SinglePostWidget(
                                    currentUser: widget.currentUser,
                                    posts: singlePosts,
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  _noPostWidget() {
    return Center(
      child: Column(
        children: [
          verticalSize(250),
          Text(
            "No post yet",
            style: Styles.titleLine1.copyWith(fontSize: 25, color: Colors.black.withOpacity(.3)),
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
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, PageConsts.chatMainPage,
                  arguments: widget.currentUser.uid);
            },
            child: Icon(
              FontAwesomeIcons.facebookMessenger,
              color: Styles.colorBlack,
              size: 22,
            ),
          ),
        )
      ],
    );
  }
}
