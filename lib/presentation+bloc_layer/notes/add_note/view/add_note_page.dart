import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data_layer/notes_sqflite_db.dart';
import 'package:notes_app/domain_layer/repository/notes.dart';
import 'package:notes_app/presentation+bloc_layer/notes/add_note/bloc/add_note_bloc.dart';
import 'package:notes_app/presentation+bloc_layer/notes/add_note/view/add_note_view.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NotesRepository(notesDatabase: NotesDatabase.instance),
      child: BlocProvider(
        create: (context) =>
            AddNoteBloc(notesRepository: RepositoryProvider.of<NotesRepository>(
                context)),
        child: AddNoteView(),
      ),
    );
  }
}
