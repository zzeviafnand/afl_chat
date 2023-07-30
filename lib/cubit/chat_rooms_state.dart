part of 'chat_rooms_cubit.dart';

enum Status {
  initial,
  loading,
  loadedFromNetwork,
  loadedFromStorage,
  failure,
  storageEmpty,
  onlineDataEmpty,
}

extension StatusX on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isLoadedFromStorage => this == Status.loadedFromStorage;
  bool get isLoadedFromNetwork => this == Status.loadedFromNetwork;
  bool get isFailure => this == Status.failure;
  bool get isStorageEmpty => this == Status.storageEmpty;
  bool get isOnlineDataEmpty => this == Status.onlineDataEmpty;
}

@freezed
class ChatRoomsState with _$ChatRoomsState {
  const factory ChatRoomsState({
    @JsonKey(fromJson: _fromJson, toJson: _toJson)
    @Default([])
        List<ChatRoom> chatRooms,
    @Default(Status.initial)
        Status status,
    @Default("No Message")
        String message,
    @Default("No Detailed Message")
        String detailedMessage,
  }) = _Initial;

  factory ChatRoomsState.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomsStateFromJson(json);
}

List<ChatRoom> _fromJson(value) {
  return (value as List).map((e) => (ChatRoom.fromJson(e))).toList();
}

List<Map<String, dynamic>> _toJson(List<ChatRoom>? value) {
  if (value == null) {
    return [];
  } else {
    return value.map(
      (ChatRoom e) {
        return e.toJson();
      },
    ).toList();
  }
}
