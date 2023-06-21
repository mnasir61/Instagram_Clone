import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/chat/domain/entities/my_chat_entity.dart';

class MyChatModel extends MyChatEntity {
  //sender
  final String? senderUid;
  final String? senderName;
  final String? senderProfileUrl;

  //recipient
  final String? recipientUid;
  final String? recipientName;
  final String? recipientProfileUrl;

  //other
  final Timestamp? createdAt;
  final String? channelId;
  final String? lastMessage;
  final String? messageType;
  final String? recentTextMessage;
  final num? totalUnreadMessage;
  final bool? isRead;
  final bool? isArchived;
  final bool? isDeleted;

  MyChatModel({
    this.senderUid,
    this.senderName,
    this.senderProfileUrl,
    this.recipientUid,
    this.recipientName,
    this.recipientProfileUrl,
    this.recentTextMessage,
    this.totalUnreadMessage,
    this.isRead,
    this.isArchived,
    this.isDeleted,
    this.createdAt,
    this.channelId,
    this.lastMessage,
    this.messageType,
  }) : super(
            createdAt: createdAt,
            channelId: channelId,
            lastMessage: lastMessage,
            messageType: messageType,
            isArchived: isArchived,
            isDeleted: isDeleted,
            isRead: isRead,
            recentTextMessage: recentTextMessage,
            recipientName: recipientName,
            recipientProfileUrl: recipientProfileUrl,
            recipientUid: recipientUid,
            senderName: senderName,
            senderProfileUrl: senderProfileUrl,
            senderUid: senderUid,
            totalUnreadMessage: totalUnreadMessage);

  factory MyChatModel.fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return MyChatModel(
      createdAt: snap["createdAt"],
      channelId: snap["channelId"],
      lastMessage: snap["lastMessage"],
      messageType: snap["messageType"],
      isArchived: snap["isArchived"],
      isDeleted: snap["isDeleted"],
      isRead: snap["isRead"],
      recentTextMessage: snap["recentTextMessage"],
      recipientName: snap["recipientName"],
      recipientProfileUrl: snap["recipientProfileUrl"],
      recipientUid: snap["recipientUid"],
      senderName: snap["senderName"],
      senderProfileUrl: snap["senderProfileUrl"],
      senderUid: snap["senderUid"],
      totalUnreadMessage: snap["totalUnreadMessage"],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "createdAt": createdAt,
      "channelId": channelId,
      "messageType": messageType,
      "lastMessage": lastMessage,
      "isArchived": isArchived,
      "isDeleted": isDeleted,
      "isRead": isRead,
      "recentTextMessage": recentTextMessage,
      "recipientName": recipientName,
      "recipientProfileUrl": recipientProfileUrl,
      "recipientUid": recipientUid,
      "senderName": senderName,
      "senderProfileUrl": senderProfileUrl,
      "senderUid": senderUid,
      "totalUnreadMessage": totalUnreadMessage,
    };
  }
}
