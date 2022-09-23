import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/presentation+bloc_layer/notes/add_note/bloc/add_note_bloc.dart';
import 'package:notes_app/utils/consts/colors.dart';
import 'package:notes_app/utils/consts/strings.dart';

class AddNoteView extends StatelessWidget {
  AddNoteView({Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

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
          BlocConsumer<AddNoteBloc, AddNoteState>(
            listener: (context, state) {
              if (state is AddNoteSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Your note is saved'),
                  duration: Duration(seconds: 2),

                ));
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is AddNoteValid) {
                return IconButton(
                    onPressed: () {
                      BlocProvider.of<AddNoteBloc>(context).add(
                          AddNoteSubmitted(
                              title: titleController.text,
                              content: contentController.text));
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
      body: BlocBuilder<AddNoteBloc, AddNoteState>(
        builder: (context, state) {
          return Stack(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    enabled: state is AddNoteLoading ? false : true,
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
                      enabled: state is AddNoteLoading ? false : true,
                      onChanged: (val) {
                        log('val: $val');
                        BlocProvider.of<AddNoteBloc>(context).add(
                            AddNoteTextChanged(
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
            if (state is AddNoteLoading) ...[
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
