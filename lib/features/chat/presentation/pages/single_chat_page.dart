import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/app_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/engaged_user_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/text_message_entity.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/get_channel_id_usecase.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/get_messages_usecase.dart';
import 'package:instagram_clone/features/chat/presentation/cubit/communication/communication_cubit.dart';
import 'package:instagram_clone/features/chat/presentation/widgets/chat_text_fom_widget.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_other_single_user_usecase.dart';
import 'package:instagram_clone/features/user/domain/use_cases/get_single_user_usecase.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class SingleChatPage extends StatefulWidget {
  final AppEntity appEntity;

  const SingleChatPage({Key? key, required this.appEntity});

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  TextEditingController _messageController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  String _channelId = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getChannelId();
    });
  }

  void _getChannelId() async {
    if (widget.appEntity.channelId == null || widget.appEntity.channelId == "") {
      final channelId = await di.sl<GetChannelIdUseCase>().call(EngagedUserEntity(
            uid: widget.appEntity.senderUid,
            otherUid: widget.appEntity.recipientUid,
          ));
      if (mounted) {
        setState(() {
          _channelId = channelId;
        });
      }
      BlocProvider.of<CommunicationCubit>(context).getMessages(channelId: channelId);
    } else {
      BlocProvider.of<CommunicationCubit>(context).getMessages(channelId: widget.appEntity.channelId!);
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: StreamBuilder<List<UserEntity>>(
          stream: di.sl<GetSingleUserUseCase>().call(widget.appEntity.recipientUid!),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            }
            if (snapshot.hasData) {
              final otherUserData = snapshot.data!.first;
              final activeStatus = getActiveStatus(otherUserData);
              return Scaffold(
                appBar: AppBar(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: profileWidget(imageUrl: "${otherUserData.profileUrl}"),
                            ),
                          ),
                          if (otherUserData.isOnline == true)
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
                      horizontalSize(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * .3,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "${otherUserData.fullName}",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            "$activeStatus",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(.5)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 5),
                        child: Icon(CupertinoIcons.phone),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          FluentIcons.video_48_regular,
                          size: 26,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0, left: 10),
                        child: Icon(CupertinoIcons.flag),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: profileWidget(
                                  imageUrl: otherUserData.profileUrl,
                                ),
                              ),
                            ),
                            verticalSize(5),
                            Text(
                              "${otherUserData.fullName}",
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            verticalSize(5),
                            Text(
                              "${otherUserData.username} · Instagram",
                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${otherUserData.totalFollowers} followers · ",
                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                                ),
                                Text(
                                  "${otherUserData.totalPosts} posts",
                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                                ),
                              ],
                            ),
                            BlocBuilder<CommunicationCubit, CommunicationState>(
                              builder: (context, communicationState) {
                                if (communicationState is CommunicationLoaded) {
                                  final messages = communicationState.messages;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    controller: _scrollController,
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    itemCount: messages.length,
                                    physics: ScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final singleMessage = messages[index];

                                      return singleMessage.senderUid == widget.appEntity.senderUid
                                          ? Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 5),
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                            color: colorBlue,
                                          ),
                                          child: Text(
                                            "${singleMessage.content}",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                          : Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 5),
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                            color: Colors.grey.withOpacity(.4),
                                          ),
                                          child: Text("${singleMessage.content}"),
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
                          ],
                        ),
                      ),
                    ),
                    ChatTextFormWidget(
                      controller: _messageController,
                      textInputAction: TextInputAction.send,
                      onFieldSubmit: (value) {
                        _sendTextMessage();
                      },
                    ),
                  ],
                ),

              );
            }
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }

  _messageList(List<TextMessageEntity> messages) {
    if (_scrollController.hasClients) {
      Timer(Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });
    }

    messages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemCount: messages.length,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              final singleMessage = messages[index];

              return singleMessage.senderUid == widget.appEntity.senderUid
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: colorBlue,
                        ),
                        child: Text(
                          "${singleMessage.content}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.grey.withOpacity(.4),
                        ),
                        child: Text("${singleMessage.content}"),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }

  _sendTextMessage() {
    if (_messageController.text.isEmpty) {
      //TODO: send MessageType Voice/call
    } else {
      BlocProvider.of<CommunicationCubit>(context)
          .sendTextMessage(
        textMessage: TextMessageEntity(
          createdAt: Timestamp.now(),
          content: _messageController.text,
          senderName: widget.appEntity.senderName,
          senderUid: widget.appEntity.senderUid,
          senderImageUrl: widget.appEntity.senderProfileUrl,
          recipientName: widget.appEntity.recipientName,
          recipientUid: widget.appEntity.recipientUid,
          recipientImageUrl: widget.appEntity.recipientProfileUrl,
          messageType: "text",
          isSeen: false,
        ),
        channelId: _channelId,
      )
          .then((value) {
        _clear();
      });
    }
  }

  void _clear() {
    setState(() {
      _messageController.clear();
    });
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

  Widget _messageLayout({
    required String text,
    required String time,
    required Color color,
    required TextAlign align,
    required CrossAxisAlignment boxAlign,
    required CrossAxisAlignment crossAlign,
    required String name,
    required TextAlign alignName,
    required BubbleNip nip,
  }) {
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.90,
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(3),
            child: Bubble(
              color: color,
              nip: nip,
              child: Column(
                crossAxisAlignment: crossAlign,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$name",
                    textAlign: alignName,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    text,
                    textAlign: align,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    time,
                    textAlign: align,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(
                        .4,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _messageListWidget(List<TextMessageEntity> messages) {
    if (_scrollController.hasClients) {
      Timer(Duration(milliseconds: 100), () {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      });
    }

    return Expanded(
        child: ListView.builder(
      itemCount: messages.length,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) {
        final singleMessage = messages[index];

        if (singleMessage.senderUid == widget.appEntity.senderUid)
          return _messageLayout(
            name: "Me",
            alignName: TextAlign.end,
            color: Colors.lightGreen,
            time: DateFormat('hh:mm a').format(singleMessage.createdAt!.toDate()),
            align: TextAlign.left,
            nip: BubbleNip.rightTop,
            boxAlign: CrossAxisAlignment.start,
            crossAlign: CrossAxisAlignment.end,
            text: singleMessage.content!,
          );
        else
          return _messageLayout(
            color: Colors.white,
            nip: BubbleNip.leftTop,
            name: "${singleMessage.senderName}",
            alignName: TextAlign.end,
            time: DateFormat('hh:mm a').format(singleMessage.createdAt!.toDate()),
            align: TextAlign.left,
            boxAlign: CrossAxisAlignment.start,
            crossAlign: CrossAxisAlignment.start,
            text: singleMessage.content!,
          );
      },
    ));
  }
}
