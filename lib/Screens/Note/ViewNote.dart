import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';
import 'package:untitled3/Services/NoteService.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';
import '../../Observables/NoteObservable.dart';
import 'NoteTable.dart';

final viewNotesScaffoldKey = GlobalKey<ScaffoldState>();

/// View Notes page
class ViewNotes extends StatefulWidget {
  @override
  _ViewNotesState createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  _ViewNotesState();

  @override
  Widget build(BuildContext context) {
    // String noteDetailScreen =I18n.of(context)!.notesDetailScreenName;
    // String addNoteScreen =I18n.of(context)!.addNotesScreenName;
    // String noteScreen =I18n.of(context)!.notesScreenName;

    final noteObserver = Provider.of<NoteObserver>(context);
    noteObserver.resetCurrNoteIdForDetails();

    //noteObserver.changeScreen(NOTE_SCREENS.NOTE);
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        body: NoteTable(noteObserver.usersNotes, () => print("done")),
        floatingActionButton:
          Padding(padding: EdgeInsets.only(left: 30), child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

            buildFloatingBtnCamera(noteObserver),

            buildFloatingBtn(noteObserver),




          ] ,)
         )
    );
  }

  //Funtion retuns Floating button
  Widget buildFloatingBtn(NoteObserver noteObserver) {
    return FloatingActionButton(

      onPressed: () {
        noteObserver.changeScreen(NOTE_SCREENS.ADD_NOTE);
      },
      tooltip: I18n.of(context)!.addNote,
      child: Icon(Icons.add),
    );

  }
  Widget buildFloatingBtnCamera(NoteObserver noteObserver) {
    return FloatingActionButton(
      onPressed:
        noteObserver.getImage,

      child: Icon(Icons.camera_alt),
    );
  }
}
