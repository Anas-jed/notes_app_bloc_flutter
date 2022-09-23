import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data_layer/notes_sqflite_db.dart';
import 'package:notes_app/domain_layer/models/note_model.dart';
import 'package:notes_app/domain_layer/repository/notes.dart';
import 'package:notes_app/presentation+bloc_layer/notes/edit_note/bloc/edit_note_bloc.dart';
import 'package:notes_app/presentation+bloc_layer/notes/edit_note/view/edit_note_view.dart';

class EditNotePage extends StatelessWidget {
  final NoteModel noteModel;
  const EditNotePage({Key? key, required this.noteModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NotesRepository(notesDatabase: NotesDatabase.instance),
      child: BlocProvider(
        create: (context) => EditNoteBloc(notesRepository: RepositoryProvider.of<NotesRepository>(context)),
        child: EditNoteView(noteModel: noteModel),
      ),
    );
  }
}
