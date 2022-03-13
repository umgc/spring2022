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

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final saveTaskScaffoldKey = GlobalKey<ScaffoldState>();

/// Save Task page
class TaskDetails extends StatefulWidget {
  bool readOnly;

  TaskDetails({this.readOnly = false}) {}

  @override
  State<TaskDetails> createState() => _TaskDetails(readOnly: this.readOnly);
}

class _TaskDetails extends State<TaskDetails> {
  /// Text task service to use for I/O operations against local system
  final TextTaskService textTaskService = new TextTaskService();
  bool readOnly;

  var textController = TextEditingController();
  TextTask _newTask = TextTask();
  _TaskDetails({this.readOnly = false}) {
    //this.navScreenObs = navScreenObs;
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

    // var padding = MediaQuery.of(context).size.width * 0.02;

    // var verticalColSpace = MediaQuery.of(context).size.width * 0.1;

    // var fontSize =
    // fontSizeToPixelMap(settingObserver.userSettings.noteFontSize, false);

    const ICON_SIZE = 80.00;
    return Scaffold(
        key: saveTaskScaffoldKey,
        body: Observer(
          builder: (context) => SingleChildScrollView(
              // padding: EdgeInsets.all(10),
              child: Column(
            children: [
              Text(taskObserver.currTaskForDetails!.taskType),
              FaIcon(getIcon(taskObserver.currTaskForDetails!.icon),
                  color:
                      getIconColor(taskObserver.currTaskForDetails!.iconColor)),
              Text(taskObserver.currTaskForDetails!.name),
              Text(taskObserver.currTaskForDetails!.description),
              TextField(
                enabled: readOnly == false,
                controller: textController,
                maxLines: 5,
                // style: TextStyle(fontSize: fontSize),
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "tbd line 73"),
              ),
              // SizedBox(height: verticalColSpace),

              //only show check box if the user is edititing not
              // if (taskId.isEmpty) _checkBox(fontSize),

              // SizedBox(height: verticalColSpace),

              //do not show if user chose to add checkList or modify and existing not to be a checklist
              // _selectDate(taskObserver.newTaskIsCheckList, I18n.of(context),
              //     settingObserver.userSettings.locale),

              // SizedBox(height: verticalColSpace),

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

                  Visibility(
                    visible: readOnly == false,
                    child: GestureDetector(
                        onTap: () {
                          _onComplete(taskObserver);
                        },
                        child: Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.check,
                              size: ICON_SIZE,
                              color: Colors.green,
                            ),
                            Text(
                              'Complete Task',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        )),
                  ),

                  Visibility(
                      visible: false,
                      child: GestureDetector(
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
                          )))
                  //Need to update with caregiver logic
                ],
              )
            ],
          )),
          //bottomNavigationBar: BottomBar(3),
        ));
  }

  _onComplete(TaskObserver taskObserver) {
    if (textController.text.length > 0) {
      print("Marking Task Complete: ${taskObserver.currTaskForDetails}");
      this._newTask.taskId = (taskObserver.currTaskForDetails != null)
          ? taskObserver.currTaskForDetails!.taskId
          : TextTask().taskId;
      // this._newTask.text = textController.text;
      // this._newTask.localText = textController.text;
      // this._newTask.eventTime = taskObserver.newTaskEventTime;
      // this._newTask.eventDate = taskObserver.newTaskEventDate;
      // this._newTask.isCheckList = taskObserver.newTaskIsCheckList;

      taskObserver.deleteTask(taskObserver.currTaskForDetails);
      print('line 184' + _newTask.toString());
      taskObserver.completeTask(_newTask);
      Fluttertoast.showToast(
          msg: "Task Completed",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          timeInSecForIosWeb: 4);
      taskObserver.changeScreen(TASK_SCREENS.TASK);
    }
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
      Fluttertoast.showToast(
          msg: "Task Created",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          timeInSecForIosWeb: 4);
      taskObserver.changeScreen(TASK_SCREENS.TASK);
    }
  }
}

IconData getIcon(String inputIconLabel) {
  IconData result = FontAwesomeIcons.globe;
  switch (inputIconLabel) {
    case 'walking':
      {
        result = FontAwesomeIcons.walking;
      }
      break;

    case 'utensils':
      {
        result = FontAwesomeIcons.utensils;
      }
      break;
    case 'medkit':
      {
        result = FontAwesomeIcons.medkit;
      }
      break;
    case 'capsules':
      {
        result = FontAwesomeIcons.capsules;
      }
      break;
    case 'tooth':
      {
        result = FontAwesomeIcons.tooth;
      }
      break;
    case 'envelope':
      {
        result = FontAwesomeIcons.envelope;
      }
      break;
    case 'tshirt':
      {
        result = FontAwesomeIcons.tshirt;
      }
      break;

    default:
      {
        result = FontAwesomeIcons.walking;
      }
      break;
  }

  return result;
}

MaterialColor getIconColor(String inputIconLabel) {
  MaterialColor result = Colors.blueGrey;
  switch (inputIconLabel) {
    case 'blueGrey':
      {
        result = Colors.blueGrey;
      }
      break;

    case 'green':
      {
        result = Colors.green;
      }
      break;
    case 'purple':
      {
        result = Colors.purple;
      }
      break;
    case 'deepOrange':
      {
        result = Colors.deepOrange;
      }
      break;
    case 'pink':
      {
        result = Colors.pink;
      }
      break;

    default:
      {
        result = Colors.blueGrey;
      }
      break;
  }

  return result;
}
