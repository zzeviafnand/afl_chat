import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_chat/cubit/notes_cubit.dart';
import 'package:project_chat/models/note.dart';
import 'package:project_chat/pages/note/addnotepage.dart';

import '../../components/appbar.dart';

class NotePage extends StatefulWidget implements PreferredSizeWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
  final double barHeight = 50;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + barHeight);
}

class _NotePageState extends State<NotePage> {
  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: chatAppBar(context),
      body: BlocConsumer<NotesCubit, NotesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return state.when<Widget>(
            initial: () => _createLoading(),
            loaded: (notes) => _buildNoteList(notes),
            created: (note) => _createLoading(),
            loading: () => _createLoading(),
            error: () => _createLoading(),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          //vertical: 10,
          horizontal: 10,
        ),
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddNotePage(),
          )),
          //241, 123, 132
          backgroundColor: const Color(0xFF3c4df0),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Center _createLoading() => const Center(child: CircularProgressIndicator());

  ListView _buildNoteList(List<Note> notes) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: ((context, index) {
        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromRGBO(153, 204, 51, 50),
          ),
          child: ListTile(
            title: Text(
              notes[index].title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.watch_later_sharp),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      timeFormatter.format(
                          (notes[index].dateCreated as Timestamp).toDate()),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.date_range_sharp),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      formatter.format(
                          (notes[index].dateCreated as Timestamp).toDate()),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.note),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      notes[index].content,
                      style: const TextStyle(
                          fontSize: 16, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

var formatter = DateFormat('yyyy-MM-dd');
var timeFormatter = DateFormat('hh:mm');
