import 'package:equatable/equatable.dart';

class MessageReplyEntity extends Equatable {
  final String? message;
  final String? username;
  final String? messageType;
  final bool? isMe;

  MessageReplyEntity({this.message, this.username, this.messageType, this.isMe});

  @override
  List<Object?> get props => [message, username, messageType, isMe];
}
