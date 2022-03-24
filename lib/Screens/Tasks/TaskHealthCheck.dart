import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:memorez/Model/Task.dart';
import 'package:memorez/Observables/SettingObservable.dart';
import 'package:memorez/Screens/Tasks/TaskDetails.dart';
import 'package:memorez/Services/TaskService.dart';
import 'package:memorez/Utility/Constant.dart';
import 'package:memorez/Utility/FontUtil.dart';
import 'package:memorez/generated/i18n.dart';
import '../../Observables/TaskObservable.dart';
import 'dart:math' as math;

final saveTaskScaffoldKey = GlobalKey<ScaffoldState>();

class TaskHealthCheck extends StatefulWidget {
  final bool readOnly;

  TaskHealthCheck({this.readOnly = false}) {}

  @override
  State<TaskHealthCheck> createState() =>
      _TaskHealthCheck(readOnly: this.readOnly);
}

class _TaskHealthCheck extends State<TaskHealthCheck> {
  String screen = '1';
  String firstSelection = '';
  String secondSelection = '';
  String description = '';
  bool showCompleteBtn = false;

  /// Text task service to use for I/O operations against local system
  final TextTaskService textTaskService = new TextTaskService();

  var textController = TextEditingController();
  final bool readOnly;
  _TaskHealthCheck({this.readOnly = false}) {}

