import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/core/error_message.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/home_page/presentation/widgets/add_new_story_home_widget.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/home_page/presentation/widgets/single_post_widget.dart';
import 'package:instagram_clone/features/home_page/presentation/pages/home_page/presentation/widgets/view_story_widget.dart';
import 'package:instagram_clone/features/post_page/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post_page/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  double _elevation = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _scrollController.addListener(_scrollListener);
  // }
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
              if (postState is PostLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (postState is PostFailure) {
                toast("Some failures occurred while getting post");
              }
              if (postState is PostLoaded) {
                if (postState.posts.isEmpty) {
                  return Text("There is no post");
                }
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
                                      imageUrl: "assets/local/default_profile.png",
                                      username: "M.Nasir"),
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
                        postState.posts.isEmpty?_noPostsYetWidget():ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: postState.posts.length,
                          itemBuilder: (context, index) {
                              final posts = postState.posts[index];
                              return BlocProvider(
                                create: (context) => di.sl<PostCubit>(),
                                child: SinglePostWidget(
                                  posts: posts,
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
        ));
  }

  Widget _noPostsYetWidget() {
    return Column(
      children: [
        verticalSize(200),
        Text("No Posts Yet", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
      ],
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
