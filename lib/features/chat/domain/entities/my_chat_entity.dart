import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MyChatEntity extends Equatable {
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

  MyChatEntity(
      {this.senderUid,
      this.senderName,
      this.senderProfileUrl,
      this.recipientUid,
      this.recipientName,
      this.recipientProfileUrl,
      this.createdAt,
      this.channelId,
      this.lastMessage,
      this.messageType,
      this.recentTextMessage,
      this.totalUnreadMessage,
      this.isRead,
      this.isArchived,
      this.isDeleted});

  @override
  List<Object?> get props => [
        this.senderUid,
        senderName,
        senderProfileUrl,
        recipientUid,
        recipientName,
        recipientProfileUrl,
        createdAt,
        channelId,
        lastMessage,
        messageType,
        recentTextMessage,
        totalUnreadMessage,
        isRead,
        isArchived,
        isDeleted
      ];
}
