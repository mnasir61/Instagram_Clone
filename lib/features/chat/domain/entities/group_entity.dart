import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GroupEntity extends Equatable {
  final String? groupChatName;
  final Timestamp? createdAt;
  final String? channelId;
  final String? groupChatImageUrl;
  final String? lastMessage;
  final String? messageType;
  final String? uid;

  GroupEntity(
      {this.groupChatName,
      this.groupChatImageUrl,
      this.uid,
      this.createdAt,
      this.channelId,
      this.lastMessage,
      this.messageType});

  @override
  List<Object?> get props =>
      [groupChatName, groupChatImageUrl, uid, createdAt, channelId, lastMessage, messageType];
}
