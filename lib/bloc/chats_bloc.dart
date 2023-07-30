import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:project_chat/helper.dart';
import 'package:project_chat/models/chatroom.dart';

import '../models/chat.dart';
import '../resource/api_repository.dart';

part 'chats_event.dart';

part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  StreamSubscription? streamListen;
  final ApiRepository apiRepository = ApiRepository();

  @override
  Future<void> close() async {
    streamListen?.cancel().then((value) => logger.v("closed"));
    return super.close();
  }

  ChatsBloc() : super(const ChatsInitial()) {
    on<ChatStreamed>(_onChatStreamed);
    on<ChatLoaded>(_onChatLoaded);
    // on<SendChatMessage>(_onSendingChat);
    on<InitializingChats>(_onInitializingChat);
  }

  // Future<void> _onSendingChat(
  //     SendChatMessage event, Emitter<ChatsState> emit) async {
  //   try {
  //     await apiRepository.sendChat(event.chatRoom, event.message);
  //     // if (state is ChatsLoaded) {
  //     //   // final state = this.state as ChatsLoaded;
  //     //   final cList = await apiRepository.fetchChats(event.chatRoom.id);
  //     //   emit(ChatsLoaded(cList));
  //     // }
  //     // if (mList.error != null) {
  //     //   emit(ChatRoomError(mList.error));
  //     // }
  //   } on NetworkError {
  //     emit(const ChatsError("Failed to fetch data. is your device online?"));
  //   }
  // }

  Future<void> _onChatLoaded(ChatLoaded event, Emitter<ChatsState> emit) async {
    try {
      emit(ChatsLoading());
      final cList = await apiRepository.fetchChats(event.chatRoomId);
      emit(ChatsLoaded(cList));
      streamListen =
          apiRepository.steamChatChanges(event.chatRoomId).snapshots().listen(
                (event) {
              logger.v('Streamed');
              if (!isClosed) {
                add(ChatStreamed(event.docs.map((e) => e.data()).toList()));
              }
            },
          );
      // if (mList.error != null) {
      //   emit(ChatRoomError(mList.error));
      // }
    } on NetworkError {
      emit(const ChatsError("Failed to fetch data. is your device online?"));
    }
  }

  void _onChatStreamed(ChatStreamed event,
      Emitter<ChatsState> emit,) {
    if (state is ChatsLoaded) {
      emit(ChatsLoaded(event.chats));
    }
    // if (mList.error != null) {
    //   emit(ChatRoomError(mList.error));
    // }
  }

  Future<FutureOr<void>> _onInitializingChat(InitializingChats event,
      Emitter<ChatsState> emit) async {
    emit(ChatsLoading());

    ChatRoom chatRoom = await apiRepository.initChat(event.member);
    emit(ChatsInitialized(chatRoom: chatRoom));
  }
}
