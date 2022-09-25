part of 'edit_note_bloc.dart';

abstract class EditNoteEvent {}

class EditNoteTextChanged extends EditNoteEvent{
  final String content;
  EditNoteTextChanged({required this.content});
}

class EditNoteSubmitted extends EditNoteEvent{
  final NoteModel noteModel;
  EditNoteSubmitted({required this.noteModel});
}

class EditNoteDeleted extends EditNoteEvent{
  int id;
  EditNoteDeleted({required this.id});
}

