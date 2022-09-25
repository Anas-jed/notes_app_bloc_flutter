import 'dart:developer';

import 'package:notes_app/data_layer/notes_sqflite_db.dart';
import 'package:notes_app/domain_layer/models/note_model.dart';
import 'package:notes_app/domain_layer/repository/notes_interface.dart';

class NotesRepository implements INotesRepository {
  final NotesDatabase notesDatabase;

  NotesRepository({required this.notesDatabase});

  @override
  Future<void> deleteNote(int id) async {
    await notesDatabase.deleteNote(id);
  }

  @override
  Future<int> insertNote(NoteModel noteModel) async {
    return await notesDatabase.insertNote(noteModel.toMap());
  }

  @override
  Future<void> updateNote(NoteModel noteModel) async {
    await notesDatabase.updateNote(noteModel.toMapWithId());
  }

  @override
  Future<List<NoteModel>> loadAllNotes() async {
    var items = await notesDatabase.getAllNotes();
    if(items.length > 0){
      return items.map((element) => NoteModel.fromMap(element)).toList();
    }else{
      return <NoteModel>[];
    }
  }

  @override
  Future<NoteModel?> loadNote(String id) async {
    final item = await notesDatabase.getNote(id);
    return item != null ? NoteModel.fromMap(item) : null;
  }
}
