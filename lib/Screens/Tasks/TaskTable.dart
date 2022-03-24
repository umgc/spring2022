import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';
import 'package:memorez/Model/Task.dart';
import 'package:memorez/Observables/ScreenNavigator.dart';
import 'package:memorez/Observables/SettingObservable.dart';
import 'package:memorez/Utility/Constant.dart';
import '../../Observables/TaskObservable.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskTable extends StatefulWidget {
  final List<TextTask> usersTasks;

  //Flutter will autto assign this param to usersTasks
  TaskTable(this.usersTasks);
  @override
  State<TaskTable> createState() => _TaskTableState();
}

class _TaskTableState extends State<TaskTable> {
  @override
  Widget build(BuildContext context) {
    final screenNav = Provider.of<MainNavObserver>(context);

    final taskObserver = Provider.of<TaskObserver>(context);
    taskObserver.resetCurrTaskIdForDetails();

    const TEXT_STYLE = TextStyle(fontSize: 20);
    const HEADER_TEXT_STYLE = const TextStyle(fontSize: 20);

    var rowHeight = (MediaQuery.of(context).size.height) /
        (taskObserver.careGiverModeEnabled ? 2 : 1);

    List<TextTask> activeUserTasks = <TextTask>[];
    List<TextTask> inActiveUserTasks = <TextTask>[];

    for (var i = 0; i < taskObserver.usersTask.length; i++) {
      print('send task datetime:' +
          taskObserver.usersTask[i].isTaskCompleted.toString());
      if (taskObserver.usersTask[i].isTaskCompleted) {
        inActiveUserTasks.add(taskObserver.usersTask[i]);
      } else {
        if (taskObserver.usersTask[i].sendTaskDateTime
            .isBefore(DateTime.now())) {
          activeUserTasks.add(taskObserver.usersTask[i]);
        }
      }
    }

    return Column(
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Active Tasks',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue[900]),
                ),
              ),
              Container(
                //height: rowHeight,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: activeUserTasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          child: InkWell(
                              onTap: () {
                                print('task id: ' +
                                    activeUserTasks[index].taskId);
                                if (activeUserTasks[index].taskType ==
                                    'Activity') {
                                  taskObserver
                                      .setCurrTaskIdForDetails(
                                          activeUserTasks[index].taskId)
                                      .then((value) =>
                                          taskObserver.changeScreen(TASK_SCREENS
                                              .TASK_COMPLETE_ACTIVITY));
                                } else {
                                  taskObserver
                                      .setCurrTaskIdForDetails(
                                          activeUserTasks[index].taskId)
                                      .then((value) =>
                                          taskObserver.changeScreen(TASK_SCREENS
                                              .TASK_COMPLETE_HEALTH_CHECK));
                                }

                                // if (onListItemClickCallBackFn != null) {
                                //   onListItemClickCallBackFn!.call();
                                // }
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      color: Colors.lightBlue[100],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Row(children: <Widget>[
                                        FaIcon(
                                            getIcon(activeUserTasks
                                                .elementAt(index)
                                                .icon),
                                            color: getIconColor(activeUserTasks
                                                .elementAt(index)
                                                .iconColor)),
                                        Text('   '),
                                        Text(
                                          activeUserTasks
                                                      .elementAt(index)
                                                      .taskType ==
                                                  'Health Check'
                                              ? 'Health Check'
                                              : activeUserTasks
                                                  .elementAt(index)
                                                  .name
                                                  .substring(
                                                      0,
                                                      activeUserTasks
                                                                  .elementAt(
                                                                      index)
                                                                  .name
                                                                  .length <
                                                              25
                                                          ? activeUserTasks
                                                              .elementAt(index)
                                                              .name
                                                              .length
                                                          : 25),
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.lightBlue[900]),
                                        )
                                      ])))));
                    }),
              ),
            ]),
        Visibility(
          visible: taskObserver.careGiverModeEnabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Divider(thickness: 5, color: Colors.blue),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Completed Tasks',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue[900]),
                ),
              ),
              Container(
                //height: rowHeight,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: inActiveUserTasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          child: InkWell(
                        //This runs when double tapping an Active Task
                        onTap: () {
                          print('task id: ' + inActiveUserTasks[index].taskId);
                          print('task type selected = ' +
                              inActiveUserTasks[index].taskType);
                          if (inActiveUserTasks[index].taskType == 'Activity') {
                            taskObserver
                                .setCurrTaskIdForDetails(
                                    inActiveUserTasks[index].taskId)
                                .then((value) => taskObserver
                                    .changeScreen(TASK_SCREENS.TASK_DETAIL));
                          } else {
                            taskObserver
                                .setCurrTaskIdForDetails(
                                    inActiveUserTasks[index].taskId)
                                .then((value) => taskObserver.changeScreen(
                                    TASK_SCREENS
                                        .TASK_VIEW_COMPLETED_HEALTH_CHECK));
                          }

                          // taskObserver
                          //     .setCurrTaskIdForDetails(
                          //         inActiveUserTasks[index].taskId)
                          //     .then((value) => taskObserver.changeScreen(
                          //         TASK_SCREENS
                          //             .TASK_VIEW_COMPLETED_HEALTH_CHECK));
                          // if (onListItemClickCallBackFn != null) {
                          //   onListItemClickCallBackFn!.call();
                          // }
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                //color: setBackgroundColor(index),
                                border: Border.all(color: Colors.blue),
                                color: inActiveUserTasks
                                            .elementAt(index)
                                            .firstHealthCheckMood ==
                                        'Bad'
                                    ? Colors.yellow[100]
                                    : Colors.blueGrey[100],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Row(children: <Widget>[
                                  FaIcon(
                                      getIcon(inActiveUserTasks
                                          .elementAt(index)
                                          .icon),
                                      color: getIconColor(inActiveUserTasks
                                          .elementAt(index)
                                          .iconColor)),
                                  Text('   '),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        inActiveUserTasks
                                                    .elementAt(index)
                                                    .taskType ==
                                                'Health Check'
                                            ? 'Health Check'
                                            : inActiveUserTasks
                                                .elementAt(index)
                                                .name
                                                .substring(
                                                    0,
                                                    inActiveUserTasks
                                                                .elementAt(
                                                                    index)
                                                                .name
                                                                .length <
                                                            24
                                                        ? inActiveUserTasks
                                                            .elementAt(index)
                                                            .name
                                                            .length
                                                        : 24),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue[900]),
                                      ),
                                      Text(
                                        inActiveUserTasks
                                            .elementAt(index)
                                            .completedTaskDateTime
                                            .toString()
                                            .substring(0, 16),
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          // fontWeight: FontWeight.bold,
                                          // color: Colors.lightBlue[900],
                                        ),
                                      )
                                    ],
                                  ),
                                ]))),
                      ));
                    }),
              )
            ],
          ),
        )
      ],
    );
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
