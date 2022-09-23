import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:notes_app/domain_layer/models/note_model.dart';
import 'package:notes_app/domain_layer/repository/notes.dart';

part 'add_note_state.dart';

part 'add_note_event.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  final NotesRepository notesRepository;

  AddNoteBloc({required this.notesRepository}) : super(AddNoteInitial()) {
    on<AddNoteTextChanged>(onTextChanged);
    on<AddNoteSubmitted>(onSubmitted);
  }

  onTextChanged(AddNoteTextChanged event, Emitter<AddNoteState> emit) {
    if (event.content.isEmpty) {
      emit(AddNoteError(errorMessage: 'Please enter something'));
    } else if (event.content.isNotEmpty) {
      emit(AddNoteValid());
    }
  }

  onSubmitted(AddNoteSubmitted event, Emitter<AddNoteState> emit) async{
    if (state is AddNoteValid) {
      emit(AddNoteLoading());
      final insertNote = NoteModel(title: event.title,
          content: event.content,
          createTimestamp: DateTime.now().millisecondsSinceEpoch,
          updateTimestamp: DateTime.now().millisecondsSinceEpoch);
      final int insertedId = await notesRepository.insertNote(insertNote);
      log('Inserted Id : $insertedId');
      emit(AddNoteSuccess());
    }
  }
}
