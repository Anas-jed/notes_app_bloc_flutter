import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/domain_layer/models/note_model.dart';
import 'package:notes_app/presentation+bloc_layer/notes/edit_note/bloc/edit_note_bloc.dart';
import 'package:notes_app/utils/consts/colors.dart';
import 'package:notes_app/utils/consts/strings.dart';

class EditNoteView extends StatefulWidget {
  final NoteModel noteModel;

  const EditNoteView({Key? key, required this.noteModel}) : super(key: key);

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.noteModel.title);
    contentController = TextEditingController(text: widget.noteModel.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.addNote),
        leading: BackButton(
          color: Colors.red,
          onPressed: () {
            log('pressed');
            Navigator.pop(context);
          },
        ),
        actions: [
          BlocConsumer<EditNoteBloc, EditNoteState>(
            listener: (listenerContext, state) {
              if (state is EditNoteSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Note is saved'),
                  duration: Duration(seconds: 2),

                ));
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is EditNoteValid) {
                return IconButton(
                    onPressed: () {
                      BlocProvider.of<EditNoteBloc>(context)
                          .add(EditNoteSubmitted(
                              noteModel: NoteModel.withIdConstructor(
                        id: widget.noteModel.id,
                        title: titleController.text,
                        content: contentController.text,
                        createTimestamp: widget.noteModel.createTimestamp,
                        updateTimestamp: DateTime.now().millisecondsSinceEpoch,
                      )));
                    },
                    icon: const Icon(
                      Icons.save,
                      color: AppColors.white,
                    ));
              }
              return Container();
            },
          )
        ],
      ),
      body: BlocBuilder<EditNoteBloc, EditNoteState>(
        builder: (context, state) {
          return Stack(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    enabled: state is EditNoteLoading ? false : true,
                    controller: titleController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: Strings.titleHint,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: TextField(
                      enabled: state is EditNoteLoading ? false : true,
                      onChanged: (val) {
                        log('val: $val');
                        BlocProvider.of<EditNoteBloc>(context).add(
                            EditNoteTextChanged(
                                content: contentController.text));
                      },
                      keyboardType: TextInputType.multiline,
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      controller: contentController,
                      decoration: const InputDecoration(
                          hintText: Strings.contentHint, labelStyle: TextStyle()
                          // focusedBorder: OutlineInputBorder()
                          ),
                      // maxLines: ,
                    ),
                  ),
                ],
              ),
            ),
            if (state is EditNoteLoading) ...[
              const Positioned.fill(
                child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()),
              )
            ]
          ]);
        },
      ),
    );
  }
}
