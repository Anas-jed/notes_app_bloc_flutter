part of 'display_note_bloc.dart';

enum DisplayNoteStatus { initial, loading, success, failure }

class DisplayNoteState extends Equatable {
  final DisplayNoteStatus status;
  final List<NoteModel> notesList;

  const DisplayNoteState(
      {this.status = DisplayNoteStatus.initial,
      this.notesList = const <NoteModel>[]});

  @override
  List<Object?> get props => [status, notesList];

  DisplayNoteState copyWith(
      {List<NoteModel>? notesList, DisplayNoteStatus? status}) {
    return DisplayNoteState(
        status: status ?? this.status, notesList: notesList ?? this.notesList);
  }
}
