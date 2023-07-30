// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_rooms_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatRoomsState _$ChatRoomsStateFromJson(Map<String, dynamic> json) {
  return _Initial.fromJson(json);
}

/// @nodoc
mixin _$ChatRoomsState {
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  List<ChatRoom> get chatRooms => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get detailedMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatRoomsStateCopyWith<ChatRoomsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomsStateCopyWith<$Res> {
  factory $ChatRoomsStateCopyWith(
          ChatRoomsState value, $Res Function(ChatRoomsState) then) =
      _$ChatRoomsStateCopyWithImpl<$Res, ChatRoomsState>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _fromJson, toJson: _toJson) List<ChatRoom> chatRooms,
      Status status,
      String message,
      String detailedMessage});
}

/// @nodoc
class _$ChatRoomsStateCopyWithImpl<$Res, $Val extends ChatRoomsState>
    implements $ChatRoomsStateCopyWith<$Res> {
  _$ChatRoomsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRooms = null,
    Object? status = null,
    Object? message = null,
    Object? detailedMessage = null,
  }) {
    return _then(_value.copyWith(
      chatRooms: null == chatRooms
          ? _value.chatRooms
          : chatRooms // ignore: cast_nullable_to_non_nullable
              as List<ChatRoom>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      detailedMessage: null == detailedMessage
          ? _value.detailedMessage
          : detailedMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $ChatRoomsStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: _fromJson, toJson: _toJson) List<ChatRoom> chatRooms,
      Status status,
      String message,
      String detailedMessage});
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$ChatRoomsStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRooms = null,
    Object? status = null,
    Object? message = null,
    Object? detailedMessage = null,
  }) {
    return _then(_$_Initial(
      chatRooms: null == chatRooms
          ? _value._chatRooms
          : chatRooms // ignore: cast_nullable_to_non_nullable
              as List<ChatRoom>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      detailedMessage: null == detailedMessage
          ? _value.detailedMessage
          : detailedMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Initial implements _Initial {
  const _$_Initial(
      {@JsonKey(fromJson: _fromJson, toJson: _toJson)
      final List<ChatRoom> chatRooms = const [],
      this.status = Status.initial,
      this.message = "No Message",
      this.detailedMessage = "No Detailed Message"})
      : _chatRooms = chatRooms;

  factory _$_Initial.fromJson(Map<String, dynamic> json) =>
      _$$_InitialFromJson(json);

  final List<ChatRoom> _chatRooms;
  @override
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  List<ChatRoom> get chatRooms {
    if (_chatRooms is EqualUnmodifiableListView) return _chatRooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatRooms);
  }

  @override
  @JsonKey()
  final Status status;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final String detailedMessage;

  @override
  String toString() {
    return 'ChatRoomsState(chatRooms: $chatRooms, status: $status, message: $message, detailedMessage: $detailedMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Initial &&
            const DeepCollectionEquality()
                .equals(other._chatRooms, _chatRooms) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.detailedMessage, detailedMessage) ||
                other.detailedMessage == detailedMessage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_chatRooms),
      status,
      message,
      detailedMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InitialToJson(
      this,
    );
  }
}

abstract class _Initial implements ChatRoomsState {
  const factory _Initial(
      {@JsonKey(fromJson: _fromJson, toJson: _toJson)
      final List<ChatRoom> chatRooms,
      final Status status,
      final String message,
      final String detailedMessage}) = _$_Initial;

  factory _Initial.fromJson(Map<String, dynamic> json) = _$_Initial.fromJson;

  @override
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  List<ChatRoom> get chatRooms;
  @override
  Status get status;
  @override
  String get message;
  @override
  String get detailedMessage;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
