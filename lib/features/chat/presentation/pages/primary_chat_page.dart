import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/app_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/engaged_user_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/my_chat_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/text_message_entity.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/create_one_to_one_chat_usecase.dart';
import 'package:instagram_clone/features/chat/presentation/cubit/my_chat/my_chat_cubit.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/divider_widget.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_users_cubit.dart';
import 'package:instagram_clone/main_injection_container.dart'as di;
import 'package:timeago/timeago.dart' as timeago;

class PrimaryChatPage extends StatefulWidget {
  final String uid;
  const PrimaryChatPage({super.key, required this.uid});

  @override
  State<PrimaryChatPage> createState() => _PrimaryChatPageState();
}

class _PrimaryChatPageState extends State<PrimaryChatPage> {


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUsersCubit, GetUsersState>(
      builder: (context, getAllUsersState) {
        if (getAllUsersState is GetUsersLoaded) {
          final allUsers = getAllUsersState.users;
          return BlocBuilder<MyChatCubit, MyChatState>(
            builder: (context, myChatState) {
              if (myChatState is MyChatLoaded) {
                final chats = myChatState.myChat;
                return chats.isEmpty
                    ? _noChatChannels()
                    : ListView.builder(
                        itemCount: chats.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          final singleChat = chats[index];
                          final singleUser  = allUsers[index];
                          final activeStatus = getActiveStatus(singleUser,singleChat);
                          return InkWell(
                            onLongPress: () {
                              _userOptionPage(context, singleChat);
                            },
                            onTap: () {
                              Navigator.pushNamed(context, PageConsts.singleChatPage,
                              arguments: AppEntity(
                              senderUid: singleChat.senderUid,
                              senderName: singleChat.senderName,
                              senderProfileUrl: singleChat.senderProfileUrl,
                              recipientUid: singleChat.recipientUid,
                              recipientProfileUrl: singleChat.recipientProfileUrl,
                              recipientName: singleChat.recipientName,
                              ));

                            },
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
                                              child: profileWidget(
                                                  imageUrl: "${singleChat.recipientProfileUrl}"),
                                            ),
                                          ),
                                          if(singleUser.isOnline==true)
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
                                            "${singleChat.recipientName}",
                                            style: TextStyle(fontWeight: FontWeight.w500),
                                          ),
                                          verticalSize(2),
                                          Text(
                                            "$activeStatus",
                                            style: TextStyle(color: Colors.black.withOpacity(.5)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    CupertinoIcons.camera,
                                    color: Colors.black.withOpacity(.5),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _userOptionPage(BuildContext context, MyChatEntity myChatSelectedUser) {
    showModalBottomSheet(
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Text(
                          "${myChatSelectedUser.recipientName}",
                          style: TextStyle(fontWeight: FontWeight.w800),
                        )),
                    DividerWidget(),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            "Move to General",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            "Mark as unread",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            "Flag",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            "Delete",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            "Mute messages",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            "Mute calls",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ),
                    verticalSize(30),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String getActiveStatus(UserEntity user, MyChatEntity myChatEntity) {
    if (user.isOnline == true) {
      return 'Active now';
    } else if (myChatEntity.createdAt != null) {
      final lastActiveDateTime = (myChatEntity.createdAt as Timestamp).toDate();
      final difference = DateTime.now().difference(lastActiveDateTime);
      if (difference.inMinutes <= 10) {
        return 'Active a moment ago';
      } else if (difference.inMinutes <= 60) {
        return 'Active ${difference.inMinutes}m ago';
      } else if (difference.inHours <= 24) {
        return 'Active ${difference.inHours}h ago';
      } else if (difference.inDays == 1) {
        return 'Active yesterday';
      }
    }
    return '${myChatEntity.recentTextMessage}';
  }






  _noChatChannels() {
    return Column(
      children: [
        Center(
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(color: Colors.black.withOpacity(.1), shape: BoxShape.circle),
            child: Icon(
              Icons.message,
              size: 110,
              color: Colors.black.withOpacity(.5),
            ),
          ),
        )
      ],
    );
  }
}
