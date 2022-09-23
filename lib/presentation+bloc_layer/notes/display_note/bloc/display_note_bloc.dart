import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_app/domain_layer/models/note_model.dart';
import 'package:notes_app/domain_layer/repository/notes.dart';

part 'display_note_event.dart';

part 'display_note_state.dart';

class DisplayNoteBloc extends Bloc<DisplayNoteEvent, DisplayNoteState> {
  DisplayNoteBloc({required this.notesRepository})
      : super(const DisplayNoteState(status: DisplayNoteStatus.initial)) {
    on<DisplayNotesFetch>(fetchAllNotes);
  }

  final NotesRepository notesRepository;

  fetchAllNotes(DisplayNotesFetch event, Emitter<DisplayNoteState> emit) async {
    try {
      if (state.status == DisplayNoteStatus.success) {
        emit(state.copyWith(status: DisplayNoteStatus.loading));
      }
      final notesList = await notesRepository.loadAllNotes();
      return emit(state.copyWith(
          notesList: notesList, status: DisplayNoteStatus.success));
    } catch (e) {
      log('exception caught: $e');
      emit(state.copyWith(status: DisplayNoteStatus.failure));
    }
  }
}
