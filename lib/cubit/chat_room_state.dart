part of 'chat_room_cubit.dart';

enum Status { initial, loading, success, failure }

extension StatusX on Status {
  bool get isInitial => this == Status.initial;

  bool get isLoading => this == Status.loading;

  bool get isSuccess => this == Status.success;

  bool get isFailure => this == Status.failure;
}

@freezed
class ChatRoomState with _$ChatRoomState {
  const factory ChatRoomState.initial({
    int? selectedIndex,
    ChatRoom? chatRoom,
    @Default(Status.initial) Status status,
  }) = _Initial;
}