  @override
  Widget build(BuildContext context) {
    final taskObserver = Provider.of<TaskObserver>(context, listen: false);
    final settingObserver = Provider.of<SettingObserver>(context);
    String taskId = "";
    //VIEW_Task MODE: Populated the details of the targeted Tasks into the UI
    if (taskObserver.currTaskForDetails != null) {
      taskId = taskObserver.currTaskForDetails!.taskId;

      textController = TextEditingController(
          text: taskObserver.currTaskForDetails!.responseText);
    }

    const ICON_SIZE = 80.00;
    const TEXT_SIZE = 25.00;

    var rowHeight = (MediaQuery.of(context).size.height);
    var columnWidth = (MediaQuery.of(context).size.width - 50) / 3;
    var readOnlyRowHeight = (MediaQuery.of(context).size.height);
    var readOnlyColumnWidth = (MediaQuery.of(context).size.width - 50);
    print(taskObserver.currTaskForDetails.toString());
    return Container(
      key: saveTaskScaffoldKey,
      child: Observer(
          builder: (context) => ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return readOnly
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'Completed Health Check',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue[900]),
                              ),
                            ),
                            Text(
                                taskObserver
                                    .currTaskForDetails!.completedTaskDateTime
                                    .toString()
                                    .substring(0, 16),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  // fontWeight: FontWeight.bold,
                                  // color: Colors.lightBlue[900]),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: columnWidth,
                                        height: columnWidth,
                                        child: Icon(
                                            getIcon(taskObserver
                                                .currTaskForDetails!
                                                .firstHealthCheckMood),
                                            size: ICON_SIZE,
                                            color: taskObserver
                                                        .currTaskForDetails!
                                                        .firstHealthCheckMood ==
                                                    'Bad'
                                                ? Colors.red
                                                : taskObserver
                                                            .currTaskForDetails!
                                                            .firstHealthCheckMood ==
                                                        'Okay'
                                                    ? Colors.blue
                                                    : Colors.green),
                                      ),
                                      Text(
                                        taskObserver.currTaskForDetails!
                                            .firstHealthCheckMood,
                                        style: TextStyle(
                                            fontSize: TEXT_SIZE,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: taskObserver.currTaskForDetails!
                                          .firstHealthCheckMood !=
                                      'Great',
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: columnWidth,
                                            height: columnWidth,
                                            child: Icon(
                                              getIcon(taskObserver
                                                  .currTaskForDetails!
                                                  .secondHealthCheckMood),
                                              size: ICON_SIZE,
                                            )),
                                        Text(
                                          taskObserver.currTaskForDetails!
                                              .secondHealthCheckMood,
                                          style: TextStyle(
                                              fontSize: TEXT_SIZE,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              taskObserver.currTaskForDetails!.responseText,

                              style: TextStyle(fontSize: 40),
                              // fontWeight: FontWeight.bold,
                              // color: Colors.lightBlue[900]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Divider(thickness: 5, color: Colors.blue),
                            ),
                            Column(
                              children: [
                                TextButton.icon(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    primary: Colors.black,
                                    fixedSize: Size(readOnlyColumnWidth, 40.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
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
                                    taskObserver
                                        .changeScreen(TASK_SCREENS.TASK);
                                    taskObserver.setCurrTaskIdForDetails(null);
                                  },
                                ),
                                Visibility(
                                  visible: taskObserver.careGiverModeEnabled,
                                  child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      primary: Colors.red,
                                      fixedSize:
                                          Size(readOnlyColumnWidth, 40.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
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
                                      taskObserver.deleteTask(
                                          taskObserver.currTaskForDetails);
                                      taskObserver
                                          .changeScreen(TASK_SCREENS.TASK);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ])
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'How are you feeling?',
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue[900]),
                            ),
                          ),
                          Text('Let the staff know how you are doing',
                              style: TextStyle(
                                fontSize: 20.0,
                                // fontWeight: FontWeight.bold,
                                // color: Colors.lightBlue[900]),
                              )),
                          Visibility(
                            visible: screen == '1',
                            child: Row(
                              children: [
                                Card(
                                  shadowColor: Colors.blueGrey[900],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: columnWidth,
                                        height: columnWidth,
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                screen = '2';
                                                firstSelection = 'Bad';
                                              });
                                            },
                                            icon: Icon(
                                              FontAwesomeIcons.solidAngry,
                                              color: Colors.red,
                                              size: ICON_SIZE,
                                            )),
                                      ),
                                      Text(
                                        'Bad',
                                        style: TextStyle(
                                            fontSize: TEXT_SIZE,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Card(
                                  shadowColor: Colors.blueGrey[900],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: columnWidth,
                                        height: columnWidth,
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                screen = '2';
                                                firstSelection = 'Okay';
                                              });
                                            },
                                            icon: Icon(
                                              FontAwesomeIcons.meh,
                                              color: Colors.blue,
                                              size: ICON_SIZE,
                                            )),
                                      ),
                                      Text(
                                        'Okay',
                                        style: TextStyle(
                                            fontSize: TEXT_SIZE,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Card(
                                  shadowColor: Colors.blueGrey[900],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: columnWidth,
                                        height: columnWidth,
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                screen = '2';
                                                firstSelection = 'Great';
                                                _onSave(taskObserver);
                                              });
                                            },
                                            icon: Icon(
                                              FontAwesomeIcons.grin,
                                              color: Colors.green,
                                              size: ICON_SIZE,
                                            )),
                                      ),
                                      Text(
                                        'Great',
                                        style: TextStyle(
                                            fontSize: TEXT_SIZE,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: screen == '2',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Card(
                                      shadowColor: Colors.blueGrey[900],
                                      color: secondSelection == 'Sad'
                                          ? Colors.blueGrey[200]
                                          : null,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: columnWidth,
                                            height: columnWidth,
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    secondSelection = 'Sad';
                                                    if (description != '') {
                                                      showCompleteBtn = true;
                                                    }
                                                  });
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.sadCry,
                                                  size: ICON_SIZE,
                                                )),
                                          ),
                                          Text(
                                            'Sad',
                                            style: TextStyle(
                                                fontSize: TEXT_SIZE,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    Card(
                                      shadowColor: Colors.blueGrey[900],
                                      color: secondSelection == 'Angry'
                                          ? Colors.blueGrey[200]
                                          : null,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: columnWidth,
                                            height: columnWidth,
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    secondSelection = 'Angry';
                                                    if (description != '') {
                                                      showCompleteBtn = true;
                                                    }
                                                  });
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.frown,
                                                  size: ICON_SIZE,
                                                )),
                                          ),
                                          Text(
                                            'Angry',
                                            style: TextStyle(
                                                fontSize: TEXT_SIZE,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    Card(
                                      shadowColor: Colors.blueGrey[900],
                                      color: secondSelection == 'Pain'
                                          ? Colors.blueGrey[200]
                                          : null,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: columnWidth,
                                            height: columnWidth,
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    secondSelection = 'Pain';
                                                    if (description != '') {
                                                      showCompleteBtn = true;
                                                    }
                                                  });
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.sadTear,
                                                  size: ICON_SIZE,
                                                )),
                                          ),
                                          Text(
                                            'Pain',
                                            style: TextStyle(
                                                fontSize: TEXT_SIZE,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Card(
                                      shadowColor: Colors.blueGrey[900],
                                      color: secondSelection == 'Confused'
                                          ? Colors.blueGrey[200]
                                          : null,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: columnWidth,
                                            height: columnWidth,
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    secondSelection =
                                                        'Confused';
                                                    if (description != '') {
                                                      showCompleteBtn = true;
                                                    }
                                                  });
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.dizzy,
                                                  size: ICON_SIZE,
                                                )),
                                          ),
                                          Text(
                                            'Confused',
                                            style: TextStyle(
                                                fontSize: TEXT_SIZE,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    Card(
                                      shadowColor: Colors.blueGrey[900],
                                      color: secondSelection == 'Tired'
                                          ? Colors.blueGrey[200]
                                          : null,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: columnWidth,
                                            height: columnWidth,
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    secondSelection = 'Tired';
                                                    if (description != '') {
                                                      showCompleteBtn = true;
                                                    }
                                                  });
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.tired,
                                                  size: ICON_SIZE,
                                                )),
                                          ),
                                          Text(
                                            'Tired',
                                            style: TextStyle(
                                                fontSize: TEXT_SIZE,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    Card(
                                      shadowColor: Colors.blueGrey[900],
                                      color: secondSelection == 'None'
                                          ? Colors.blueGrey[200]
                                          : null,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: columnWidth,
                                            height: columnWidth,
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    secondSelection = 'None';
                                                    if (description != '') {
                                                      showCompleteBtn = true;
                                                    }
                                                  });
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons
                                                      .questionCircle,
                                                  size: ICON_SIZE,
                                                )),
                                          ),
                                          Text(
                                            'None',
                                            style: TextStyle(
                                                fontSize: TEXT_SIZE,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                TextField(
                                  maxLines: 3,
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(fontSize: 30),
                                  decoration: InputDecoration(
                                      hintText: "--Description--"),
                                  onChanged: (text) {
                                    description = text;
                                    print('description: ' + description);
                                    setState(() {
                                      if (secondSelection != '') {
                                        showCompleteBtn = true;
                                      } else {
                                        showCompleteBtn = false;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  primary: Colors.black,
                                  fixedSize: Size(readOnlyColumnWidth, 40.0),
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
                                    fixedSize: Size(readOnlyColumnWidth, 40.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
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
                                    taskObserver.deleteTask(
                                        taskObserver.currTaskForDetails);
                                    taskObserver
                                        .changeScreen(TASK_SCREENS.TASK);
                                  },
                                ),
                              ),
                              Visibility(
                                visible: showCompleteBtn,
                                child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    primary: Colors.white,
                                    fixedSize: Size(readOnlyColumnWidth, 40.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.black)),
                                  ),
                                  icon: Icon(FontAwesomeIcons.check),
                                  label: Text(
                                    'Complete Task',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    _onSave(taskObserver);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
              })),
    );
  }

  _onSave(TaskObserver taskObserver) {
    taskObserver.currTaskForDetails!.responseText = description;
    taskObserver.currTaskForDetails!.firstHealthCheckMood = firstSelection;
    taskObserver.currTaskForDetails!.secondHealthCheckMood = secondSelection;
    taskObserver.completeTask(taskObserver.currTaskForDetails!);
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
