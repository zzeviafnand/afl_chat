part of 'chats_cubit.dart';

enum ChatsStatus { initial, empty, loading, success, failure }

extension ChatsStatusX on ChatsStatus {
  bool get isInitial => this == ChatsStatus.initial;
  bool get isEmpty => this == ChatsStatus.empty;
  bool get isLoading => this == ChatsStatus.loading;
  bool get isSuccess => this == ChatsStatus.success;
  bool get isFailure => this == ChatsStatus.failure;
}

@freezed
class ChatsState extends Equatable with _$ChatsState {
  const factory ChatsState({
    @Default(ChatsStatus.initial) ChatsStatus status,
    @JsonKey(fromJson: _fromJson, toJson: _toJson) List<Chat>? chats,
  }) = _ChatsState;
  const ChatsState._();

  factory ChatsState.fromJson(Map<String, dynamic> json) =>
      _$ChatsStateFromJson(json);

  @override
  List<Object?> get props => [status];
}

List<Chat> _fromJson(value) {
  return (value as List)
      .map((e) => (Chat.fromJson(e).copyWith(
          dateSent: Timestamp.fromMillisecondsSinceEpoch(e['dateSent']))))
      .toList();
}

List<Map<String, dynamic>> _toJson(List<Chat>? value) {
  if (value == null) {
    return [];
  } else {
    return value.map(
      (Chat e) {
        return e
            .copyWith(
                dateSent: (e.dateSent as Timestamp).millisecondsSinceEpoch)
            .toJson();
      },
    ).toList();
  }
}
