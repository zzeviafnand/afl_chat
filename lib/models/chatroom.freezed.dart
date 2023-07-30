// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chatroom.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) {
  return _ChatRoom.fromJson(json);
}

/// @nodoc
mixin _$ChatRoom {
  String get id => throw _privateConstructorUsedError;
  List<String> get members => throw _privateConstructorUsedError;
  String get lastChat => throw _privateConstructorUsedError;
  int? get unreadMessage => throw _privateConstructorUsedError;
  dynamic get lastInteraction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatRoomCopyWith<ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomCopyWith<$Res> {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) then) =
      _$ChatRoomCopyWithImpl<$Res, ChatRoom>;
  @useResult
  $Res call(
      {String id,
      List<String> members,
      String lastChat,
      int? unreadMessage,
      dynamic lastInteraction});
}

/// @nodoc
class _$ChatRoomCopyWithImpl<$Res, $Val extends ChatRoom>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? members = null,
    Object? lastChat = null,
    Object? unreadMessage = freezed,
    Object? lastInteraction = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastChat: null == lastChat
          ? _value.lastChat
          : lastChat // ignore: cast_nullable_to_non_nullable
              as String,
      unreadMessage: freezed == unreadMessage
          ? _value.unreadMessage
          : unreadMessage // ignore: cast_nullable_to_non_nullable
              as int?,
      lastInteraction: freezed == lastInteraction
          ? _value.lastInteraction
          : lastInteraction // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatRoomCopyWith<$Res> implements $ChatRoomCopyWith<$Res> {
  factory _$$_ChatRoomCopyWith(
          _$_ChatRoom value, $Res Function(_$_ChatRoom) then) =
      __$$_ChatRoomCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      List<String> members,
      String lastChat,
      int? unreadMessage,
      dynamic lastInteraction});
}

/// @nodoc
class __$$_ChatRoomCopyWithImpl<$Res>
    extends _$ChatRoomCopyWithImpl<$Res, _$_ChatRoom>
    implements _$$_ChatRoomCopyWith<$Res> {
  __$$_ChatRoomCopyWithImpl(
      _$_ChatRoom _value, $Res Function(_$_ChatRoom) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? members = null,
    Object? lastChat = null,
    Object? unreadMessage = freezed,
    Object? lastInteraction = freezed,
  }) {
    return _then(_$_ChatRoom(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastChat: null == lastChat
          ? _value.lastChat
          : lastChat // ignore: cast_nullable_to_non_nullable
              as String,
      unreadMessage: freezed == unreadMessage
          ? _value.unreadMessage
          : unreadMessage // ignore: cast_nullable_to_non_nullable
              as int?,
      lastInteraction: freezed == lastInteraction
          ? _value.lastInteraction
          : lastInteraction // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatRoom extends _ChatRoom {
  const _$_ChatRoom(
      {required this.id,
      required final List<String> members,
      required this.lastChat,
      this.unreadMessage,
      this.lastInteraction})
      : _members = members,
        super._();

  factory _$_ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$$_ChatRoomFromJson(json);

  @override
  final String id;
  final List<String> _members;
  @override
  List<String> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final String lastChat;
  @override
  final int? unreadMessage;
  @override
  final dynamic lastInteraction;

  @override
  String toString() {
    return 'ChatRoom(id: $id, members: $members, lastChat: $lastChat, unreadMessage: $unreadMessage, lastInteraction: $lastInteraction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatRoom &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.lastChat, lastChat) ||
                other.lastChat == lastChat) &&
            (identical(other.unreadMessage, unreadMessage) ||
                other.unreadMessage == unreadMessage) &&
            const DeepCollectionEquality()
                .equals(other.lastInteraction, lastInteraction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_members),
      lastChat,
      unreadMessage,
      const DeepCollectionEquality().hash(lastInteraction));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatRoomCopyWith<_$_ChatRoom> get copyWith =>
      __$$_ChatRoomCopyWithImpl<_$_ChatRoom>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatRoomToJson(
      this,
    );
  }
}

abstract class _ChatRoom extends ChatRoom {
  const factory _ChatRoom(
      {required final String id,
      required final List<String> members,
      required final String lastChat,
      final int? unreadMessage,
      final dynamic lastInteraction}) = _$_ChatRoom;
  const _ChatRoom._() : super._();

  factory _ChatRoom.fromJson(Map<String, dynamic> json) = _$_ChatRoom.fromJson;

  @override
  String get id;
  @override
  List<String> get members;
  @override
  String get lastChat;
  @override
  int? get unreadMessage;
  @override
  dynamic get lastInteraction;
  @override
  @JsonKey(ignore: true)
  _$$_ChatRoomCopyWith<_$_ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}
