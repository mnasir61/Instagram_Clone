import 'package:instagram_clone/features/chat/domain/entities/engaged_user_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/group_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/my_chat_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/text_message_entity.dart';

abstract class ChatRemoteDataSource {
  //SingleChat
  Future<void> addToMyChat(MyChatEntity myChat);

  Future<String> createOneToOneChatChannel(EngagedUserEntity engagedUserEntity);

  Stream<List<MyChatEntity>> getMyChats(String uid);
  Future<void> updateMyChat(MyChatEntity myChatEntity);


  Future<void> deleteOneToOneChatChannel(String channelId, MyChatEntity myChatEntity);

  //TextMessage
  Future<void> sendTextMessage(TextMessageEntity textMessageEntity, String channelId);

  Stream<List<TextMessageEntity>> getMessages(String channelId);

  Future<void> deleteSingleMessage(String messageId);

  //GroupChat
  Future<void> getCreateGroupChat(GroupEntity groupEntity);

  Future<void> updateGroupChat(GroupEntity groupEntity);

  Future<void> deleteGroupChatChannel(String channelId);

  Stream<List<GroupEntity>> getGroups();

  //
  Future<String> getChannelId(EngagedUserEntity engagedUserEntity);
}
