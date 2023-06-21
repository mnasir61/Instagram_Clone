import 'package:instagram_clone/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:instagram_clone/features/chat/domain/entities/group_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/my_chat_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/text_message_entity.dart';
import 'package:instagram_clone/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createOneToOneChatChannel(MyChatEntity myChatEntity) async =>
      remoteDataSource.createOneToOneChatChannel(myChatEntity);

  @override
  Future<void> deleteGroupChatChannel(String channelId) async =>
      remoteDataSource.deleteGroupChatChannel(channelId);

  @override
  Future<void> deleteOneToOneChatChannel(String channelId) async =>
      remoteDataSource.deleteOneToOneChatChannel(channelId);

  @override
  Future<void> deleteSingleMessage(String messageId) async =>
      remoteDataSource.deleteSingleMessage(messageId);

  @override
  Stream<List<MyChatEntity>> getChats() => remoteDataSource.getChats();

  @override
  Future<void> getCreateGroupChat(GroupEntity groupEntity) async =>
      remoteDataSource.getCreateGroupChat(groupEntity);

  @override
  Stream<List<GroupEntity>> getGroups() => remoteDataSource.getGroups();

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) =>
      remoteDataSource.getMessages(channelId);

  @override
  Future<void> sendTextMessage(TextMessageEntity textMessageEntity, String channelId) async =>
      remoteDataSource.sendTextMessage(textMessageEntity, channelId);

  @override
  Future<void> updateGroupChat(GroupEntity groupEntity) async =>
      remoteDataSource.updateGroupChat(groupEntity);
}
