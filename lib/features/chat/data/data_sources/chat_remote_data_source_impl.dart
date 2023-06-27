import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:instagram_clone/features/chat/data/models/my_chat_model.dart';
import 'package:instagram_clone/features/chat/data/models/text_message_model.dart';
import 'package:instagram_clone/features/chat/domain/entities/engaged_user_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/group_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/my_chat_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/text_message_entity.dart';
import 'package:instagram_clone/features/global/const/firebase_const.dart';
import 'package:instagram_clone/features/global/const/firebase_const.dart';
import 'package:instagram_clone/features/global/const/firebase_const.dart';
import 'package:instagram_clone/features/global/const/firebase_const.dart';
import 'package:instagram_clone/features/global/const/firebase_const.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore fireStore;

  ChatRemoteDataSourceImpl({required this.fireStore});

  @override
  Future<void> addToMyChat(MyChatEntity myChat) async {
    final myChatRef = fireStore
        .collection(FirebaseConst.users)
        .doc(myChat.senderUid)
        .collection(FirebaseConst.myChat);
    final otherChatRef = fireStore
        .collection(FirebaseConst.users)
        .doc(myChat.recipientUid)
        .collection(FirebaseConst.myChat);

    final myNewChat = MyChatModel(
      channelId: myChat.channelId,
      createdAt: myChat.createdAt,
      isDeleted: myChat.isDeleted,
      isRead: myChat.isRead,
      isArchived: myChat.isArchived,
      senderProfileUrl: myChat.senderProfileUrl,
      recipientProfileUrl: myChat.recipientProfileUrl,
      recentTextMessage: myChat.recentTextMessage,
      recipientName: myChat.recipientName,
      senderName: myChat.senderName,
      recipientUid: myChat.recipientUid,
      senderUid: myChat.senderUid,
      totalUnreadMessage: myChat.totalUnreadMessage,
    ).toDocument();

    final otherNewChat = MyChatModel(
      channelId: myChat.channelId,
      createdAt: myChat.createdAt,
      isDeleted: myChat.isDeleted,
      isRead: myChat.isRead,
      isArchived: myChat.isArchived,
      senderProfileUrl: myChat.recipientProfileUrl,
      recipientProfileUrl: myChat.senderProfileUrl,
      recentTextMessage: myChat.recentTextMessage,
      recipientName: myChat.senderName,
      senderName: myChat.recipientName,
      recipientUid: myChat.senderUid,
      senderUid: myChat.recipientUid,
      totalUnreadMessage: myChat.totalUnreadMessage,
    ).toDocument();

    myChatRef.doc(myChat.recipientUid).get().then((myChatDoc) {
      //Create
      if (!myChatDoc.exists) {
        myChatRef.doc(myChat.recipientUid).set(myNewChat);
        otherChatRef.doc(myChat.senderUid).set(otherNewChat);
      } else {
        myChatRef.doc(myChat.recipientUid).update(myNewChat);
        otherChatRef.doc(myChat.senderUid).update(otherNewChat);
        return;
      }
    });
  }


  @override
  Future<String> createOneToOneChatChannel(EngagedUserEntity engagedUserEntity) async {
    final userCollection = fireStore.collection(FirebaseConst.users);
    final oneToOneChatChannel = fireStore.collection(FirebaseConst.oneToOneChatChannel);

    final chatChannelDoc = await userCollection
        .doc(engagedUserEntity.uid)
        .collection(FirebaseConst.chatChannel)
        .doc(engagedUserEntity.otherUid)
        .get();

    if (!chatChannelDoc.exists) {
      final channelId = oneToOneChatChannel.doc().id;
      var channel = {"channelId": channelId};
      await oneToOneChatChannel.doc(channelId).set(channel);
      await userCollection
          .doc(engagedUserEntity.uid)
          .collection(FirebaseConst.chatChannel)
          .doc(engagedUserEntity.otherUid)
          .set(channel);
      await userCollection
          .doc(engagedUserEntity.otherUid)
          .collection(FirebaseConst.chatChannel)
          .doc(engagedUserEntity.uid)
          .set(channel);
      return channelId;
    }
    return "";
  }

  @override
  Future<void> deleteGroupChatChannel(String channelId) {
    // TODO: implement deleteGroupChatChannel
    throw UnimplementedError();
  }

  @override
  Future<void> deleteOneToOneChatChannel(String channelId) {
    // TODO: implement deleteOneToOneChatChannel
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSingleMessage(String messageId) async {
    final messagesRef = fireStore
        .collection(FirebaseConst.oneToOneChatChannel)
        .doc(EngagedUserEntity().channelId)
        .collection(FirebaseConst.messages)
        .doc(messageId);
    await messagesRef.delete();
  }

  @override
  Future<String> getChannelId(EngagedUserEntity engagedUserEntity) async {
    final userCollection = fireStore.collection(FirebaseConst.users);
    return userCollection
        .doc(engagedUserEntity.uid)
        .collection(FirebaseConst.chatChannel)
        .doc(engagedUserEntity.otherUid)
        .get()
        .then((engagedChatChannel) {
      if (engagedChatChannel.exists) {
        return engagedChatChannel.data()!["channelId"];
      }
      return engagedChatChannel.exists ? engagedChatChannel.data()!["channelId"] : null;

    });
  }

  @override
  Stream<List<MyChatEntity>> getMyChats(String uid) {
    final myCollection = fireStore
        .collection(FirebaseConst.users)
        .doc(uid)
        .collection(FirebaseConst.myChat)
        .orderBy("createdAt", descending: true);
    return myCollection
        .snapshots()
        .map((querySnap) => querySnap.docs.map((e) => MyChatModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> getCreateGroupChat(GroupEntity groupEntity) {
    // TODO: implement getCreateGroupChat
    throw UnimplementedError();
  }

  @override
  Stream<List<GroupEntity>> getGroups() {
    // TODO: implement getGroups
    throw UnimplementedError();
  }

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) {
    final messageCollection = fireStore
        .collection(FirebaseConst.oneToOneChatChannel)
        .doc(channelId)
        .collection(FirebaseConst.messages);
    return messageCollection.orderBy("createdAt")
        .snapshots()
        .map((querySnap) => querySnap.docs.map((e) => TextMessageModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> sendTextMessage(TextMessageEntity textMessageEntity, String channelId) async {
    final messagesCollection = fireStore
        .collection(FirebaseConst.oneToOneChatChannel)
        .doc(channelId)
        .collection(FirebaseConst.messages);

    final messageId = messagesCollection.doc().id;

    final newMessage = TextMessageModel(
      senderUid: textMessageEntity.senderUid,
      recipientUid: textMessageEntity.recipientUid,
      senderName: textMessageEntity.senderName,
      recipientName: textMessageEntity.recipientName,
      createdAt: textMessageEntity.createdAt,
      repliedTo: textMessageEntity.repliedTo,
      repliedMessage: textMessageEntity.repliedMessage,
      isSeen: textMessageEntity.isSeen,
      messageType: textMessageEntity.messageType,
      content: textMessageEntity.content,
      messageId: messageId,
      repliedMessageType: textMessageEntity.repliedMessageType,
    ).toDocument();

    try {
      await messagesCollection.doc(messageId).set(newMessage);
    } catch (e) {
      print("Error occur while sending text message");
    }
  }

  @override
  Future<void> updateGroupChat(GroupEntity groupEntity) {
    // TODO: implement updateGroupChat
    throw UnimplementedError();
  }
}
