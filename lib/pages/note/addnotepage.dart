import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_chat/cubit/notes_cubit.dart';
import 'package:project_chat/models/note.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key, this.note});

  final Note? note;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotesCubit, NotesState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          created: (note) => Navigator.of(context).pop(),
          loading: () => ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Loading..."))),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 6.7,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _saveNote(context, widget.note),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 1.8),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 5,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Center(
                        child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Theme.of(context).cardColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _noteField(context, widget.note),
        ),
      ),
    );
  }

  _saveNote(BuildContext context, Note? note) {
    if (note != null) {
    } else {
      context.read<NotesCubit>().createNote(Note(
          title: _titleController.text,
          content: _contentController.text,
          dateCreated: DateTime.now(),
          uid: FirebaseAuth.instance.currentUser!.uid));
    }
  }

  Widget _noteField(BuildContext context, Note? note) {
    if (note != null) {
      return _editNote(context);
    }
    return _createNote(context);
  }

  Widget _editNote(BuildContext context) {
    return const Text("Hehehe");
  }

  Widget _createNote(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            hintText: "Title",
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: _contentController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration(hintText: "Notes Content"),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }
}
