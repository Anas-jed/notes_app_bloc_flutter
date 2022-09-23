part of 'add_note_bloc.dart';

abstract class AddNoteEvent{}

class AddNoteTextChanged extends AddNoteEvent{
  String content;
  AddNoteTextChanged({required this.content});
}

class AddNoteSubmitted extends AddNoteEvent{
  String title, content;
  AddNoteSubmitted({required this.title, required this.content});
}