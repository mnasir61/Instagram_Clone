import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/chat/domain/entities/group_entity.dart';

class GroupModel extends GroupEntity {
  final String? groupChatName;
  final Timestamp? createdAt;
  final String? channelId;
  final String? groupChatImageUrl;
  final String? lastMessage;
  final String? messageType;
  final String? uid;

  GroupModel({
    this.groupChatName,
    this.createdAt,
    this.channelId,
    this.groupChatImageUrl,
    this.lastMessage,
    this.messageType,
    this.uid,
  }) : super(
            groupChatName: groupChatName,
            createdAt: createdAt,
            channelId: channelId,
            groupChatImageUrl: groupChatImageUrl,
            lastMessage: lastMessage,
            messageType: messageType,
            uid: uid);

  factory GroupModel.fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return GroupModel(
      groupChatName: snap["groupChatName"],
      createdAt: snap["createdAt"],
      channelId: snap["channelId"],
      groupChatImageUrl: snap["groupChatImageUrl"],
      lastMessage: snap["lastMessage"],
      messageType: snap["messageType"],
      uid: snap["uid"],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "groupChatName": groupChatName,
      "createdAt": createdAt,
      "channelId": channelId,
      "groupChatImageUrl": groupChatImageUrl,
      "lastMessage": lastMessage,
      "messageType": messageType,
      "uid": uid,
    };
  }
}
