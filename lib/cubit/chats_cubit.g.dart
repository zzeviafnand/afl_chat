// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatsState _$$_ChatsStateFromJson(Map<String, dynamic> json) =>
    _$_ChatsState(
      status: $enumDecodeNullable(_$ChatsStatusEnumMap, json['status']) ??
          ChatsStatus.initial,
      chats: _fromJson(json['chats']),
    );

Map<String, dynamic> _$$_ChatsStateToJson(_$_ChatsState instance) =>
    <String, dynamic>{
      'status': _$ChatsStatusEnumMap[instance.status]!,
      'chats': _toJson(instance.chats),
    };

const _$ChatsStatusEnumMap = {
  ChatsStatus.initial: 'initial',
  ChatsStatus.empty: 'empty',
  ChatsStatus.loading: 'loading',
  ChatsStatus.success: 'success',
  ChatsStatus.failure: 'failure',
};
