import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/app_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/engaged_user_entity.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/create_one_to_one_chat_usecase.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_users_cubit.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;
import 'package:timeago/timeago.dart' as timeago;

class NewChatPage extends StatefulWidget {
  final String uid;

  const NewChatPage({
    super.key,
    required this.uid,
  });

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  final List<UserEntity> selectedUsers = [];
  int selectedIndex = 0;
  bool isCheckBox = false;
  TextEditingController _searchController = TextEditingController();
  TextEditingController _groupNameController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<GetUsersCubit>(context).getAllUsers(user: UserEntity());
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
  }
  @override
  void dispose() {
    _groupNameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, singleUserState) {
          if (singleUserState is GetSingleUserLoaded) {
            final currentUser = singleUserState.singleUser;
            return BlocBuilder<GetUsersCubit, GetUsersState>(
              builder: (context, usersState) {
                if (usersState is GetUsersLoaded) {
                  final users = usersState.users.where((user) => user.uid != widget.uid).toList();
                  return Scaffold(
                    appBar: AppBar(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      title: selectedUsers.length>1?TextFormField(
                        controller: _groupNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Your group name"
                        ),
                      ):Text(
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
                        selectedUsers.isEmpty?Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.7),
                          child: TextFormField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              hintText: "Search user",
                              border: InputBorder.none,
                            ),
                          ),
                        ):LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 55, minHeight: 50),
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: selectedUsers.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final singleSelectedUsers = selectedUsers[index];
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
                                      "${singleSelectedUsers.fullName}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Suggested",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                  ),
                                  ListView.builder(
                                    itemCount: users.length,
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final singleUser = users[index];
                                      return Container(
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: CupertinoButton(padding: EdgeInsets.all(0),

                                          onPressed: (){
                                            setState(() {
                                              if(selectedUsers.contains(singleUser)){
                                                selectedUsers.remove(singleUser);
                                              }else{
                                                selectedUsers.add(singleUser);
                                              }
                                            });
                                          },
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
                                                          child: profileWidget(
                                                              imageUrl: "${singleUser.profileUrl}"),
                                                        ),
                                                      ),
                                                      if (singleUser.isOnline == true)
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
                                                        "${singleUser.fullName}",
                                                        style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black),
                                                      ),
                                                      verticalSize(2),
                                                      Text(
                                                        "${singleUser.username}",
                                                        style:
                                                            TextStyle(fontSize: 14,color: Colors.black.withOpacity(.5)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 24,
                                                width: 24,
                                                decoration: selectedUsers.contains(singleUser)?BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: Colors.blue
                                                ):BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    border: Border.all(width: 2,color: Colors.grey)
                                                ),
                                                child: selectedUsers.contains(singleUser)?Icon(CupertinoIcons.checkmark_alt,color: Colors.white,size: 26,):SizedBox(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                        if (selectedUsers.isNotEmpty) ...[
                          GestureDetector(
                            onTap: () {
                              if (selectedUsers.isNotEmpty &&
                                  selectedIndex >= 0 &&
                                  selectedIndex < selectedUsers.length) {
                                UserEntity selectedUser = selectedUsers[selectedIndex];
                                di
                                    .sl<CreateOneToOneChatUseCase>()
                                    .call(
                                      EngagedUserEntity(
                                        uid: widget.uid,
                                        otherUid: selectedUser.uid,
                                      ),
                                    )
                                    .then((channelId) {
                                  Navigator.pushNamed(
                                    context,
                                    PageConsts.singleChatPage,
                                    arguments: AppEntity(
                                      senderUid: currentUser.uid,
                                      senderName: currentUser.username,
                                      senderProfileUrl: currentUser.profileUrl,
                                      channelId: channelId,
                                      recipientUid: selectedUser.uid,
                                      recipientProfileUrl: selectedUser.profileUrl,
                                      recipientName: selectedUser.username,
                                    ),
                                  );
                                });
                              } else {
                                return;
                              }
                            },
                            child: Container(
                              height: 45,
                              margin: EdgeInsets.only(right: 15, left: 15, bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.blue,
                              ),
                              child: Center(
                                child: Text(
                                  selectedUsers.length == 1 ? "Create Chat" : "Create Group",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ] else ...[
                          Container(
                            height: 45,
                            margin: EdgeInsets.only(right: 15, left: 15, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.blue,
                            ),
                            child: Center(
                              child: Text(
                                "Create Chat",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ]
                      ],
                    ),
                  );
                } else
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
              },
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  String getActiveStatus(UserEntity user) {
    final now = DateTime.now();
    final lastActivity = user.lastActivity ?? now;
    final lastActivityDateTime = DateTime.parse(lastActivity.toString());
    final difference = now.difference(lastActivityDateTime);

    if (user.isOnline == true) {
      return 'Active Now';
    } else if (difference.inMinutes <= 4) {
      return 'Active a moment ago';
    } else if (difference.inMinutes < 60) {
      return 'Active ${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return 'Active ${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'Active yesterday';
    } else {
      return 'Active ${timeago.format(now.subtract(difference), locale: 'en')} ago';
    }
  }
}

