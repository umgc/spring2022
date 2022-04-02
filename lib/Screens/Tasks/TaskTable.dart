import 'package:flutter/material.dart';
import 'package:memorez/Services/TaskService.dart';
import 'package:memorez/Utility/ThemeUtil.dart';
import 'package:memorez/generated/i18n.dart';
import 'package:provider/provider.dart';
import 'package:memorez/Model/Task.dart';
import 'package:memorez/Utility/Constant.dart';
import '../../Observables/SettingObservable.dart';
import '../../Observables/TaskObservable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class TaskTable extends StatefulWidget {
  @override
  State<TaskTable> createState() => _TaskTableState();
}

ValueNotifier<bool> inactiveTasksUpdated = ValueNotifier(false);

class _TaskTableState extends State<TaskTable> {
  @override
  Widget build(BuildContext context) {
    final taskObserver = Provider.of<TaskObserver>(context);
    final settingObserver = Provider.of<SettingObserver>(context);
    inactiveTasksUpdated = taskObserver.inactiveTasksUpdated;
    taskObserver.resetCurrTaskIdForDetails();

    //var usersTask = taskObserver.usersTask;

    TextTaskService.loadTasks().then((tasks) =>
        {taskObserver.setTasks(tasks), taskObserver.setCheckList(tasks)});

    const TEXT_STYLE = TextStyle(fontSize: 20);
    const HEADER_TEXT_STYLE = const TextStyle(fontSize: 20);

    var rowHeight = (MediaQuery.of(context).size.height) /
        (taskObserver.careGiverModeEnabled ? 2 : 1);

    List<TextTask> activeUserTasks = <TextTask>[];
    List<TextTask> inActiveUserTasks = <TextTask>[];

    for (var i = 0; i < taskObserver.usersTask.length; i++) {
      print('send task datetime:' +
          taskObserver.usersTask[i].isTaskCompleted.toString());
      //if the task is completed
      if (taskObserver.usersTask[i].isTaskCompleted == true) {
        //we need to check the active task list and remove it if it's there
         activeUserTasks =
             checkActiveTasks(activeUserTasks, taskObserver.usersTask[i].taskId);

        // then add it to the list of inactive tasks
        inActiveUserTasks.add(taskObserver.usersTask[i]);
      } else {
        //otherwise
        //if the task is scheduled for a time before the current time
        if (taskObserver.usersTask[i].sendTaskDateTime
            .isBefore(DateTime.now())) {
          print('time now ' + DateTime.now().toString());
          print('time of task ' +
              taskObserver.usersTask[i].sendTaskDateTime.toString());
          activeUserTasks.add(taskObserver.usersTask[i]);
        } else {}
      }
    }
    // taskObserver.changeScreen(TASK_SCREENS.TASK);

    return Scaffold(
      backgroundColor: backgroundMode(settingObserver.userSettings.darkMode),
      body: ListView(children: [
        Column(
          children: [
            ///Column of active tasks
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      I18n.of(context)!.activeTasks,
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue[900]),
                    ),
                  ),
                  Container(
                      //height: rowHeight,
                      child: ValueListenableBuilder<bool>(
                          valueListenable: inactiveTasksUpdated,
                          builder: (context, value, _) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: activeUserTasks.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      child: InkWell(
                                          onTap: () {
                                            print('task id: ' +
                                                activeUserTasks[index].taskId);
                                            //if the task is an activity
                                            if (activeUserTasks[index]
                                                    .taskType ==
                                                'Activity') {
                                              //then send to the activity task completion area
                                              taskObserver
                                                  .setCurrTaskIdForDetails(
                                                      activeUserTasks[index]
                                                          .taskId)
                                                  .then((value) => taskObserver
                                                      .changeScreen(TASK_SCREENS
                                                          .TASK_COMPLETE_ACTIVITY));
                                            } else {
                                              //otherwise we know it is a health check
                                              taskObserver
                                                  .setCurrTaskIdForDetails(
                                                      activeUserTasks[index]
                                                          .taskId)
                                                  .then((value) => taskObserver
                                                      .changeScreen(TASK_SCREENS
                                                          .TASK_COMPLETE_HEALTH_CHECK));
                                            }

                                            // if (onListItemClickCallBackFn != null) {
                                            //   onListItemClickCallBackFn!.call();
                                            // }
                                          },
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.blue),
                                                  color: Colors.lightBlue[100],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Padding(
                                                  padding: EdgeInsets.all(15.0),
                                                  child: Row(children: <Widget>[
                                                    FaIcon(
                                                        getIcon(activeUserTasks
                                                            .elementAt(index)
                                                            .icon),
                                                        color: getIconColor(
                                                            activeUserTasks
                                                                .elementAt(
                                                                    index)
                                                                .iconColor)),
                                                    Text('   '),
                                                    Text(
                                                      activeUserTasks
                                                                  .elementAt(
                                                                      index)
                                                                  .taskType ==
                                                              'Health Check'
                                                          ? 'Health Check'
                                                          : activeUserTasks.elementAt(index).name.substring(
                                                              0,
                                                              activeUserTasks
                                                                          .elementAt(
                                                                              index)
                                                                          .name
                                                                          .length <
                                                                      25
                                                                  ? activeUserTasks
                                                                      .elementAt(
                                                                          index)
                                                                      .name
                                                                      .length
                                                                  : 25),
                                                      style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .lightBlue[900]),
                                                    )
                                                  ])))));
                                });
                          })),
                ]),

            ///Column of completed tasks
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
                      I18n.of(context)!.completedTasks,
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue[900]),
                    ),
                  ),
                  Container(
                      //height: rowHeight,
                      child: ValueListenableBuilder<bool>(
                          valueListenable: inactiveTasksUpdated,
                          builder: (context, value, _) {
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: inActiveUserTasks.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      child: InkWell(
                                    //This runs when double tapping an Active Task
                                    onTap: () {
                                      print('task id: ' +
                                          inActiveUserTasks[index].taskId);
                                      print('task type selected = ' +
                                          inActiveUserTasks[index].taskType);
                                      if (inActiveUserTasks[index].taskType ==
                                          'Activity') {
                                        taskObserver
                                            .setCurrTaskIdForDetails(
                                                inActiveUserTasks[index].taskId)
                                            .then((value) =>
                                                taskObserver.changeScreen(
                                                    TASK_SCREENS.TASK_DETAIL));
                                      } else {
                                        taskObserver
                                            .setCurrTaskIdForDetails(
                                                inActiveUserTasks[index].taskId)
                                            .then((value) => taskObserver
                                                .changeScreen(TASK_SCREENS
                                                    .TASK_VIEW_COMPLETED_HEALTH_CHECK));
                                      }
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                            //color: setBackgroundColor(index),
                                            border:
                                                Border.all(color: Colors.blue),
                                            color: inActiveUserTasks
                                                        .elementAt(index)
                                                        .firstHealthCheckMood ==
                                                    'Bad'
                                                ? Colors.yellow[100]
                                                : Colors.blueGrey[100],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: Row(children: <Widget>[
                                              FaIcon(
                                                  getIcon(inActiveUserTasks
                                                      .elementAt(index)
                                                      .icon),
                                                  color: getIconColor(
                                                      inActiveUserTasks
                                                          .elementAt(index)
                                                          .iconColor)),
                                              Text('   '),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    inActiveUserTasks
                                                                .elementAt(
                                                                    index)
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
                                                                        .elementAt(
                                                                            index)
                                                                        .name
                                                                        .length
                                                                    : 24),
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .lightBlue[900]),
                                                  ),
                                                  Text(
                                                    timeago.format(inActiveUserTasks
                                                        .elementAt(index)
                                                        .completedTaskDateTime!),
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
                                });
                          })),
                ],
              ),
            ),
          ],
        )
      ]),
      floatingActionButton: Padding(
          padding: EdgeInsets.only(left: 30),
          child: Container(
            child: buildFloatingBtn(taskObserver),
          )),
    );
  }

}
List<TextTask> checkActiveTasks(List<TextTask> activeUserTasks, String taskId) {
  if (activeUserTasks.length > 0) {
    for (var i = 0; i < activeUserTasks.length; i++) {
      if (activeUserTasks[i].taskId == taskId) {
        activeUserTasks.removeAt(i);
        return activeUserTasks;
      }
    }
  }
  return activeUserTasks;
}

///Icon support function
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

///Colors Support Function
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

///Function returns Floating button
Widget buildFloatingBtn(TaskObserver taskObserver) {
  return Visibility(
    visible: taskObserver.careGiverModeEnabled,
    child: FloatingActionButton(
      onPressed: () {
        taskObserver.changeScreen(TASK_SCREENS.ADD_TASK);
      },
      tooltip: 'Add Task',
      child: Icon(Icons.add),
    ),
  );
}
