// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserProfile _$$_UserProfileFromJson(Map<String, dynamic> json) =>
    _$_UserProfile(
      uid: json['uid'] as String? ?? "NONEUID",
      phone: json['phone'] as String,
      fullName: json['fullName'] as String?,
      bio: json['bio'] as String?,
      photoUrl: json['photoUrl'] as String?,
      fcmToken: json['fcmToken'] as String?,
    );

Map<String, dynamic> _$$_UserProfileToJson(_$_UserProfile instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'phone': instance.phone,
      'fullName': instance.fullName,
      'bio': instance.bio,
      'photoUrl': instance.photoUrl,
      'fcmToken': instance.fcmToken,
    };
