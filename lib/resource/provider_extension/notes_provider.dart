import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_chat/models/note.dart';
import 'package:project_chat/resource/api_provider.dart';

extension UserProfileApiProvider on ApiProvider {
  Future<Note?> createNote(Note note) async {
    var noteRef = db.collection('notes').withConverter(
        fromFirestore: (snapshot, options) => Note.fromJson(snapshot.data()!),
        toFirestore: (value, options) => note.toJson());
    final addNote = await noteRef.add(note);
    final savedNote = await addNote.get();
    return savedNote.data();
  }

  Future<List<Note>> getNotes() async {
    var noteRef = db
        .collection('notes')
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Note.fromJson(snapshot.data()!),
            toFirestore: (value, options) => {});
    final allNotes = await noteRef.get();
    return allNotes.docs.map((e) => e.data()).toList();
  }
}
