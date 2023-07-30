// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      uid: json['uid'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      dateCreated: json['dateCreated'],
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'content': instance.content,
      'dateCreated': instance.dateCreated,
    };
