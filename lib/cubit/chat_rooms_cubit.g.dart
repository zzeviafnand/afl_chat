// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_rooms_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Initial _$$_InitialFromJson(Map<String, dynamic> json) => _$_Initial(
      chatRooms:
          json['chatRooms'] == null ? const [] : _fromJson(json['chatRooms']),
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']) ??
          Status.initial,
      message: json['message'] as String? ?? "No Message",
      detailedMessage:
          json['detailedMessage'] as String? ?? "No Detailed Message",
    );

Map<String, dynamic> _$$_InitialToJson(_$_Initial instance) =>
    <String, dynamic>{
      'chatRooms': _toJson(instance.chatRooms),
      'status': _$StatusEnumMap[instance.status]!,
      'message': instance.message,
      'detailedMessage': instance.detailedMessage,
    };

const _$StatusEnumMap = {
  Status.initial: 'initial',
  Status.loading: 'loading',
  Status.loadedFromNetwork: 'loadedFromNetwork',
  Status.loadedFromStorage: 'loadedFromStorage',
  Status.failure: 'failure',
  Status.storageEmpty: 'storageEmpty',
  Status.onlineDataEmpty: 'onlineDataEmpty',
};
