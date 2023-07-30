import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:project_chat/models/chat.dart';
import 'package:project_chat/resource/api_repository.dart';

import '../helper.dart';
import '../models/user_profile.dart';

part 'chats_state.dart';

part 'chats_cubit.freezed.dart';

part 'chats_cubit.g.dart';

class ChatsCubit extends HydratedCubit<ChatsState> {
  ChatsCubit() : super(const ChatsState());
  final ApiRepository apiRepository = ApiRepository();
  String? chatRoomId;
  Map<String, dynamic> storeJson = {};
  StreamSubscription? streamListen;

  Future<void> sendChat(UserProfile userProfile, chatRoom, message) async {
    await apiRepository.sendChat(userProfile, chatRoom, message);
  }

  Future<void> fetchChats(String chatRoomId) async {
    this.chatRoomId = chatRoomId;
    try {
      emit(state.copyWith(status: ChatsStatus.loading));

      // storeJson = {'chats': {}, ...storeJson};
      // Map<String, dynamic> storeChats =
      //     Map<String, dynamic>.from(storeJson['chats']);
      // storeChats = Map<String, dynamic>.from({...storeChats, chatRoomId: {}});
      var chats = await apiRepository.fetchChats(chatRoomId);
      if (chats.isEmpty) {
        // print("Chat di firebase kosong");
        // print("storeJson: ${storeJson.runtimeType}");
        // print("storeChats: ${storeChats.runtimeType}");

        // Map<String, dynamic> chatRoom =
        //     Map<String, dynamic>.from(storeChats[chatRoomId]);
        // print("chatRoom: $chatRoom");
        // var chats = await apiRepository.fetchChats(chatRoomId);
        // emit(state.copyWith(status: ChatsStatus.success, chats: chats));
      } else {
        // emit(state.copyWith(status: ChatsStatus.success, chats: chats));
      }
      streamListen =
          apiRepository.steamChatChanges(chatRoomId).snapshots().listen(
        (event) {
          logger.v('Streamed, length: ${event.docs.length}');
          if (!isClosed) {
            emit(state.copyWith(status: ChatsStatus.loading));
            emit(
              state.copyWith(
                  status: ChatsStatus.success,
                  chats: event.docs.map((e) => e.data()).toList()),
            );
          }
        },
      );
      // if (oldJson[chatRoomId] != null) {}
      // Clearing Internal Data when firestore cleared
      if (storeJson.isEmpty) {}
      if (state.status.isEmpty) {
        // emit(state.copyWith(status: ChatsStatus.loading));
        // var chats = await apiRepository.fetchChats(chatRoomId);
        // emit(
        //   state.copyWith(status: ChatsStatus.success, chats: chats),
        // );
      }
    } catch (e, s) {
      print(e);
      print(s);
      emit(state.copyWith(status: ChatsStatus.failure));
    }
  }

  @override
  Future<void> close() {
    streamListen?.cancel().then((value) => logger.v("Stream Closed"));
    return super.close();
  }

  @override
  ChatsState? fromJson(Map<String, dynamic> json) {
    return null;

    // storeJson = json;
    // return ChatsState.fromJson(json['chats']);
  }

  @override
  Map<String, dynamic>? toJson(ChatsState state) {
    return null;

    // var data;
    // if (storeJson.isNotEmpty) {
    //   data = {
    //     "chats": {...storeJson, chatRoomId!: state.toJson()}
    //   };
    // } else {
    //   data = {
    //     "chats": {chatRoomId!: state.toJson()}
    //   };
    // }
    // // print(data);
    // if (chatRoomId != null) {
    //   if (state.status == ChatsStatus.success) {
    //     return data;
    //   }
    // }
  }
}
