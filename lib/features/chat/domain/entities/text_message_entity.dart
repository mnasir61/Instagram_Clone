import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TextMessageEntity extends Equatable {
  //sender detail
  final String? senderName;
  final String? senderUid;
  final String? senderImageUrl;

  //recipient detail
  final String? recipientName;
  final String? recipientUid;
  final String? recipientImageUrl;

  //replies detail
  final String? repliedTo;
  final String? repliedMessage;
  final String? repliedMessageType;

  final String? messageType;
  final String? content;
  final Timestamp? time;
  final String? messageId;
  final bool? isSeen;

  TextMessageEntity(
      {this.senderName,
      this.senderUid,
      this.senderImageUrl,
      this.recipientName,
      this.recipientUid,
      this.recipientImageUrl,
      this.messageType,
      this.content,
      this.time,
      this.messageId,
      this.isSeen,
      this.repliedTo,
      this.repliedMessage,
      this.repliedMessageType});

  @override
  List<Object?> get props => [
        senderName,
        senderUid,
        senderImageUrl,
        recipientName,
        recipientUid,
        recipientImageUrl,
        messageType,
        content,
        time,
        messageId,
        isSeen,
        repliedTo,
        repliedMessage,
        repliedMessageType
      ];
}
