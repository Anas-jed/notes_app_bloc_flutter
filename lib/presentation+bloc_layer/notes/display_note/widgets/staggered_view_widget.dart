import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/domain_layer/models/note_model.dart';
import 'package:notes_app/presentation+bloc_layer/notes/display_note/bloc/display_note_bloc.dart';
import 'package:notes_app/presentation+bloc_layer/notes/edit_note/view/edit_note_page.dart';
import 'package:notes_app/utils/consts/colors.dart';

class StaggeredViewWidget extends StatelessWidget {
  final List<NoteModel> notesList;

  const StaggeredViewWidget({Key? key, required this.notesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10, crossAxisCount: 2, crossAxisSpacing: 10),
      itemCount: notesList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditNotePage(noteModel: notesList[index])))
                .then((value) {
              BlocProvider.of<DisplayNoteBloc>(context)
                  .add(DisplayNotesFetch());
            });
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  notesList[index].title.isNotEmpty
                      ? Text(
                          notesList[index].title,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      : Container(),
                  Expanded(
                    child: AutoSizeText(
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.start,
                        notesList[index].content),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
