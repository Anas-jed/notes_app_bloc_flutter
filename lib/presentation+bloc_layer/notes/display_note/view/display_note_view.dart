import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/presentation+bloc_layer/notes/display_note/widgets/staggered_view_widget.dart';
import 'package:notes_app/utils/consts/colors.dart';
import 'package:notes_app/utils/consts/strings.dart';

import '../../add_note/view/add_note_page.dart';
import '../bloc/display_note_bloc.dart';

class DisplayNoteView extends StatefulWidget {
  const DisplayNoteView({Key? key}) : super(key: key);

  @override
  State<DisplayNoteView> createState() => _DisplayNoteViewState();
}

class _DisplayNoteViewState extends State<DisplayNoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteDark,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(Strings.notes),
        ),
        body: BlocBuilder<DisplayNoteBloc, DisplayNoteState>(
            builder: (context, state) {
          return FutureBuilder(builder: (context, snapshot) {
            log('here');
            if (state.status == DisplayNoteStatus.loading) {
              return const CircularProgressIndicator();
            }
            if (state.status == DisplayNoteStatus.success) {
              log('snapshot: $snapshot');
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: StaggeredViewWidget(notesList: state.notesList),
              );
            }
            if (state.status == DisplayNoteStatus.failure) {
              log('snapshot: $snapshot');
              return const Text('Error is here');
            }
            return const Text('nothing');
          });
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.maroon,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddNotePage())).then((value) {
              BlocProvider.of<DisplayNoteBloc>(context)
                  .add(DisplayNotesFetch());
            });
          },
          child: const Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ));
  }
}
