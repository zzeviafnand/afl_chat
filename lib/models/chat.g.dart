// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Chat _$$_ChatFromJson(Map<String, dynamic> json) => _$_Chat(
      dateSent: json['dateSent'],
      from: json['from'] as String,
      to: json['to'] as String,
      message: json['message'] as String,
      isRead: json['isRead'] as bool,
    );

Map<String, dynamic> _$$_ChatToJson(_$_Chat instance) => <String, dynamic>{
      'dateSent': instance.dateSent,
      'from': instance.from,
      'to': instance.to,
      'message': instance.message,
      'isRead': instance.isRead,
    };
