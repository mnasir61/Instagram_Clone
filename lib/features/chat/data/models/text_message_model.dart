import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/chat/domain/entities/text_message_entity.dart';

class TextMessageModel extends TextMessageEntity {
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
  final Timestamp? createdAt;
  final String? messageId;
  final bool? isSeen;

  TextMessageModel(
      {this.senderName,
      this.senderUid,
      this.senderImageUrl,
      this.recipientName,
      this.recipientUid,
      this.recipientImageUrl,
      this.repliedTo,
      this.repliedMessage,
      this.repliedMessageType,
      this.messageType,
      this.content,
      this.createdAt,
      this.messageId,
      this.isSeen})
      : super(
          senderName: senderName,
          senderUid: senderUid,
          senderImageUrl: senderImageUrl,
          recipientName: recipientName,
          recipientUid: recipientUid,
          recipientImageUrl: recipientImageUrl,
          repliedTo: repliedTo,
          repliedMessage: repliedMessage,
          repliedMessageType: repliedMessageType,
          messageType: messageType,
          content: content,
    createdAt: createdAt,
          messageId: messageId,
          isSeen: isSeen,
        );

  factory TextMessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return TextMessageModel(
      senderName: snap["senderName"],
      senderUid: snap["senderUid"],
      senderImageUrl: snap["senderImageUrl"],
      recipientName: snap["recipientName"],
      recipientUid: snap["recipientUid"],
      recipientImageUrl: snap["recipientImageUrl"],
      repliedTo: snap["repliedTo"],
      repliedMessage: snap["repliedMessage"],
      repliedMessageType: snap["repliedMessageType"],
      messageType: snap["messageType"],
      content: snap["content"],
      createdAt: snap["createdAt"],
      messageId: snap["messageId"],
      isSeen: snap["isSeen"],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "senderName": senderName,
      "senderUid": senderUid,
      "senderImageUrl": senderImageUrl,
      "recipientName": recipientName,
      "recipientUid": recipientUid,
      "recipientImageUrl": recipientImageUrl,
      "repliedTo": repliedTo,
      "repliedMessageType": repliedMessageType,
      "repliedMessage": repliedMessage,
      "messageType": messageType,
      "content": content,
      "createdAt": createdAt,
      "messageId": messageId,
      "isSeen": isSeen,
    };
  }
}
