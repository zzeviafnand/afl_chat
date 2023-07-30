import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
class Note extends Equatable with _$Note {
  const factory Note({
    required String uid,
    required String title,
    required String content,
    required dynamic dateCreated,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) =>
      _$NoteFromJson(json);

  const Note._();

  @override
  List<Object?> get props => [title,content,dateCreated];
}
