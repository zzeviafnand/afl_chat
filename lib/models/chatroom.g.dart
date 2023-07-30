// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatroom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatRoom _$$_ChatRoomFromJson(Map<String, dynamic> json) => _$_ChatRoom(
      id: json['id'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      lastChat: json['lastChat'] as String,
      unreadMessage: json['unreadMessage'] as int?,
      lastInteraction: json['lastInteraction'],
    );

Map<String, dynamic> _$$_ChatRoomToJson(_$_ChatRoom instance) =>
    <String, dynamic>{
      'id': instance.id,
      'members': instance.members,
      'lastChat': instance.lastChat,
      'unreadMessage': instance.unreadMessage,
      'lastInteraction': instance.lastInteraction,
    };
