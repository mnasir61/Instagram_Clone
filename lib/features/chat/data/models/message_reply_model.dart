import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/chat/domain/entities/message_reply_entity.dart';

class MessageReplyModel extends MessageReplyEntity {
  final String? message;
  final String? username;
  final String? messageType;
  final bool? isMe;

  MessageReplyModel({
    this.message,
    this.username,
    this.messageType,
    this.isMe,
  }) : super(
          message: message,
          username: username,
          messageType: messageType,
          isMe: isMe,
        );

  factory MessageReplyModel.fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return MessageReplyModel(
      message: snap["message"],
      username: snap["username"],
      messageType: snap["messageType"],
      isMe: snap["isMe"],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "message": message,
      "username": username,
      "messageType": messageType,
      "isMe": isMe,
    };
  }
}
