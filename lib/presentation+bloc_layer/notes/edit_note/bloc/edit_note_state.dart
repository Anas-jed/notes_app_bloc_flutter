part of 'edit_note_bloc.dart';

abstract class EditNoteState {}

class EditNoteInitial extends EditNoteState {}

class EditNoteValid extends EditNoteState {}

class EditNoteError extends EditNoteState {
  String errorMessage;
  EditNoteError({required this.errorMessage});
}

class EditNoteLoading extends EditNoteState {}

class EditNoteSuccess extends EditNoteState {}


