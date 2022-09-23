part of 'add_note_bloc.dart';

// enum AddNoteStatus { initial, loading, valid, error }

abstract class AddNoteState{
  // final AddNoteStatus status;
  // const AddNoteState({required this.status});
}

class AddNoteInitial extends AddNoteState{}

class AddNoteValid extends AddNoteState{}

class AddNoteError extends AddNoteState{
  String errorMessage;
  AddNoteError({required this.errorMessage});
}

class AddNoteLoading extends AddNoteState{}

class AddNoteSuccess extends AddNoteState{}
