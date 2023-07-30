// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserAuthState {
  AuthStatus get status => throw _privateConstructorUsedError;
  UserProfile? get userProfile => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get otp => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get verificationId => throw _privateConstructorUsedError;
  int? get resendToken => throw _privateConstructorUsedError;
  String? get detailedMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserAuthStateCopyWith<UserAuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAuthStateCopyWith<$Res> {
  factory $UserAuthStateCopyWith(
          UserAuthState value, $Res Function(UserAuthState) then) =
      _$UserAuthStateCopyWithImpl<$Res, UserAuthState>;
  @useResult
  $Res call(
      {AuthStatus status,
      UserProfile? userProfile,
      String? phoneNumber,
      String? otp,
      String? message,
      String? verificationId,
      int? resendToken,
      String? detailedMessage});

  $UserProfileCopyWith<$Res>? get userProfile;
}

/// @nodoc
class _$UserAuthStateCopyWithImpl<$Res, $Val extends UserAuthState>
    implements $UserAuthStateCopyWith<$Res> {
  _$UserAuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? userProfile = freezed,
    Object? phoneNumber = freezed,
    Object? otp = freezed,
    Object? message = freezed,
    Object? verificationId = freezed,
    Object? resendToken = freezed,
    Object? detailedMessage = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      userProfile: freezed == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      otp: freezed == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationId: freezed == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      resendToken: freezed == resendToken
          ? _value.resendToken
          : resendToken // ignore: cast_nullable_to_non_nullable
              as int?,
      detailedMessage: freezed == detailedMessage
          ? _value.detailedMessage
          : detailedMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res>? get userProfile {
    if (_value.userProfile == null) {
      return null;
    }

    return $UserProfileCopyWith<$Res>(_value.userProfile!, (value) {
      return _then(_value.copyWith(userProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserAuthStateCopyWith<$Res>
    implements $UserAuthStateCopyWith<$Res> {
  factory _$$_UserAuthStateCopyWith(
          _$_UserAuthState value, $Res Function(_$_UserAuthState) then) =
      __$$_UserAuthStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AuthStatus status,
      UserProfile? userProfile,
      String? phoneNumber,
      String? otp,
      String? message,
      String? verificationId,
      int? resendToken,
      String? detailedMessage});

  @override
  $UserProfileCopyWith<$Res>? get userProfile;
}

/// @nodoc
class __$$_UserAuthStateCopyWithImpl<$Res>
    extends _$UserAuthStateCopyWithImpl<$Res, _$_UserAuthState>
    implements _$$_UserAuthStateCopyWith<$Res> {
  __$$_UserAuthStateCopyWithImpl(
      _$_UserAuthState _value, $Res Function(_$_UserAuthState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? userProfile = freezed,
    Object? phoneNumber = freezed,
    Object? otp = freezed,
    Object? message = freezed,
    Object? verificationId = freezed,
    Object? resendToken = freezed,
    Object? detailedMessage = freezed,
  }) {
    return _then(_$_UserAuthState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      userProfile: freezed == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      otp: freezed == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationId: freezed == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      resendToken: freezed == resendToken
          ? _value.resendToken
          : resendToken // ignore: cast_nullable_to_non_nullable
              as int?,
      detailedMessage: freezed == detailedMessage
          ? _value.detailedMessage
          : detailedMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_UserAuthState implements _UserAuthState {
  const _$_UserAuthState(
      {this.status = AuthStatus.initial,
      this.userProfile,
      this.phoneNumber,
      this.otp,
      this.message,
      this.verificationId,
      this.resendToken,
      this.detailedMessage});

  @override
  @JsonKey()
  final AuthStatus status;
  @override
  final UserProfile? userProfile;
  @override
  final String? phoneNumber;
  @override
  final String? otp;
  @override
  final String? message;
  @override
  final String? verificationId;
  @override
  final int? resendToken;
  @override
  final String? detailedMessage;

  @override
  String toString() {
    return 'UserAuthState(status: $status, userProfile: $userProfile, phoneNumber: $phoneNumber, otp: $otp, message: $message, verificationId: $verificationId, resendToken: $resendToken, detailedMessage: $detailedMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserAuthState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.resendToken, resendToken) ||
                other.resendToken == resendToken) &&
            (identical(other.detailedMessage, detailedMessage) ||
                other.detailedMessage == detailedMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, userProfile, phoneNumber,
      otp, message, verificationId, resendToken, detailedMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserAuthStateCopyWith<_$_UserAuthState> get copyWith =>
      __$$_UserAuthStateCopyWithImpl<_$_UserAuthState>(this, _$identity);
}

abstract class _UserAuthState implements UserAuthState {
  const factory _UserAuthState(
      {final AuthStatus status,
      final UserProfile? userProfile,
      final String? phoneNumber,
      final String? otp,
      final String? message,
      final String? verificationId,
      final int? resendToken,
      final String? detailedMessage}) = _$_UserAuthState;

  @override
  AuthStatus get status;
  @override
  UserProfile? get userProfile;
  @override
  String? get phoneNumber;
  @override
  String? get otp;
  @override
  String? get message;
  @override
  String? get verificationId;
  @override
  int? get resendToken;
  @override
  String? get detailedMessage;
  @override
  @JsonKey(ignore: true)
  _$$_UserAuthStateCopyWith<_$_UserAuthState> get copyWith =>
      throw _privateConstructorUsedError;
}
