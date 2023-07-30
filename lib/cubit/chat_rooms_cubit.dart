import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:project_chat/helper.dart';
import 'package:project_chat/models/chatroom.dart';
import 'package:project_chat/resource/api_repository.dart';

part 'chat_rooms_state.dart';

part 'chat_rooms_cubit.freezed.dart';

part 'chat_rooms_cubit.g.dart';

class ChatRoomsCubit extends Cubit<ChatRoomsState> {
  ChatRoomsCubit() : super(const ChatRoomsState());
  final ApiRepository apiRepository = ApiRepository();
  StreamSubscription? streamSubscription;

  Future<void> initialCheck() async {
    try {
      emit(state.copyWith(status: Status.loading));
      streamSubscription =
          apiRepository.streamChatRooms().snapshots().listen((event) {
        emit(
          state.copyWith(
            status: Status.loadedFromNetwork,
            chatRooms: event.docs.map((e) => e.data()).toList(),
          ),
        );
        logger.v(state);
      });
      // final chatRoomsFromStorage = [];
      // if (chatRoomsFromNetwork.isEmpty) {
      //   logger.v(state);
      // }
      // if (chatRoomsFromStorage.isEmpty) {
      //   emit(state.copyWith(status: Status.storageEmpty));
      //   if (chatRoomsFromNetwork.isEmpty) {
      //     emit(state.copyWith(status: Status.onlineDataEmpty));
      //   } else {
      //     emit(state.copyWith(
      //         status: Status.loadedFromNetwork,
      //         chatRooms: chatRoomsFromNetwork));
      //   }
      // } else {
      //   emit(state.copyWith(status: Status.loadedFromStorage));
      // }
      // logger.v(state);
    } catch (error, stackTrace) {
      emit(
        state.copyWith(
          status: Status.failure,
        ),
      );
      logger.e('Error Loading Chat Rooms', [error, stackTrace]);
    }
  }
//
// @override
// ChatRoomsState? fromJson(Map<String, dynamic> json) {
//   return ChatRoomsState.fromJson(json['chatRooms']);
// }
//
// @override
// Map<String, dynamic>? toJson(ChatRoomsState state) {
//   if (state.status.isLoadedFromNetwork || state.status.isLoadedFromStorage) {
//     return {'chatRooms': state.toJson()};
//   }
//   return null;
// }
}
