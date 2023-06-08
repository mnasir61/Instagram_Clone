import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/global/circular_progress_indicator_widget.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/home/presentation/home_page.dart';
import 'package:instagram_clone/features/post/presentation/pages/post_page.dart';
import 'package:instagram_clone/features/reels/presentation/pages/reels_page.dart';
import 'package:instagram_clone/features/search/presentation/pages/search_page.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  final String uid;
  const MainPage({Key? key, required this.uid,}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController searchController = TextEditingController();
  int _currentPageIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();


  @override
  void initState() {

    BlocProvider.of<  GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit,GetSingleUserState>(
      builder: (context,state){
        if(state is GetSingleUserLoaded){
          final currentUser = state.singleUser;
          return  Scaffold(
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
                BottomNavigationBarItem(
                  icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
                  label: "Profile",
                  activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
                ),
              ],
            ),
            body: _switchPage(_currentPageIndex,currentUser),
          );
        }
        return CircularProgressIndicatorWidget();
      },
    );
  }

  _switchPage(int index,UserEntity currentUser) {
    switch (index) {
      case 0:
        {
          return HomePage();
        }
      case 1:
        {
          return SearchPage();
        }
      case 2:
        {
          return PostPage(currentUser: currentUser,);
        }
      case 3:
        {
          return ReelsPage();
        }
      case 4:
        {
          return ProfilePage(currentUser: currentUser,);
        }
    }
  }
}
