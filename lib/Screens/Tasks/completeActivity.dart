import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:memorez/Observables/SettingObservable.dart';
import 'package:memorez/Services/TaskService.dart';
import 'package:memorez/Utility/Constant.dart';
import 'package:memorez/generated/i18n.dart';
import '../../Observables/TaskObservable.dart';
import 'dart:math' as math;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Utility/ThemeUtil.dart';

final saveTaskScaffoldKey = GlobalKey<ScaffoldState>();

/// Save Task page
class CompleteActivity extends StatefulWidget {
  bool readOnly;

  CompleteActivity({this.readOnly = false}) {}

  @override
  State<CompleteActivity> createState() => _TaskDetails(readOnly: this.readOnly);
}

Color? textCol;

class _TaskDetails extends State<CompleteActivity> {
  /// Text task service to use for I/O operations against local system
  final TextTaskService textTaskService = new TextTaskService();
  bool readOnly;
  bool showCompleteBtn = false;
  String responseText = '';
  _TaskDetails({this.readOnly = false}) {}

  @override
  Widget build(BuildContext context) {
    final taskObserver = Provider.of<TaskObserver>(context, listen: false);
    final settingObserver = Provider.of<SettingObserver>(context);
    textCol = textMode(settingObserver.userSettings.darkMode);

    try {
      responseText = taskObserver.currTaskForDetails!.responseText;
      print('response text = ' + responseText);
    } on Exception catch (e) {
      print('Exception $e');
    }
    var btnColumnWidth = (MediaQuery.of(context).size.width - 50);
    const ICON_SIZE = 80.00;
    return Container(
        key: saveTaskScaffoldKey,
        child: Observer(
          builder: (context) => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(children: [
                    Text(
                      taskObserver.currTaskForDetails!.taskType,
                      style:
                          TextStyle(fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: textCol),
                    ),
                    Spacer(),
                    FaIcon(getIcon(taskObserver.currTaskForDetails!.icon),
                        size: 50.0,
                        color: getIconColor(
                            taskObserver.currTaskForDetails!.iconColor)),
                  ])),
              Text(
                'This activity task is assigned to you to perform an action.',
                style: TextStyle(
                  fontSize: 20.0,
                  color: textCol,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                      taskObserver.currTaskForDetails!.name,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: textCol,
                      ),
                    ),
                    Text(
                      taskObserver.currTaskForDetails!.description,
                      softWrap: true,
                      style: TextStyle(fontSize: 25.0,
                      color: textCol,
                      ),
                    ),
                  ],
                ),
              ),
              //   ],
              // ),
              Visibility(
                visible: readOnly == false,
                child: TextField(
                  textInputAction: TextInputAction.done,
                  maxLines: 3,
                  style: TextStyle(fontSize: 30, color: textCol),
                  decoration: InputDecoration(
                    hintText: "--Response--",
                    hintStyle: TextStyle(
                        color: textCol,
                    ),
                  ),
                  onChanged: (text) {
                    setState(() {
                      responseText = text;
                      taskObserver.currTaskForDetails!.responseText =
                          responseText;
                      print('printing response - ' + responseText);
                      if (responseText != '') {
                        showCompleteBtn = true;
                      } else
                        showCompleteBtn = false;
                    });
                  },
                ),
              ),
              Visibility(
                visible: readOnly == true,
                child: Text(
                  responseText,
                  maxLines: 3,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Divider(thickness: 5, color: Colors.blue),
              ),
              Column(
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      primary: Colors.black,
                      fixedSize: Size(btnColumnWidth, 40.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black)),
                    ),
                    icon: Icon(
                      Icons.keyboard_return,
                    ),
                    label: Text(
                      'Go Back',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      taskObserver.changeScreen(TASK_SCREENS.TASK);
                      taskObserver.setCurrTaskIdForDetails(null);
                    },
                  ),
                  Visibility(
                    visible: taskObserver.careGiverModeEnabled,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        primary: Colors.red,
                        fixedSize: Size(btnColumnWidth, 40.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                      ),
                      icon: Icon(
                        FontAwesomeIcons.trash,
                      ),
                      label: Text(
                        'Delete',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        taskObserver
                            .deleteTask(taskObserver.currTaskForDetails);
                        taskObserver.changeScreen(TASK_SCREENS.TASK);
                      },
                    ),
                  ),
                  Visibility(
                    visible: readOnly == false && showCompleteBtn,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        primary: Colors.white,
                        fixedSize: Size(btnColumnWidth, 40.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black)),
                      ),
                      icon: Icon(FontAwesomeIcons.check),
                      label: Text(
                        'Complete Task',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        _onComplete();
                        taskObserver.completeTask(taskObserver.currTaskForDetails!);
                        taskObserver.completeTask(taskObserver.currTaskForDetails!);
                        taskObserver.inactiveTasksUpdated.value = !taskObserver.inactiveTasksUpdated.value;
                        taskObserver.changeScreen(TASK_SCREENS.TASK);
                      },
                    ),
                  ),
                ],
              ),
            ],
          )),
        ));
  }

  _onComplete() {
    Fluttertoast.showToast(
        msg: "Task Completed",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIosWeb: 4);
  }
}

IconData getIcon(String inputIconLabel) {
  IconData result = FontAwesomeIcons.globe;
  switch (inputIconLabel) {
    case 'Bad':
      {
        result = FontAwesomeIcons.solidAngry;
      }
      break;
    case 'Okay':
      {
        result = FontAwesomeIcons.meh;
      }
      break;
    case 'Great':
      {
        result = FontAwesomeIcons.grin;
      }
      break;
    case 'Sad':
      {
        result = FontAwesomeIcons.sadCry;
      }
      break;
    case 'Angry':
      {
        result = FontAwesomeIcons.frown;
      }
      break;
    case 'Pain':
      {
        result = FontAwesomeIcons.sadTear;
      }
      break;
    case 'Confused':
      {
        result = FontAwesomeIcons.dizzy;
      }
      break;
    case 'Tired':
      {
        result = FontAwesomeIcons.tired;
      }
      break;
    case 'None':
      {
        result = FontAwesomeIcons.questionCircle;
      }
      break;
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
    case 'red':
      {
        result = Colors.red;
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
