import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Services/NoteService.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/Utility/FontUtil.dart';
import 'package:untitled3/generated/i18n.dart';
import '../../Observables/NoteObservable.dart';
import 'dart:math' as math;

final saveNoteScaffoldKey = GlobalKey<ScaffoldState>();

/// Save Note page
class SaveNote extends StatefulWidget {
  bool isCheckListEvent;
  bool viewExistingNote;

  SaveNote({this.isCheckListEvent = false, this.viewExistingNote = false}) {}

  @override
  State<SaveNote> createState() => _SaveNoteState(
      isCheckListEvent: this.isCheckListEvent,
      viewExistingNote: this.viewExistingNote);
}

class _SaveNoteState extends State<SaveNote> {
  /// Text note service to use for I/O operations against local system
  final TextNoteService textNoteService = new TextNoteService();
  bool isCheckListEvent;
  bool viewExistingNote;

  var textController = TextEditingController();
  TextNote _newNote = TextNote();
  _SaveNoteState(
      {this.isCheckListEvent = false, this.viewExistingNote = false}) {
    //this.navScreenObs = navScreenObs;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _showToast() {
    Fluttertoast.showToast(
        msg: I18n.of(context)!.noteSaved,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIosWeb: 4);
  }

  //ref: https://api.flutter.dev/flutter/material/Checkbox-class.html
  Widget _checkBox(fontSize) {
    final noteObserver = Provider.of<NoteObserver>(context);

    Color getColor(Set<MaterialState> states) {
      return Colors.blue;
    }

    return CheckboxListTile(
      title: Text("Make this a daily activity",
          style: TextStyle(fontSize: fontSize)),
      checkColor: Colors.white,
      activeColor: Colors.blue,
      value: (noteObserver.newNoteIsCheckList),
      onChanged: (bool? value) {
        print("Checkbox onChanged $value");
        noteObserver.setNewNoteAIsCheckList(value!);
      },
    );
    //Row(
    //   children: [
    //     Text("Make this a daily activity"),
    //     Checkbox(
    //       checkColor: Colors.white,
    //       fillColor: MaterialStateProperty.resolveWith(getColor),
    //       value: noteObserver.newNoteIsCheckList,
    //       onChanged: (bool? value) {
    //         print("Checkbox onChanged $value");
    //         noteObserver.setNewNoteAIsCheckList(value!);
    //       },
    //     )
    //   ],
    // );
  }

