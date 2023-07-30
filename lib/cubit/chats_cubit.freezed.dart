// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chats_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatsState _$ChatsStateFromJson(Map<String, dynamic> json) {
  return _ChatsState.fromJson(json);
}

/// @nodoc
mixin _$ChatsState {
  ChatsStatus get status => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  List<Chat>? get chats => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatsStateCopyWith<ChatsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatsStateCopyWith<$Res> {
  factory $ChatsStateCopyWith(
          ChatsState value, $Res Function(ChatsState) then) =
      _$ChatsStateCopyWithImpl<$Res, ChatsState>;
  @useResult
  $Res call(
      {ChatsStatus status,
      @JsonKey(fromJson: _fromJson, toJson: _toJson) List<Chat>? chats});
}

/// @nodoc
class _$ChatsStateCopyWithImpl<$Res, $Val extends ChatsState>
    implements $ChatsStateCopyWith<$Res> {
  _$ChatsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? chats = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ChatsStatus,
      chats: freezed == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<Chat>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatsStateCopyWith<$Res>
    implements $ChatsStateCopyWith<$Res> {
  factory _$$_ChatsStateCopyWith(
          _$_ChatsState value, $Res Function(_$_ChatsState) then) =
      __$$_ChatsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ChatsStatus status,
      @JsonKey(fromJson: _fromJson, toJson: _toJson) List<Chat>? chats});
}

/// @nodoc
class __$$_ChatsStateCopyWithImpl<$Res>
    extends _$ChatsStateCopyWithImpl<$Res, _$_ChatsState>
    implements _$$_ChatsStateCopyWith<$Res> {
  __$$_ChatsStateCopyWithImpl(
      _$_ChatsState _value, $Res Function(_$_ChatsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? chats = freezed,
  }) {
    return _then(_$_ChatsState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ChatsStatus,
      chats: freezed == chats
          ? _value._chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<Chat>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatsState extends _ChatsState {
  const _$_ChatsState(
      {this.status = ChatsStatus.initial,
      @JsonKey(fromJson: _fromJson, toJson: _toJson) final List<Chat>? chats})
      : _chats = chats,
        super._();

  factory _$_ChatsState.fromJson(Map<String, dynamic> json) =>
      _$$_ChatsStateFromJson(json);

  @override
  @JsonKey()
  final ChatsStatus status;
  final List<Chat>? _chats;
  @override
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  List<Chat>? get chats {
    final value = _chats;
    if (value == null) return null;
    if (_chats is EqualUnmodifiableListView) return _chats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatsStateCopyWith<_$_ChatsState> get copyWith =>
      __$$_ChatsStateCopyWithImpl<_$_ChatsState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatsStateToJson(
      this,
    );
  }
}

abstract class _ChatsState extends ChatsState {
  const factory _ChatsState(
      {final ChatsStatus status,
      @JsonKey(fromJson: _fromJson, toJson: _toJson)
      final List<Chat>? chats}) = _$_ChatsState;
  const _ChatsState._() : super._();

  factory _ChatsState.fromJson(Map<String, dynamic> json) =
      _$_ChatsState.fromJson;

  @override
  ChatsStatus get status;
  @override
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  List<Chat>? get chats;
  @override
  @JsonKey(ignore: true)
  _$$_ChatsStateCopyWith<_$_ChatsState> get copyWith =>
      throw _privateConstructorUsedError;
}
