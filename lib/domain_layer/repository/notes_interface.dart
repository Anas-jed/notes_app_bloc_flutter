import '../models/note_model.dart';

abstract class INotesRepository{
  const INotesRepository();

  Future<List<NoteModel>> loadAllNotes();

  Future<NoteModel?> loadNote(String id);

  ///if a note with a same id already exists, it will be replaced.
  Future<void> insertNote(NoteModel noteModel);

  Future<void> updateNote(NoteModel noteModel);

  ///Deletes a note with the id if exists or throw an exception if id does not exist
  Future<void> deleteNote(String id);

}

class NoteNotFoundException implements Exception{}