  //ref: https://pub.dev/packages/date_time_picker
  Widget _selectDate(bool isCheckList, I18n? i18n, Locale locale) {
    final noteObserver = Provider.of<NoteObserver>(context);
    print(
        "_selectDate noteObserver.currNoteForDetails: ${noteObserver.currNoteForDetails}");
    String dateLabelText =
        (isCheckListEvent || isCheckList) ? i18n!.startDate : i18n!.selectDate;
    String timeLabelText = i18n.enterTime;

    if (this.viewExistingNote == true) {
      return DateTimePicker(
        type: (isCheckList || this.isCheckListEvent == true)
            ? DateTimePickerType.time
            : DateTimePickerType.dateTimeSeparate,
        dateMask: 'd MMM, yyyy',
        initialValue: (noteObserver.newNoteIsCheckList == true ||
                this.isCheckListEvent == true)
            ? (noteObserver.currNoteForDetails!.eventTime)
            : (noteObserver.currNoteForDetails!.eventDate +
                " " +
                noteObserver.currNoteForDetails!.eventTime),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        icon: Icon(Icons.event),
        dateLabelText: dateLabelText,
        timeLabelText: timeLabelText,
        selectableDayPredicate: (date) {
          return true;
        },
        onChanged: (value) {
          print("_selectDate: Datetime $value");
          if (noteObserver.newNoteIsCheckList == true ||
              this.isCheckListEvent == true) {
            noteObserver.setNewNoteEventTime(value);
          } else {
            String mDate = value.split(" ")[0];
            String mTime = value.split(" ")[1];
            noteObserver.setNewNoteEventDate(mDate);
          }
        },
        validator: (val) {
          print(val);
          return null;
        },
        onSaved: (val) => print("onSaved $val"),
      );
    }

    return DateTimePicker(
      type: DateTimePickerType.dateTimeSeparate,
      locale: locale,
      dateMask: 'd MMM, yyyy',
      //initialValue: DateTime.now().toString(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      dateLabelText: dateLabelText,
      timeLabelText: timeLabelText,
      selectableDayPredicate: (date) {
        return true;
      },
      onChanged: (value) {
        if (noteObserver.newNoteIsCheckList == true ||
            this.isCheckListEvent == true) {
          noteObserver.setNewNoteEventTime(value);
        } else {
          String mDate = value.split(" ")[0];
          String mTime = value.split(" ")[1];
          noteObserver.setNewNoteEventDate(mDate);
        }
      },
      validator: (val) {
        print(val);
        return null;
      },
      onSaved: (val) => print("onSaved $val"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteObserver = Provider.of<NoteObserver>(context, listen: false);
    final settingObserver = Provider.of<SettingObserver>(context);
    String noteId = "";
    //VIEW_NOTE MODE: Populated the details of the targeted notes into the UI
    if (noteObserver.currNoteForDetails != null) {
      noteId = noteObserver.currNoteForDetails!.noteId;

      textController =
          TextEditingController(text: noteObserver.currNoteForDetails!.localText);
    }

    var padding = MediaQuery.of(context).size.width * 0.02;

    var verticalColSpace = MediaQuery.of(context).size.width * 0.1;

    var fontSize =
        fontSizeToPixelMap(settingObserver.userSettings.noteFontSize, false);

    const ICON_SIZE = 80.00;
    return Scaffold(
        key: saveNoteScaffoldKey,
        body: Observer(
          builder: (context) => SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [
                  TextField(
                    controller: textController,
                    maxLines: 5,
                    style: TextStyle(fontSize: fontSize),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: I18n.of(context)!.enterNoteText),
                  ),
                  SizedBox(height: verticalColSpace),

                  //only show check box if the user is edititing not
                  if (noteId.isEmpty) _checkBox(fontSize),

                  SizedBox(height: verticalColSpace),

                  //do not show if user chose to add checkList or modify and existing not to be a checklist
                  _selectDate(noteObserver.newNoteIsCheckList, I18n.of(context), settingObserver.userSettings.locale),

                  SizedBox(height: verticalColSpace),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            noteObserver.changeScreen(NOTE_SCREENS.NOTE);
                            noteObserver.setCurrNoteIdForDetails(null);
                          },
                          child: Column(
                            children: [
                              Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: Icon(
                                    Icons.exit_to_app_rounded,
                                    size: ICON_SIZE,
                                    color: Colors.amber,
                                  )),
                              Text(
                                I18n.of(context)!.cancel,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          )),
                      GestureDetector(
                          onTap: () {
                            _onSave(noteObserver);
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.save,
                                size: ICON_SIZE,
                                color: Colors.green,
                              ),
                              Text(
                                I18n.of(context)!.saveNote,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          )),
                      if (noteObserver.currNoteForDetails != null)
                        GestureDetector(
                            onTap: () {
                              //popup confirmation view
                              noteObserver
                                  .deleteNote(noteObserver.currNoteForDetails);
                              noteObserver.changeScreen(NOTE_SCREENS.NOTE);
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.delete_forever,
                                  size: ICON_SIZE,
                                  color: Colors.red,
                                ),
                                Text(
                                  I18n.of(context)!.deleteNote,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ))
                    ],
                  )
                ],
              )),
          //bottomNavigationBar: BottomBar(3),
        ));
  }

  _onSave(NoteObserver noteObserver) {
    if (textController.text.length > 0) {
      print(
          "noteObserver.currNoteForDetails: ${noteObserver.currNoteForDetails}");
      this._newNote.noteId = (noteObserver.currNoteForDetails != null)
          ? noteObserver.currNoteForDetails!.noteId
          : TextNote().noteId;
      this._newNote.text = textController.text;
      this._newNote.localText = textController.text;
      this._newNote.eventTime = noteObserver.newNoteEventTime;
      this._newNote.eventDate = noteObserver.newNoteEventDate;
      this._newNote.isCheckList = noteObserver.newNoteIsCheckList;
      if (noteObserver.newNoteIsCheckList == true) {
        this._newNote.recurrentType = "daily";
      }

      noteObserver.deleteNote(noteObserver.currNoteForDetails);
      noteObserver.addNote(_newNote);
      _showToast();
      noteObserver.changeScreen(NOTE_SCREENS.NOTE);
    }
  }

  /// Show a dialog message confirming note was saved
  showConfirmDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(I18n.of(context)!.ok),
      onPressed: () {
        //navScreenObs.changeScreen(SCREEN_NAMES.NOTE);
      },
    );

    // set up the dialog
    AlertDialog alert = AlertDialog(
      content: Text(I18n.of(context)!.noteSavedSuccess),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
