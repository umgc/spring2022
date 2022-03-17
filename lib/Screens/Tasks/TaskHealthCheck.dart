import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
class TaskHealthCheck extends StatefulWidget {
  bool readOnly;

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
  bool readOnly;

  var textController = TextEditingController();

  _TaskHealthCheck({this.readOnly = false}) {
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
          text: taskObserver.currTaskForDetails!.responseText);
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
                        children: [
                          SizedBox(
                            width: 125,
                            height: 125,
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
                                  size: 80.0,
                                )),
                          ),
                          Text(
                            'Bad',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Card(
                      shadowColor: Colors.blueGrey[900],
                      child: Column(
                        children: [
                          SizedBox(
                            width: 125,
                            height: 125,
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
                                  size: 80.0,
                                )),
                          ),
                          Text(
                            'Okay',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Card(
                      shadowColor: Colors.blueGrey[900],
                      child: Column(
                        children: [
                          SizedBox(
                            width: 125,
                            height: 125,
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
                                  size: 80.0,
                                )),
                          ),
                          Text(
                            'Great',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
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
                  children: [
                    Row(
                      children: [
                        Card(
                          shadowColor: Colors.blueGrey[900],
                          color: secondSelection == 'Sad'
                              ? Colors.blueGrey[200]
                              : null,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 125,
                                height: 125,
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
                                      size: 80.0,
                                    )),
                              ),
                              Text(
                                'Sad',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
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
                            children: [
                              SizedBox(
                                width: 125,
                                height: 125,
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
                                      size: 80.0,
                                    )),
                              ),
                              Text(
                                'Angry',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
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
                            children: [
                              SizedBox(
                                width: 125,
                                height: 125,
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
                                      size: 80.0,
                                    )),
                              ),
                              Text(
                                'Pain',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
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
                            children: [
                              SizedBox(
                                width: 125,
                                height: 125,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        secondSelection = 'Confused';
                                        if (description != '') {
                                          showCompleteBtn = true;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.dizzy,
                                      size: 80.0,
                                    )),
                              ),
                              Text(
                                'Confused',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
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
                            children: [
                              SizedBox(
                                width: 125,
                                height: 125,
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
                                      size: 80.0,
                                    )),
                              ),
                              Text(
                                'Tired',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
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
                            children: [
                              SizedBox(
                                width: 125,
                                height: 125,
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
                                      FontAwesomeIcons.questionCircle,
                                      size: 80.0,
                                    )),
                              ),
                              Text(
                                'None',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      maxLines: 3,
                      style: TextStyle(fontSize: 30),
                      decoration: InputDecoration(hintText: "--Description--"),
                      onChanged: (text) {
                        description = text;
                        print('description: ' + description);
                        setState(() {
                          if (secondSelection != '') {
                            showCompleteBtn = true;
                          }
                        });

                        print('showComplete ' + showCompleteBtn.toString());
                      },
                    ),
                  ],
                ),
              ),
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
                            ),
                          ),
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
                    child: Visibility(
                      visible: showCompleteBtn,
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.arrowAltCircleRight,
                              size: ICON_SIZE,
                              color: Colors.green,
                            ),
                            Text(
                              'Complete Task',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (false)
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
    taskObserver.currTaskForDetails!.responseText = textController.text;
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
