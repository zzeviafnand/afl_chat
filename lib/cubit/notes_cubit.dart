import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project_chat/helper.dart';
import 'package:project_chat/models/note.dart';
import 'package:project_chat/resource/api_repository.dart';

part 'notes_state.dart';

part 'notes_cubit.freezed.dart';

class NotesCubit extends Cubit<NotesState> {
  final ApiRepository apiRepository = ApiRepository();

  NotesCubit() : super(const NotesState.initial());

  Future getNotes() async {
    try {
      final notes = await apiRepository.getNotes();
      emit(NotesState.loaded(notes: notes));
      logger.v(state);
    } catch (e, trace) {
      logger.e("Error", [e, trace]);
    }
  }

  Future createNote(Note note) async {
    try {
      emit(const NotesState.loading());
      final newNote = await apiRepository.createNote(note);
      if (newNote != null) {
        emit(NotesState.created(note: newNote));
        logger.v(state);
        getNotes();
      }
    } catch (e, t) {
      emit(const NotesState.error());
      logger.e("Error", [e, t]);
    }
  }
}
