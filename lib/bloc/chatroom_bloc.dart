import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_chat/bloc/chats_bloc.dart';
import 'package:project_chat/models/chatroom.dart';
import 'package:project_chat/resource/api_repository.dart';

part 'chatroom_event.dart';

part 'chatroom_state.dart';

class ChatroomBloc extends Bloc<ChatroomEvent, ChatroomState> {
  StreamSubscription? subscription;
  final ChatsBloc chatBloc = ChatsBloc();

  ChatroomBloc() : super(ChatroomInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<StreamChatRoomList>((event, emit) async {
      try {
        emit(
          ChatRoomLoaded(event.chatRoomList),
        );
      } on NetworkError {
        emit(const ChatRoomError(
            "Failed to fetch data. is your device online?"));
      }
    });
    on<GetChatList>((event, emit) async {
      try {
        emit(ChatRoomLoading());
        final mList = await apiRepository.fetchChatRooms();
        emit(ChatRoomLoaded(mList));
        // if (mList.error != null) {
        //   emit(ChatRoomError(mList.error));
        // }
      } on NetworkError {
        emit(const ChatRoomError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }

  void dispose() {}
}
