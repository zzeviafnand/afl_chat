// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserStatusModel _$$_UserStatusModelFromJson(Map<String, dynamic> json) =>
    _$_UserStatusModel(
      uid: json['uid'] as String,
      milisecondCreatedAt: json['milisecondCreatedAt'] as int? ?? 0,
      statusText: json['statusText'] as String? ?? "",
      statusImageUrl: json['statusImageUrl'] as String?,
    );

Map<String, dynamic> _$$_UserStatusModelToJson(_$_UserStatusModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'milisecondCreatedAt': instance.milisecondCreatedAt,
      'statusText': instance.statusText,
      'statusImageUrl': instance.statusImageUrl,
    };
