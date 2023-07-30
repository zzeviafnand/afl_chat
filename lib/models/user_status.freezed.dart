// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserStatusModel _$UserStatusModelFromJson(Map<String, dynamic> json) {
  return _UserStatusModel.fromJson(json);
}

/// @nodoc
mixin _$UserStatusModel {
  String get uid => throw _privateConstructorUsedError;
  int get milisecondCreatedAt => throw _privateConstructorUsedError;
  String get statusText => throw _privateConstructorUsedError;
  String? get statusImageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserStatusModelCopyWith<UserStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatusModelCopyWith<$Res> {
  factory $UserStatusModelCopyWith(
          UserStatusModel value, $Res Function(UserStatusModel) then) =
      _$UserStatusModelCopyWithImpl<$Res, UserStatusModel>;
  @useResult
  $Res call(
      {String uid,
      int milisecondCreatedAt,
      String statusText,
      String? statusImageUrl});
}

/// @nodoc
class _$UserStatusModelCopyWithImpl<$Res, $Val extends UserStatusModel>
    implements $UserStatusModelCopyWith<$Res> {
  _$UserStatusModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? milisecondCreatedAt = null,
    Object? statusText = null,
    Object? statusImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      milisecondCreatedAt: null == milisecondCreatedAt
          ? _value.milisecondCreatedAt
          : milisecondCreatedAt // ignore: cast_nullable_to_non_nullable
              as int,
      statusText: null == statusText
          ? _value.statusText
          : statusText // ignore: cast_nullable_to_non_nullable
              as String,
      statusImageUrl: freezed == statusImageUrl
          ? _value.statusImageUrl
          : statusImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserStatusModelCopyWith<$Res>
    implements $UserStatusModelCopyWith<$Res> {
  factory _$$_UserStatusModelCopyWith(
          _$_UserStatusModel value, $Res Function(_$_UserStatusModel) then) =
      __$$_UserStatusModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      int milisecondCreatedAt,
      String statusText,
      String? statusImageUrl});
}

/// @nodoc
class __$$_UserStatusModelCopyWithImpl<$Res>
    extends _$UserStatusModelCopyWithImpl<$Res, _$_UserStatusModel>
    implements _$$_UserStatusModelCopyWith<$Res> {
  __$$_UserStatusModelCopyWithImpl(
      _$_UserStatusModel _value, $Res Function(_$_UserStatusModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? milisecondCreatedAt = null,
    Object? statusText = null,
    Object? statusImageUrl = freezed,
  }) {
    return _then(_$_UserStatusModel(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      milisecondCreatedAt: null == milisecondCreatedAt
          ? _value.milisecondCreatedAt
          : milisecondCreatedAt // ignore: cast_nullable_to_non_nullable
              as int,
      statusText: null == statusText
          ? _value.statusText
          : statusText // ignore: cast_nullable_to_non_nullable
              as String,
      statusImageUrl: freezed == statusImageUrl
          ? _value.statusImageUrl
          : statusImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserStatusModel extends _UserStatusModel {
  const _$_UserStatusModel(
      {required this.uid,
      this.milisecondCreatedAt = 0,
      this.statusText = "",
      this.statusImageUrl})
      : super._();

  factory _$_UserStatusModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserStatusModelFromJson(json);

  @override
  final String uid;
  @override
  @JsonKey()
  final int milisecondCreatedAt;
  @override
  @JsonKey()
  final String statusText;
  @override
  final String? statusImageUrl;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserStatusModelCopyWith<_$_UserStatusModel> get copyWith =>
      __$$_UserStatusModelCopyWithImpl<_$_UserStatusModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserStatusModelToJson(
      this,
    );
  }
}

abstract class _UserStatusModel extends UserStatusModel {
  const factory _UserStatusModel(
      {required final String uid,
      final int milisecondCreatedAt,
      final String statusText,
      final String? statusImageUrl}) = _$_UserStatusModel;
  const _UserStatusModel._() : super._();

  factory _UserStatusModel.fromJson(Map<String, dynamic> json) =
      _$_UserStatusModel.fromJson;

  @override
  String get uid;
  @override
  int get milisecondCreatedAt;
  @override
  String get statusText;
  @override
  String? get statusImageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_UserStatusModelCopyWith<_$_UserStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}
