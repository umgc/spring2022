import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:memorez/Utility/ThemeUtil.dart';
import 'package:provider/provider.dart';
import 'package:memorez/Model/Note.dart';
import 'package:memorez/Observables/SettingObservable.dart';
import 'package:memorez/Services/NoteService.dart';
import 'package:memorez/Utility/Constant.dart';
import 'package:memorez/Utility/FontUtil.dart';
import 'package:memorez/generated/i18n.dart';
import '../../Observables/NoteObservable.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

final saveNoteScaffoldKey = GlobalKey<ScaffoldState>();

Color? textCol;

/// Save Note page
class SaveNote extends StatefulWidget {
  bool isCheckListEvent;
  bool viewExistingNote;
  bool deleteButtonVisible;

  SaveNote(
      {this.isCheckListEvent = false,
      this.viewExistingNote = false,
      this.deleteButtonVisible = false}) {}

  @override
  State<SaveNote> createState() => _SaveNoteState(
      isCheckListEvent: this.isCheckListEvent,
      viewExistingNote: this.viewExistingNote,
      deleteButtonVisible: this.deleteButtonVisible);
}

class _SaveNoteState extends State<SaveNote> {
  /// Text note service to use for I/O operations against local system
  final TextNoteService textNoteService = new TextNoteService();
  bool isCheckListEvent;
  bool viewExistingNote;
  String _reminderNotification = "No";
  bool deleteButtonVisible;

  var textController = TextEditingController();
  TextNote _newNote = TextNote();

  _SaveNoteState(
      {this.isCheckListEvent = false,
      this.viewExistingNote = false,
      this.deleteButtonVisible = false}) {
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
  Widget _checkBox(TextNote? currNoteForDetails) {
    if (currNoteForDetails?.notification == true) {
      _reminderNotification = "Yes";
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _myRadioButton(
                        value: "Yes",
                        title: "Yes",
                        onChanged: (newValue) =>
                            setState(() => _reminderNotification = newValue),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: _myRadioButton(
                        value: "No",
                        title: "No",
                        onChanged: (newValue) =>
                            setState(() => _reminderNotification = newValue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _myRadioButton(
      {required String title,
      required String value,
      required Function onChanged}) {

    return Theme(
      data: ThemeData(unselectedWidgetColor: textCol),child: RadioListTile(
      value: value,
      groupValue: _reminderNotification,
      onChanged: (newValue) =>
          setState(() => _reminderNotification = newValue.toString()),
      title: Text(title, style: TextStyle(color: textCol),
      ),
      activeColor: textCol,
      selected: false,
    ),
    );
    return RadioListTile(
      value: value,
      groupValue: _reminderNotification,
      onChanged: (newValue) =>
          setState(() => _reminderNotification = newValue.toString()),
      title: Text(title, style: TextStyle(color: textCol),
      ),
      activeColor: textCol,
      selected: false,
    );
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
            ? DateTimePickerType.dateTimeSeparate
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
        //  dateLabelText: dateLabelText,
        //   timeLabelText: timeLabelText,
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
            noteObserver.setNewNoteEventTime(mTime);
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
        if (value.split(" ").length == 2) {
          print("value " + value.toString());
          String mDate = value.split(" ")[0];
          String mTime = value.split(" ")[1];
          noteObserver.setNewNoteEventDate(mDate);
          noteObserver.setNewNoteEventTime(mTime);
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
    textCol = textMode(settingObserver.userSettings.darkMode);
    String noteId = "";
    //VIEW_NOTE MODE: Populated the details of the targeted notes into the UI
    if (noteObserver.currNoteForDetails != null) {
      noteId = noteObserver.currNoteForDetails!.noteId;

      textController = TextEditingController(
          text: noteObserver.currNoteForDetails!.localText);
    }

    var padding = MediaQuery.of(context).size.width * 0.02;

    var verticalColSpace = MediaQuery.of(context).size.width * 0.1;

    var fontSize =
        fontSizeToPixelMap(settingObserver.userSettings.noteFontSize, false);

    var noteWidth = MediaQuery.of(context).size.width * 0.87;

    return Scaffold(
      backgroundColor: backgroundMode(settingObserver.userSettings.darkMode),
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
                    hintText: I18n.of(context)!.enterNoteText,
                    hintStyle: TextStyle(color: Colors.green)),
              ),
              SizedBox(height: verticalColSpace),
              _selectDate(noteObserver.newNoteIsCheckList, I18n.of(context),
                  settingObserver.userSettings.locale),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                      I18n.of(context)!.settingDateAndTime,
                      style: TextStyle(fontSize: 12, color: textCol))),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(I18n.of(context)!.sendReminderNotification,
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold, color: textCol))),
              _checkBox(noteObserver.currNoteForDetails),
              SizedBox(height: verticalColSpace),
              Column(
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      primary: Colors.black54,
                      fixedSize: Size(noteWidth, 40.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black12)),
                    ),
                    icon: Icon(
                      Icons.keyboard_return,
                    ),
                    label: Text(
                      I18n.of(context)!.backToNotes,
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      noteObserver.changeScreen(NOTE_SCREENS.NOTE);
                    },
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      primary: Colors.blueAccent,
                      fixedSize: Size(noteWidth, 40.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blueAccent)),
                    ),
                    icon: Icon(
                      Icons.save,
                    ),
                    label: Text(
                      I18n.of(context)!.saveNote,
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _onSave(noteObserver, settingObserver);
                    },
                  ),
                  Visibility(
                    visible: deleteButtonVisible,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        primary: Colors.redAccent,
                        fixedSize: Size(noteWidth, 40.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.redAccent)),
                      ),
                      icon: Icon(
                        Icons.delete,
                      ),
                      label: Text(
                        I18n.of(context)!.deleteNote,
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        noteObserver
                            .deleteNote(noteObserver.currNoteForDetails);
                        noteObserver.changeScreen(NOTE_SCREENS.NOTE);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSave(NoteObserver noteObserver, SettingObserver settingObserver) {
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
      /* this._newNote.isCheckList = noteObserver.newNoteIsCheckList;
      if (noteObserver.newNoteIsCheckList == true) {
        this._newNote.recurrentType = "daily";
      }*/
      if (_reminderNotification == "No") {
        this._newNote.notification = false;
      }
      if (_reminderNotification == 'Yes') {
        if (settingObserver.userSettings.enableNotesNotifications) {
          this._newNote.notification = true;
          DateTime dateTime =
          DateTime.parse(_newNote.eventDate + " " + _newNote.eventTime);
          var _body = _newNote.text +
              "\n" +
              _newNote.eventDate +
              " at " +
              _newNote.eventTime;
          notify(_body, dateTime, settingObserver);
        }
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


  void notify(
      var _body, DateTime dateTime, SettingObserver settingObserver) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1, channelKey: 'key1', title: 'Reminder', body: _body),
      schedule: NotificationCalendar.fromDate(
          date: dateTime.subtract(Duration(
              minutes: int.parse(settingObserver
                  .userSettings.minutesBeforeNoteNotifications)))),
    );
  }
}
