import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Screens/Note/ViewNote.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';
import '../../Observables/NoteObservable.dart';
import 'SaveNote.dart';
import '../../Model/Note.dart';

final viewNotesScaffoldKey = GlobalKey<ScaffoldState>();

/// View Notes page
class Note extends StatefulWidget {
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  _NoteState();

  @override
  Widget build(BuildContext context) {
    final noteObserver = Provider.of<NoteObserver>(context);

    return Scaffold(
      key: viewNotesScaffoldKey,
      body: Observer(builder: (_) => _changeScreen(noteObserver.currentScreen)),

      ///floatingActionButton: buildFloatingBtn(noteObserver)
    );
  }

  Widget _changeScreen(NOTE_SCREENS screen) {
    print("Changing Note screen to $screen");

    switch (screen) {
      case NOTE_SCREENS.ADD_NOTE:
        return SaveNote();

      case NOTE_SCREENS.NOTE_DETAIL:
        return SaveNote(
          viewExistingNote: true,
        );

      default:
        return ViewNotes();
    }
  }
}
