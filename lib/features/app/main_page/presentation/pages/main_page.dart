import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/global/circular_progress_indicator_widget.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/home/presentation/home_page.dart';
import 'package:instagram_clone/features/post/presentation/pages/post_page.dart';
import 'package:instagram_clone/features/reels/presentation/pages/reels_page.dart';
import 'package:instagram_clone/features/search/presentation/pages/search_page.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  final String uid;

  const MainPage({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController searchController = TextEditingController();
  int _currentPageIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, state) {
        if (state is GetSingleUserLoaded) {
          final currentUser = state.singleUser;
          return WillPopScope(
            onWillPop: () async{
              if(_currentPageIndex!=0){
                setState(() {
                  _currentPageIndex=0;
                });
                return false;
              }
              return true;
            },
            child: Scaffold(
              key: _scaffoldState,
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: _currentPageIndex,
                onTap: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Styles.colorBlack,
                selectedLabelStyle: TextStyle(color: Colors.black, fontSize: 12),
                unselectedItemColor: Styles.colorBlack,
                unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                showUnselectedLabels: false,
                showSelectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
                    label: "Home",
                    activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FluentSystemIcons.ic_fluent_search_regular),
                    label: "Search",
                    activeIcon: Icon(FluentSystemIcons.ic_fluent_search_filled),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FluentSystemIcons.ic_fluent_add_circle_regular),
                    label: "Post",
                    activeIcon: Icon(FluentSystemIcons.ic_fluent_add_circle_filled),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FluentSystemIcons.ic_fluent_video_clip_regular),
                    label: "Reels",
                    activeIcon: Icon(FluentSystemIcons.ic_fluent_video_clip_filled),
                  ),
                  currentUser.profileUrl == "" || currentUser.profileUrl == null
                      ? BottomNavigationBarItem(
                          icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
                          label: "Profile",
                          activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
                        )
                      : _currentPageIndex == 4
                          ? BottomNavigationBarItem(
                              label: "Profile",
                              icon: Container(
                                height: 27,
                                width: 27,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Colors.black, width: 2)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: profileWidget(imageUrl: currentUser.profileUrl),
                                ),
                              ),
                            )
                          : BottomNavigationBarItem(
                              label: "Profile",
                              icon: Container(
                                height: 27,
                                width: 27,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: profileWidget(imageUrl: currentUser.profileUrl),
                                ),
                              ),
                            ),
                ],
              ),
              body: _switchPage(_currentPageIndex, currentUser),
            ),
          );
        }
        return CircularProgressIndicatorWidget();
      },
    );
  }

  _switchPage(int index, UserEntity currentUser) {
    switch (index) {
      case 0:
        {
          return HomePage(currentUser: currentUser,);
        }
      case 1:
        {
          return SearchPage();
        }
      case 2:
        {
          return PostPage(
            currentUser: currentUser,
          );
        }
      case 3:
        {
          return ReelsPage(currentUser: currentUser,);
        }
      case 4:
        {
          return ProfilePage(
            currentUser: currentUser,
          );
        }
    }
  }
}
