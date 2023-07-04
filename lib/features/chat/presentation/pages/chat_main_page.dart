import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/chat/presentation/cubit/my_chat/my_chat_cubit.dart';
import 'package:instagram_clone/features/chat/presentation/pages/general_chat_page.dart';
import 'package:instagram_clone/features/chat/presentation/pages/group_chat_page.dart';
import 'package:instagram_clone/features/chat/presentation/pages/primary_chat_page.dart';
import 'package:instagram_clone/features/chat/presentation/pages/request_chat_page.dart';
import 'package:instagram_clone/features/chat/presentation/widgets/chat_search_field_widget.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/cubit/get_other_single_user/get_other_single_user_cubit.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_users_cubit.dart';

class ChatMainPage extends StatefulWidget {
  final String uid;

  const ChatMainPage({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<ChatMainPage> createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {
  List<String> pages = [
    'Primary',
    'General',
    'Groups',
    'Requests',
  ];
  int _selectedIndex = 0;

  @override
  void initState() {
    BlocProvider.of<MyChatCubit>(context).getMyChat(uid: widget.uid);
    BlocProvider.of<GetUsersCubit>(context).getAllUsers(user: UserEntity());
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, singleUserState) {
        if (singleUserState is GetSingleUserLoaded) {
          final currentUser = singleUserState.singleUser;
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                "${currentUser.username}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              actions: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(FontAwesomeIcons.ellipsis),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(FontAwesomeIcons.arrowTrendUp),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PageConsts.newChatPage, arguments: widget.uid);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(FontAwesomeIcons.penToSquare),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      verticalSize(10),
                      Row(
                        children: [
                          Expanded(child: ChatSearchFieldWidget()),
                          horizontalSize(15),
                          Text(
                            "Filter",
                            style: TextStyle(color: colorBlue, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      verticalSize(10),
                    ],
                  ),
                ),
                verticalSize(15),
                BlocBuilder<GetUsersCubit, GetUsersState>(
                  builder: (context, usersState) {
                    if (usersState is GetUsersLoaded) {
                      final users = usersState.users;
                      final onlineOtherUsers = users;
                      return LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) {
                          final onlineUsers = onlineOtherUsers
                              .where((user) => user.isOnline != null&&user.isOnline!)
                              .toList();

                          if (onlineUsers.isEmpty) {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.supervised_user_circle_sharp,
                                    color: Colors.grey.withOpacity(.5),
                                  ),
                                  Text(
                                    'No users online',
                                    style: TextStyle(
                                      color: Colors.grey.withOpacity(.5),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height * 0,
                              maxHeight: MediaQuery.of(context).size.height * .1,
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.only(left: 5),
                              itemCount: onlineUsers.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final singleUser = onlineUsers[index];
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(40),
                                              child: profileWidget(imageUrl: singleUser.profileUrl),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              maxRadius: 8,
                                              minRadius: 8,
                                              child: Container(
                                                width: 12,
                                                height: 12,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      for (int index = 0; index < pages.length; index++)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (index == pages.length - 1) {
                                Navigator.pushNamed(context, PageConsts.requestChatPage);
                              } else {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              }
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: 30,
                              margin: EdgeInsets.only(right: index != pages.length - 1 ? 10 : 0),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: _selectedIndex == index
                                    ? Colors.lightBlueAccent.withOpacity(.5)
                                    : Colors.grey.withOpacity(.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  pages[index],
                                  style: Styles.headLine.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: _selectedIndex == index ? colorBlue : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                verticalSize(15),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: <Widget>[
                      PrimaryChatPage(uid: widget.uid),
                      GeneralChatPage(),
                      GroupChatPage(),
                      RequestChatPage(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
