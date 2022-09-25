import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:notes_app/domain_layer/models/note_model.dart';
import 'package:notes_app/domain_layer/repository/notes.dart';

part 'edit_note_event.dart';

part 'edit_note_state.dart';

class EditNoteBloc extends Bloc<EditNoteEvent, EditNoteState> {
  final NotesRepository notesRepository;

  EditNoteBloc({required this.notesRepository}) : super(EditNoteInitial()) {
    on<EditNoteTextChanged>(onTextChanged);
    on<EditNoteSubmitted>(onSubmitted);
    on<EditNoteDeleted>(onDeleted);
  }

  onTextChanged(EditNoteTextChanged event, Emitter<EditNoteState> emit) {
    if (event.content.isEmpty) {
      emit(EditNoteError(errorMessage: 'Please enter something'));
    } else if (event.content.isNotEmpty) {
      emit(EditNoteValid());
    }
  }

  onSubmitted(EditNoteSubmitted event, Emitter<EditNoteState> emit) async {
    if (state is EditNoteValid) {
      emit(EditNoteLoading());
      await notesRepository.updateNote(event.noteModel);
      emit(EditNoteSuccess());
    }
  }

  onDeleted(EditNoteDeleted event, Emitter<EditNoteState> emit) async {
    emit(EditNoteLoading());
    await notesRepository.deleteNote(event.id);
    emit(EditNoteDeleteSuccess());
  }
}
