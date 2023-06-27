import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/chat/domain/entities/engaged_user_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/my_chat_entity.dart';
import 'package:instagram_clone/features/chat/domain/entities/text_message_entity.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/add_to_my_chat_usecasae.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/create_one_to_one_chat_usecase.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/delete_one_to_one_chat_channel.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/delete_single_message.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/get_channel_id_usecase.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/get_messages_usecase.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/get_my_chats_usecase.dart';
import 'package:instagram_clone/features/chat/domain/use_cases/send_text_message_usecase.dart';

part 'communication_state.dart';

class CommunicationCubit extends Cubit<CommunicationState> {
  final AddToMyChatUseCase addToMyChatUseCase;
  final SendTextMessageUseCase sendTextMessageUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final DeleteSingleMessageUseCase deleteSingleMessageUseCase;

  final CreateOneToOneChatUseCase createOneToOneChatUseCase;
  final DeleteOneToOneChatChannelUseCase deleteOneToOneChatChannelUseCase;
  final GetChannelIdUseCase getChannelIdUseCase;
  final GetMyChatUseCase getMyChatUseCase;

  CommunicationCubit(
      {required this.addToMyChatUseCase,
      required this.createOneToOneChatUseCase,
      required this.deleteOneToOneChatChannelUseCase,
      required this.deleteSingleMessageUseCase,
      required this.getChannelIdUseCase,
      required this.getMessagesUseCase,
      required this.getMyChatUseCase,
      required this.sendTextMessageUseCase})
      : super(CommunicationInitial());

  Future<void> sendTextMessage(
      {required TextMessageEntity textMessage, required String channelId}) async {
    try {
      String recentTextMessage = "";
      switch (textMessage.messageType) {
        case "photoMessage":
          recentTextMessage = "Photo";
          break;
        case "videoMessage":
          recentTextMessage = "Video";
          break;
        case "audioMessage":
          recentTextMessage = "Audio";
          break;
        case "gifMessage":
          recentTextMessage = "GIF";
          break;
        default:
          recentTextMessage = textMessage.content!;
      }
      await sendTextMessageUseCase.call(textMessage, channelId);
      await addToMyChatUseCase.call(MyChatEntity(
        senderName: textMessage.senderName,
        senderUid: textMessage.senderUid,
        senderProfileUrl: textMessage.senderImageUrl,
        recipientName: textMessage.recipientName,
        recipientUid: textMessage.recipientUid,
        recipientProfileUrl: textMessage.recipientImageUrl,
        createdAt: Timestamp.now(),
        recentTextMessage: recentTextMessage == "" ? textMessage.content : recentTextMessage,
        isRead: false,
        isDeleted: false,
        isArchived: false,
        channelId: channelId,
        totalUnreadMessage: 0,
      ));

    } on SocketException {
      emit(CommunicationFailure());
    } catch (e) {
      emit(CommunicationFailure());
    }
  }

  Future<void> getMessages({required String channelId}) async {
    emit(CommunicationLoading());
    try {
      final messageStreamData = getMessagesUseCase.call(channelId);
      messageStreamData.listen((messages) {
        emit(CommunicationLoaded(messages: messages));
      });
    } on SocketException {
      emit(CommunicationFailure());
    } catch (e) {
      emit(CommunicationFailure());
    }
  }

  Future<void> deleteSingleMessage({required String messageId}) async {
    try {
      await deleteSingleMessageUseCase.call(messageId);
    } on SocketException {
      emit(CommunicationFailure());
    } catch (e) {
      emit(CommunicationFailure());
    }
  }

  Future<void> createChatChannel({required EngagedUserEntity engagedUserEntity}) async {
    try {
      await createOneToOneChatUseCase.call(engagedUserEntity);
    } on SocketException {
      emit(CommunicationFailure());
    } catch (e) {
      emit(CommunicationFailure());
    }
  }
}
