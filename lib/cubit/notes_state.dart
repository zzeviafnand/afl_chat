part of 'notes_cubit.dart';

@freezed
class NotesState with _$NotesState {
  const factory NotesState.initial() = _Initial;

  const factory NotesState.loaded({required List<Note> notes}) = _Loaded;

  const factory NotesState.created({required Note note}) = _Created;

  const factory NotesState.loading() = _Loading;

  const factory NotesState.error() = _Error;
}
