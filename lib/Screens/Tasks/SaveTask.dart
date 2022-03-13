import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Task.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Services/TaskService.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/Utility/FontUtil.dart';
import 'package:untitled3/generated/i18n.dart';
import '../../Observables/TaskObservable.dart';
import 'dart:math' as math;

final saveTaskScaffoldKey = GlobalKey<ScaffoldState>();

/// Save Task page
class SaveTask extends StatefulWidget {
  bool isCheckListEvent;
  bool viewExistingTask;

  SaveTask({this.isCheckListEvent = false, this.viewExistingTask = false}) {}

  @override
  State<SaveTask> createState() => _SaveTaskState(
      isCheckListEvent: this.isCheckListEvent,
      viewExistingTask: this.viewExistingTask);
}

class _SaveTaskState extends State<SaveTask> {
  /// Text task service to use for I/O operations against local system
  final TextTaskService textTaskService = new TextTaskService();
  bool isCheckListEvent;
  bool viewExistingTask;

  var textController = TextEditingController();
  TextTask _newTask = TextTask();
  _SaveTaskState(
      {this.isCheckListEvent = false, this.viewExistingTask = false}) {
    //this.navScreenObs = navScreenObs;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _showToast() {
    Fluttertoast.showToast(
        msg: "Task Created",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIosWeb: 4);
  }

  //ref: https://api.flutter.dev/flutter/material/Checkbox-class.html
  Widget _checkBox(fontSize) {
    final taskObserver = Provider.of<TaskObserver>(context);

    Color getColor(Set<MaterialState> states) {
      return Colors.blue;
    }

    return CheckboxListTile(
      title: Text("Make this a daily activity",
          style: TextStyle(fontSize: fontSize)),
      checkColor: Colors.white,
      activeColor: Colors.blue,
      value: (taskObserver.newTaskIsCheckList),
      onChanged: (bool? value) {
        print("Checkbox onChanged $value");
        taskObserver.setNewTaskAIsCheckList(value!);
      },
    );
  }

  //ref: https://pub.dev/packages/date_time_picker
  Widget _selectDate(bool isCheckList, I18n? i18n, Locale locale) {
    final taskObserver = Provider.of<TaskObserver>(context);
    print(
        "_selectDate taskObserver.currTaskForDetails: ${taskObserver.currTaskForDetails}");
    String dateLabelText =
        (isCheckListEvent || isCheckList) ? i18n!.startDate : i18n!.selectDate;
    String timeLabelText = i18n.enterTime;

    if (this.viewExistingTask == true) {
      return DateTimePicker(
        type: (isCheckList || this.isCheckListEvent == true)
            ? DateTimePickerType.time
            : DateTimePickerType.dateTimeSeparate,
        dateMask: 'd MMM, yyyy',
        initialValue: (taskObserver.newTaskIsCheckList == true ||
                this.isCheckListEvent == true)
            ? (taskObserver.currTaskForDetails!.eventTime)
            : (taskObserver.currTaskForDetails!.eventDate +
                " " +
                taskObserver.currTaskForDetails!.eventTime),
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
          if (taskObserver.newTaskIsCheckList == true ||
              this.isCheckListEvent == true) {
            taskObserver.setNewTaskEventTime(value);
          } else {
            String mDate = value.split(" ")[0];
            String mTime = value.split(" ")[1];
            taskObserver.setNewTaskEventDate(mDate);
            taskObserver.setNewTaskEventTime(mTime);
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
        if (taskObserver.newTaskIsCheckList == true ||
            this.isCheckListEvent == true) {
          taskObserver.setNewTaskEventTime(value);
        } else {
          String mDate = value.split(" ")[0];
          String mTime = value.split(" ")[1];
          taskObserver.setNewTaskEventDate(mDate);
          taskObserver.setNewTaskEventTime(mTime);
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
    final taskObserver = Provider.of<TaskObserver>(context, listen: false);
    final settingObserver = Provider.of<SettingObserver>(context);
    String taskId = "";
    //VIEW_Task MODE: Populated the details of the targeted Tasks into the UI
    if (taskObserver.currTaskForDetails != null) {
      taskId = taskObserver.currTaskForDetails!.taskId;

      textController = TextEditingController(
          text: taskObserver.currTaskForDetails!.localText);
    }

    var padding = MediaQuery.of(context).size.width * 0.02;

    var verticalColSpace = MediaQuery.of(context).size.width * 0.1;

    var fontSize =
        fontSizeToPixelMap(settingObserver.userSettings.noteFontSize, false);

    const ICON_SIZE = 80.00;
    return Scaffold(
        key: saveTaskScaffoldKey,
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
                  if (taskId.isEmpty) _checkBox(fontSize),

                  SizedBox(height: verticalColSpace),

                  //do not show if user chose to add checkList or modify and existing not to be a checklist
                  _selectDate(taskObserver.newTaskIsCheckList, I18n.of(context),
                      settingObserver.userSettings.locale),

                  SizedBox(height: verticalColSpace),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            taskObserver.changeScreen(TASK_SCREENS.TASK);
                            taskObserver.setCurrTaskIdForDetails(null);
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
                            _onSave(taskObserver);
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
                      if (taskObserver.currTaskForDetails != null)
                        GestureDetector(
                            onTap: () {
                              //popup confirmation view
                              taskObserver
                                  .deleteTask(taskObserver.currTaskForDetails);
                              taskObserver.changeScreen(TASK_SCREENS.TASK);
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

  _onSave(TaskObserver taskObserver) {
    if (textController.text.length > 0) {
      print(
          "taskObserver.currTaskForDetails: ${taskObserver.currTaskForDetails}");
      this._newTask.taskId = (taskObserver.currTaskForDetails != null)
          ? taskObserver.currTaskForDetails!.taskId
          : TextTask().taskId;
      this._newTask.text = textController.text;
      this._newTask.localText = textController.text;
      this._newTask.eventTime = taskObserver.newTaskEventTime;
      this._newTask.eventDate = taskObserver.newTaskEventDate;
      this._newTask.isCheckList = taskObserver.newTaskIsCheckList;
      if (taskObserver.newTaskIsCheckList == true) {
        this._newTask.recurrentType = "daily";
      }

      taskObserver.deleteTask(taskObserver.currTaskForDetails);
      taskObserver.addTask(_newTask);
      _showToast();
      taskObserver.changeScreen(TASK_SCREENS.TASK);
    }
  }

  /// Show a dialog message confirming task was saved
  showConfirmDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(I18n.of(context)!.ok),
      onPressed: () {
        //navScreenObs.changeScreen(SCREEN_NAMES.TASK);
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
