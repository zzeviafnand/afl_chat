import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project_chat/models/chatroom.dart';
import 'package:project_chat/resource/api_repository.dart';

part 'chat_room_state.dart';

part 'chat_room_cubit.freezed.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomCubit() : super(const ChatRoomState.initial());
  final ApiRepository apiRepository = ApiRepository();

  Future<void> initializeChat(List<String> member, int index) async {
    try {
      emit(state.copyWith(status: Status.loading, selectedIndex: index));
      ChatRoom chatRoom = await apiRepository.initChat(member);
      emit(state.copyWith(status: Status.success, chatRoom: chatRoom));
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("error $error\nstacktrace:$stackTrace");
      }
      emit(state.copyWith(status: Status.failure));
    }
  }
}
