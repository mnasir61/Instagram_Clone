

import 'package:instagram_clone/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:instagram_clone/features/chat/domain/entities/group_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/my_chat_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/text_message_entity.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource{
  @override
  Future<void> createOneToOneChatChannel(MyChatEntity myChatEntity) {
    // TODO: implement createOneToOneChatChannel
    throw UnimplementedError();
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
  Future<void> deleteSingleMessage(String messageId) {
    // TODO: implement deleteSingleMessage
    throw UnimplementedError();
  }

  @override
  Stream<List<MyChatEntity>> getChats() {
    // TODO: implement getChats
    throw UnimplementedError();
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
    // TODO: implement getMessages
    throw UnimplementedError();
  }

  @override
  Future<void> sendTextMessage(TextMessageEntity textMessageEntity, String channelId) {
    // TODO: implement sendTextMessage
    throw UnimplementedError();
  }

  @override
  Future<void> updateGroupChat(GroupEntity groupEntity) {
    // TODO: implement updateGroupChat
    throw UnimplementedError();
  }
  
}