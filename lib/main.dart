import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data_layer/notes_sqflite_db.dart';
import 'package:notes_app/domain_layer/repository/notes.dart';
import 'package:notes_app/simple_observer.dart';
import 'package:notes_app/utils/consts/colors.dart';

import 'presentation+bloc_layer/notes/display_note/bloc/display_note_bloc.dart';
import 'presentation+bloc_layer/notes/display_note/view/display_note_page.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: AppColors.maroonMaterialColor,
          // primaryColor: AppColors.maroon,

        ),
        home: RepositoryProvider(
          create: (context) =>
              NotesRepository(notesDatabase: NotesDatabase.instance),
          child: BlocProvider(
            create: (context) => DisplayNoteBloc(
                notesRepository:
                    RepositoryProvider.of<NotesRepository>(context))
              ..add(DisplayNotesFetch()),
            child: const DisplayNotePage(),
          ),
        ));
  }
}
